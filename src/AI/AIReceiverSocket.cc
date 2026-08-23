#include "AIReceiverSocket.h"

#include <QtCore/QJsonDocument>
#include <QtCore/QJsonObject>
#include <QtCore/QJsonArray>
#include <QtCore/QJsonValue>
#include <QtCore/QRandomGenerator>
#include <QtNetwork/QNetworkDatagram>

AIReceiverSocket::AIReceiverSocket(quint16 port, QObject *parent)
    : QObject(parent)
    , _port(port)
{
    connect(&_simTimer, &QTimer::timeout, this, &AIReceiverSocket::_generateSimulatedData);
}

void AIReceiverSocket::setSimulationMode(bool enabled)
{
    _simulationMode = enabled;
    if (_simulationMode) {
        if (!_simTimer.isActive()) {
            _simTimer.start(33); // ~30 FPS
        }
    } else {
        _simTimer.stop();
    }
}

void AIReceiverSocket::setPort(quint16 port)
{
    _port = port;
}

void AIReceiverSocket::startListening()
{
    if (!_socket) {
        _socket = new QUdpSocket(this);
        connect(_socket, &QUdpSocket::readyRead, this, &AIReceiverSocket::_processPendingDatagrams);
    }

    if (_socket->state() == QAbstractSocket::UnconnectedState) {
        _socket->bind(QHostAddress::AnyIPv4, _port, QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);
    }

    if (_simulationMode && !_simTimer.isActive()) {
        _simTimer.start(33);
    }
}

void AIReceiverSocket::stopListening()
{
    _simTimer.stop();
    if (_socket) {
        _socket->close();
    }
}

void AIReceiverSocket::_processPendingDatagrams()
{
    if (!_socket) return;

    while (_socket->hasPendingDatagrams()) {
        const QNetworkDatagram datagram = _socket->receiveDatagram();
        const QByteArray data = datagram.data();
        if (!data.isEmpty()) {
            if (_simulationMode) {
                _simulationMode = false;
                _simTimer.stop();
            }
            _parsePayload(data);
        }
    }
}

void AIReceiverSocket::_parsePayload(const QByteArray &datagram)
{
    QJsonParseError parseError;
    const QJsonDocument doc = QJsonDocument::fromJson(datagram, &parseError);
    if (parseError.error != QJsonParseError::NoError || !doc.isObject()) {
        return;
    }

    const QJsonObject rootObj = doc.object();

    // 1. Parse Detections (YOLO format support: center-xywh, xyxy, and xywh)
    if (rootObj.contains(QStringLiteral("detections")) && rootObj[QStringLiteral("detections")].isArray()) {
        const QJsonArray detArray = rootObj[QStringLiteral("detections")].toArray();
        QList<AIDetectionRawData> detections;
        detections.reserve(detArray.size());

        for (const QJsonValue &val : detArray) {
            if (!val.isObject()) continue;
            const QJsonObject detObj = val.toObject();

            AIDetectionRawData det;
            det.targetId = detObj.value(QStringLiteral("id")).toInt(detObj.value(QStringLiteral("track_id")).toInt(1));
            det.className = detObj.value(QStringLiteral("class")).toString(detObj.value(QStringLiteral("name")).toString(QStringLiteral("Object")));
            det.confidence = detObj.value(QStringLiteral("confidence")).toDouble(detObj.value(QStringLiteral("conf")).toDouble(0.9));
            det.trackingStatus = detObj.value(QStringLiteral("status")).toString(QStringLiteral("TRACKING"));

            // Parse YOLO bbox format
            if (detObj.contains(QStringLiteral("box")) && detObj[QStringLiteral("box")].isArray()) {
                const QJsonArray boxArray = detObj[QStringLiteral("box")].toArray();
                if (boxArray.size() >= 4) {
                    const double b0 = boxArray[0].toDouble(0.0);
                    const double b1 = boxArray[1].toDouble(0.0);
                    const double b2 = boxArray[2].toDouble(0.1);
                    const double b3 = boxArray[3].toDouble(0.1);

                    // Check if YOLO format is [center_x, center_y, width, height]
                    if (detObj.value(QStringLiteral("format")).toString() == QStringLiteral("xywh_center")) {
                        det.width = b2;
                        det.height = b3;
                        det.x = b0 - (b2 / 2.0);
                        det.y = b1 - (b3 / 2.0);
                    }
                    // Check if YOLO format is [x1, y1, x2, y2]
                    else if (detObj.value(QStringLiteral("format")).toString() == QStringLiteral("xyxy")) {
                        det.x = b0;
                        det.y = b1;
                        det.width = b2 - b0;
                        det.height = b3 - b1;
                    }
                    // Default normalized top-left [x, y, w, h]
                    else {
                        det.x = b0;
                        det.y = b1;
                        det.width = b2;
                        det.height = b3;
                    }
                }
            } else {
                det.x = detObj.value(QStringLiteral("x")).toDouble(0.0);
                det.y = detObj.value(QStringLiteral("y")).toDouble(0.0);
                det.width = detObj.value(QStringLiteral("w")).toDouble(0.1);
                det.height = detObj.value(QStringLiteral("h")).toDouble(0.1);
            }

            detections.append(det);
        }

        emit detectionsReceived(detections);
    }

    // 2. Parse Performance Telemetry
    if (rootObj.contains(QStringLiteral("performance")) && rootObj[QStringLiteral("performance")].isObject()) {
        const QJsonObject perfObj = rootObj[QStringLiteral("performance")].toObject();
        AIPerformanceMetrics metrics;
        metrics.inferenceFps = perfObj.value(QStringLiteral("inference_fps")).toDouble(30.0);
        metrics.streamFps = perfObj.value(QStringLiteral("stream_fps")).toDouble(60.0);
        metrics.preProcessLatencyMs = perfObj.value(QStringLiteral("latency_pre_ms")).toDouble(2.5);
        metrics.inferenceLatencyMs = perfObj.value(QStringLiteral("latency_inf_ms")).toDouble(25.0);
        metrics.postProcessLatencyMs = perfObj.value(QStringLiteral("latency_post_ms")).toDouble(3.5);
        metrics.totalLatencyMs = metrics.preProcessLatencyMs + metrics.inferenceLatencyMs + metrics.postProcessLatencyMs;

        if (rootObj.contains(QStringLiteral("hardware")) && rootObj[QStringLiteral("hardware")].isObject()) {
            const QJsonObject hwObj = rootObj[QStringLiteral("hardware")].toObject();
            metrics.cpuUsagePercent = hwObj.value(QStringLiteral("cpu_usage_pct")).toDouble(25.0);
            metrics.gpuUsagePercent = hwObj.value(QStringLiteral("gpu_usage_pct")).toDouble(70.0);
            metrics.ramUsageMB = hwObj.value(QStringLiteral("ram_usage_mb")).toDouble(320.0);
            metrics.hardwareBackend = hwObj.value(QStringLiteral("engine_backend")).toString(QStringLiteral("YOLOv8 NPU / OpenCL"));
        }

        emit performanceMetricsReceived(metrics);
    }
}

void AIReceiverSocket::_generateSimulatedData()
{
    _simAngle += 0.03;
    if (_simAngle > 2.0 * M_PI) {
        _simAngle -= 2.0 * M_PI;
    }

    QList<AIDetectionRawData> detections;

    // Simulated Target 1: Vehicle (YOLO Detection)
    AIDetectionRawData t1;
    t1.targetId = 101;
    t1.className = QStringLiteral("Vehicle");
    t1.confidence = 0.94 + 0.04 * std::sin(_simAngle * 3.0);
    t1.x = std::clamp(0.40 + 0.18 * std::cos(_simAngle), 0.05, 0.85);
    t1.y = std::clamp(0.40 + 0.12 * std::sin(_simAngle * 1.5), 0.05, 0.85);
    t1.width = 0.14;
    t1.height = 0.10;
    t1.trackingStatus = QStringLiteral("LOCKED");
    detections.append(t1);

    // Simulated Target 2: Person (YOLO Detection)
    AIDetectionRawData t2;
    t2.targetId = 102;
    t2.className = QStringLiteral("Person");
    t2.confidence = 0.88 + 0.06 * std::cos(_simAngle * 2.0);
    t2.x = std::clamp(0.60 + 0.10 * std::sin(_simAngle * 0.8), 0.05, 0.85);
    t2.y = std::clamp(0.55 + 0.14 * std::cos(_simAngle * 1.2), 0.05, 0.85);
    t2.width = 0.07;
    t2.height = 0.15;
    t2.trackingStatus = QStringLiteral("TRACKING");
    detections.append(t2);

    // Simulated Target 3: Boat (Maritime AI)
    AIDetectionRawData t3;
    t3.targetId = 201;
    t3.className = QStringLiteral("Boat");
    t3.confidence = 0.92;
    t3.x = std::clamp(0.20 + 0.05 * std::cos(_simAngle * 0.5), 0.05, 0.9);
    t3.y = std::clamp(0.70 + 0.05 * std::sin(_simAngle * 0.5), 0.05, 0.9);
    t3.width = 0.15;
    t3.height = 0.08;
    t3.trackingStatus = QStringLiteral("TRACKING");
    detections.append(t3);

    emit detectionsReceived(detections);

    // Simulated Performance Telemetry
    AIPerformanceMetrics metrics;
    const double noise = (QRandomGenerator::global()->bounded(100) - 50) / 100.0;
    metrics.inferenceFps = 31.5 + noise * 1.2;
    metrics.streamFps = 60.0;
    metrics.preProcessLatencyMs = 2.2 + noise * 0.3;
    metrics.inferenceLatencyMs = 24.5 + noise * 1.5;
    metrics.postProcessLatencyMs = 3.4 + noise * 0.4;
    metrics.totalLatencyMs = metrics.preProcessLatencyMs + metrics.inferenceLatencyMs + metrics.postProcessLatencyMs;
    metrics.cpuUsagePercent = 26.0 + noise * 3.0;
    metrics.gpuUsagePercent = 74.0 + noise * 4.0;
    metrics.ramUsageMB = 335.0 + noise * 5.0;
    metrics.hardwareBackend = QStringLiteral("YOLOv8 NPU (Qualcomm)");
    metrics.activeModelName = QStringLiteral("YOLOv8s-FP16 (General)");
    metrics.detectedObjectsCount = detections.size();

    emit performanceMetricsReceived(metrics);
}
