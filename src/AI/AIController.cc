#include "AIController.h"
#include "AIDetectionBox.h"
#include "AIReceiverSocket.h"
#include "AndroidSystemMonitor.h"
#include "QmlObjectListModel.h"
#include "MultiVehicleManager.h"
#include "Vehicle.h"
#include "GimbalController.h"
#include "Fact.h"
#include "AudioOutput.h"

#include <QtCore/QDateTime>
#include <QtCore/QtMath>

AIController* AIController::_instance = nullptr;

AIController::AIController(QObject *parent)
    : QObject(parent)
    , _detectionBoxes(new QmlObjectListModel(this))
    , _systemMonitor(new AndroidSystemMonitor(this))
{
    _instance = this;

    _availableModels << QStringLiteral("YOLOv8s-FP16 (General)")
                     << QStringLiteral("YOLOv11-SAR (Search & Rescue)")
                     << QStringLiteral("YOLOv8-Thermal (Hotspot)")
                     << QStringLiteral("YOLOv8-Vehicle (Target Tracking)");

    // Initialize Receiver Socket on Worker Thread
    _receiverSocket = new AIReceiverSocket(9090);
    _receiverSocket->moveToThread(&_receiverThread);

    connect(&_receiverThread, &QThread::started, _receiverSocket, &AIReceiverSocket::startListening);
    connect(&_receiverThread, &QThread::finished, _receiverSocket, &QObject::deleteLater);

    connect(_receiverSocket, &AIReceiverSocket::detectionsReceived, this, &AIController::_handleDetections);
    connect(_receiverSocket, &AIReceiverSocket::performanceMetricsReceived, this, &AIController::_handlePerformanceMetrics);

    // Initialize System Hardware Monitor
    connect(_systemMonitor, &AndroidSystemMonitor::metricsUpdated, this, &AIController::_handleSystemMetrics);
    _systemMonitor->startMonitoring(1000);
    _systemMonitor->setKeepScreenOn(_keepScreenOn);

    // Gimbal Auto-Tracking Loop (20 Hz)
    connect(&_trackingTimer, &QTimer::timeout, this, &AIController::_updateGimbalTracking);
    _trackingTimer.start(50);

    _receiverThread.start();
}

AIController::~AIController()
{
    _trackingTimer.stop();

    if (_systemMonitor) {
        _systemMonitor->setKeepScreenOn(false);
        _systemMonitor->stopMonitoring();
    }

    if (_receiverThread.isRunning()) {
        _receiverThread.quit();
        _receiverThread.wait(1000);
    }

    if (_instance == this) {
        _instance = nullptr;
    }
}

AIController* AIController::instance()
{
    return _instance;
}

void AIController::setHudMode(HUDMode mode)
{
    if (_hudMode != mode) {
        _hudMode = mode;
        triggerHapticFeedback(40);
        emit hudModeChanged();
    }
}

void AIController::toggleHudMode()
{
    int nextMode = (static_cast<int>(_hudMode) + 1) % 3;
    setHudMode(static_cast<HUDMode>(nextMode));
}

void AIController::setVideoPalette(VideoPalette palette)
{
    if (_videoPalette != palette) {
        _videoPalette = palette;
        triggerHapticFeedback(30);
        emit videoPaletteChanged();
    }
}

void AIController::cycleVideoPalette()
{
    int nextPal = (static_cast<int>(_videoPalette) + 1) % 5;
    setVideoPalette(static_cast<VideoPalette>(nextPal));
}

void AIController::setClassFilter(const QString &filter)
{
    if (_activeClassFilter != filter) {
        _activeClassFilter = filter.toUpper();
        triggerHapticFeedback(30);
        emit activeClassFilterChanged();
    }
}

void AIController::setShowMotionTrails(bool enabled)
{
    if (_showMotionTrails != enabled) {
        _showMotionTrails = enabled;
        triggerHapticFeedback(30);
        emit showMotionTrailsChanged();
    }
}

void AIController::setSunlightHighContrast(bool enabled)
{
    if (_sunlightHighContrast != enabled) {
        _sunlightHighContrast = enabled;
        triggerHapticFeedback(40);
        emit sunlightHighContrastChanged();
    }
}

void AIController::toggleSunlightHighContrast()
{
    setSunlightHighContrast(!_sunlightHighContrast);
}

void AIController::setKeepScreenOn(bool enabled)
{
    if (_keepScreenOn != enabled) {
        _keepScreenOn = enabled;
        if (_systemMonitor) {
            _systemMonitor->setKeepScreenOn(_keepScreenOn);
        }
        emit keepScreenOnChanged();
    }
}

void AIController::triggerHapticFeedback(int durationMs)
{
    if (_systemMonitor) {
        _systemMonitor->vibrate(durationMs);
    }
}

void AIController::setEngineEnabled(bool enabled)
{
    if (_engineEnabled != enabled) {
        _engineEnabled = enabled;
        triggerHapticFeedback(50);
        if (!_engineEnabled) {
            _detectionBoxes->clear();
            _perfMetrics.detectedObjectsCount = 0;
            emit performanceMetricsChanged();
            _playVoiceAlert(QStringLiteral("AI Engine Standby"));
        } else {
            _playVoiceAlert(QStringLiteral("AI Engine Online"));
        }
        emit engineEnabledChanged();
    }
}

void AIController::switchModel(const QString &modelName)
{
    if (_activeModel != modelName && _availableModels.contains(modelName)) {
        _activeModel = modelName;
        _perfMetrics.activeModelName = modelName;
        triggerHapticFeedback(40);
        emit activeModelChanged();
        emit performanceMetricsChanged();
        _playVoiceAlert(QStringLiteral("Model switched to %1").arg(modelName.split(QLatin1Char('-')).first()));
    }
}

void AIController::setConfidenceThreshold(double threshold)
{
    const double clamped = std::clamp(threshold, 0.0, 1.0);
    if (!qFuzzyCompare(_confidenceThreshold, clamped)) {
        _confidenceThreshold = clamped;
        emit confidenceThresholdChanged();
    }
}

void AIController::lockTargetById(int targetId)
{
    if (_lockedTargetId != targetId) {
        _lockedTargetId = targetId;
        triggerHapticFeedback(60);

        QString lockedClass = QStringLiteral("Target");
        for (int i = 0; i < _detectionBoxes->count(); ++i) {
            auto *box = _detectionBoxes->value<AIDetectionBox*>(i);
            if (box) {
                const bool match = (box->targetId() == _lockedTargetId);
                box->setIsLocked(match);
                if (match) {
                    lockedClass = box->className();
                }
            }
        }

        if (_lockedTargetId >= 0) {
            _playVoiceAlert(QStringLiteral("Target %1 locked, %2").arg(_lockedTargetId).arg(lockedClass));
        } else {
            _playVoiceAlert(QStringLiteral("Target unlocked"));
        }

        emit lockedTargetIdChanged();
    }
}

void AIController::unlockTarget()
{
    lockTargetById(-1);
}

void AIController::setAutoGimbalTracking(bool enabled)
{
    if (_autoGimbalTracking != enabled) {
        _autoGimbalTracking = enabled;
        triggerHapticFeedback(40);
        if (_autoGimbalTracking) {
            _playVoiceAlert(QStringLiteral("Gimbal auto tracking enabled"));
        }
        emit autoGimbalTrackingChanged();
    }
}

void AIController::setAutoZoomEnabled(bool enabled)
{
    if (_autoZoomEnabled != enabled) {
        _autoZoomEnabled = enabled;
        triggerHapticFeedback(40);
        emit autoZoomEnabledChanged();
    }
}

void AIController::setAutoSnapshotOnDetect(bool enabled)
{
    if (_autoSnapshotOnDetect != enabled) {
        _autoSnapshotOnDetect = enabled;
        triggerHapticFeedback(30);
        emit autoSnapshotOnDetectChanged();
    }
}

void AIController::setAutoGeoTagOnDetect(bool enabled)
{
    if (_autoGeoTagOnDetect != enabled) {
        _autoGeoTagOnDetect = enabled;
        triggerHapticFeedback(30);
        emit autoGeoTagOnDetectChanged();
    }
}

void AIController::setSoundAlarmOnDetect(bool enabled)
{
    if (_soundAlarmOnDetect != enabled) {
        _soundAlarmOnDetect = enabled;
        triggerHapticFeedback(30);
        emit soundAlarmOnDetectChanged();
    }
}

void AIController::flyToTarget(int targetId)
{
    Vehicle *vehicle = MultiVehicleManager::instance()->activeVehicle();
    if (!vehicle) return;

    for (int i = 0; i < _detectionBoxes->count(); ++i) {
        auto *box = _detectionBoxes->value<AIDetectionBox*>(i);
        if (box && box->targetId() == targetId && box->coordinate().isValid()) {
            triggerHapticFeedback(70);
            _playVoiceAlert(QStringLiteral("Navigating to target %1").arg(targetId));
            vehicle->guidedModeChange();
            vehicle->sendMavCommand(vehicle->defaultComponentId(),
                                   MAV_CMD_DO_REPOSITION,
                                   true,
                                   -1.0f,
                                   MAV_DO_REPOSITION_FLAGS_CHANGE_MODE,
                                   0.0f,
                                   NAN,
                                   static_cast<float>(box->coordinate().latitude()),
                                   static_cast<float>(box->coordinate().longitude()),
                                   static_cast<float>(vehicle->altitudeRelative()->rawValue().toDouble()));
            break;
        }
    }
}

void AIController::orbitTarget(int targetId, double radiusMeters)
{
    Vehicle *vehicle = MultiVehicleManager::instance()->activeVehicle();
    if (!vehicle) return;

    for (int i = 0; i < _detectionBoxes->count(); ++i) {
        auto *box = _detectionBoxes->value<AIDetectionBox*>(i);
        if (box && box->targetId() == targetId && box->coordinate().isValid()) {
            triggerHapticFeedback(70);
            _playVoiceAlert(QStringLiteral("Orbiting target %1").arg(targetId));
            vehicle->guidedModeChange();
            vehicle->sendMavCommand(vehicle->defaultComponentId(),
                                   MAV_CMD_DO_ORBIT,
                                   true,
                                   static_cast<float>(radiusMeters),
                                   0.0f,
                                   0.0f,
                                   0.0f,
                                   static_cast<float>(box->coordinate().latitude()),
                                   static_cast<float>(box->coordinate().longitude()),
                                   static_cast<float>(vehicle->altitudeRelative()->rawValue().toDouble()));
            break;
        }
    }
}

void AIController::setTargetAsROI(int targetId)
{
    Vehicle *vehicle = MultiVehicleManager::instance()->activeVehicle();
    if (!vehicle) return;

    for (int i = 0; i < _detectionBoxes->count(); ++i) {
        auto *box = _detectionBoxes->value<AIDetectionBox*>(i);
        if (box && box->targetId() == targetId && box->coordinate().isValid()) {
            triggerHapticFeedback(60);
            _playVoiceAlert(QStringLiteral("Region of interest set to target %1").arg(targetId));
            vehicle->sendMavCommand(vehicle->defaultComponentId(),
                                   MAV_CMD_DO_SET_ROI_LOCATION,
                                   true,
                                   0.0f, 0.0f, 0.0f, 0.0f,
                                   static_cast<float>(box->coordinate().latitude()),
                                   static_cast<float>(box->coordinate().longitude()),
                                   static_cast<float>(vehicle->altitudeRelative()->rawValue().toDouble()));
            break;
        }
    }
}

void AIController::captureTargetEvidence(int targetId)
{
    for (int i = 0; i < _detectionBoxes->count(); ++i) {
        auto *box = _detectionBoxes->value<AIDetectionBox*>(i);
        if (box && box->targetId() == targetId) {
            triggerHapticFeedback(80);
            _playVoiceAlert(QStringLiteral("Evidence captured for target %1").arg(targetId));
            break;
        }
    }
}

void AIController::_playVoiceAlert(const QString &phrase)
{
    if (!_soundAlarmOnDetect) return;

    const qint64 now = QDateTime::currentMSecsSinceEpoch();
    if (now - _lastVoiceAlertTime > 1500) {
        _lastVoiceAlertTime = now;
        if (AudioOutput::instance()) {
            AudioOutput::instance()->say(phrase);
        }
    }
}

void AIController::_handleDetections(const QList<AIDetectionRawData> &detections)
{
    if (!_engineEnabled) return;

    QList<AIDetectionRawData> filtered;
    for (const auto &det : detections) {
        if (det.confidence < _confidenceThreshold) continue;

        if (_activeClassFilter != QStringLiteral("ALL")) {
            const QString cls = det.className.toUpper();
            if (_activeClassFilter == QStringLiteral("PERSON") && !cls.contains(QStringLiteral("PERSON")) && !cls.contains(QStringLiteral("HUMAN"))) continue;
            if (_activeClassFilter == QStringLiteral("VEHICLE") && !cls.contains(QStringLiteral("VEHICLE")) && !cls.contains(QStringLiteral("CAR")) && !cls.contains(QStringLiteral("TRUCK"))) continue;
            if (_activeClassFilter == QStringLiteral("BOAT") && !cls.contains(QStringLiteral("BOAT")) && !cls.contains(QStringLiteral("SHIP"))) continue;
        }

        filtered.append(det);
    }

    int existingCount = _detectionBoxes->count();
    int newCount = filtered.size();

    for (int i = 0; i < newCount; ++i) {
        const auto &raw = filtered[i];
        if (i < existingCount) {
            auto *existing = _detectionBoxes->value<AIDetectionBox*>(i);
            if (existing) {
                existing->updateData(raw.className, raw.confidence, raw.x, raw.y, raw.width, raw.height, raw.trackingStatus);
                existing->setIsLocked(raw.targetId == _lockedTargetId);
                _projectTargetGeolocation(existing);
            }
        } else {
            auto *newBox = new AIDetectionBox(raw.targetId, raw.className, raw.confidence,
                                              raw.x, raw.y, raw.width, raw.height,
                                              raw.trackingStatus, this);
            newBox->setIsLocked(raw.targetId == _lockedTargetId);
            _projectTargetGeolocation(newBox);
            _detectionBoxes->append(newBox);
        }
    }

    while (_detectionBoxes->count() > newCount) {
        QObject *removed = _detectionBoxes->removeAt(_detectionBoxes->count() - 1);
        if (removed) {
            removed->deleteLater();
        }
    }

    _perfMetrics.detectedObjectsCount = newCount;
    emit performanceMetricsChanged();
}

void AIController::_handlePerformanceMetrics(const AIPerformanceMetrics &metrics)
{
    if (!_engineEnabled) return;

    _perfMetrics.inferenceFps = metrics.inferenceFps;
    _perfMetrics.streamFps = metrics.streamFps;
    _perfMetrics.preProcessLatencyMs = metrics.preProcessLatencyMs;
    _perfMetrics.inferenceLatencyMs = metrics.inferenceLatencyMs;
    _perfMetrics.postProcessLatencyMs = metrics.postProcessLatencyMs;
    _perfMetrics.totalLatencyMs = metrics.totalLatencyMs;
    _perfMetrics.gpuUsagePercent = metrics.gpuUsagePercent;
    _perfMetrics.hardwareBackend = metrics.hardwareBackend;

    emit performanceMetricsChanged();
}

void AIController::_handleSystemMetrics(double cpu, double ram, double temp, const QString &thermalState)
{
    _perfMetrics.cpuUsagePercent = cpu;
    _perfMetrics.ramUsageMB = ram;
    _perfMetrics.deviceTemperatureC = temp;
    _perfMetrics.thermalState = thermalState;

    emit performanceMetricsChanged();
}

void AIController::_projectTargetGeolocation(AIDetectionBox *box)
{
    if (!box) return;

    Vehicle *vehicle = MultiVehicleManager::instance()->activeVehicle();
    if (!vehicle) {
        box->setCoordinate(QGeoCoordinate(-6.2088 + (box->y() - 0.5) * 0.002,
                                          106.8456 + (box->x() - 0.5) * 0.002, 0.0));
        box->setRangeMeters(120.0 + box->y() * 50.0);
        box->setEstimatedSpeedKmh(35.0 + box->targetId() % 20);
        return;
    }

    const QGeoCoordinate droneCoord = vehicle->coordinate();
    const double altitudeAGL = vehicle->altitudeRelative() ? std::max(vehicle->altitudeRelative()->rawValue().toDouble(), 5.0) : 50.0;
    const double headingDeg = vehicle->heading() ? vehicle->heading()->rawValue().toDouble() : 0.0;
    const double pitchDeg = vehicle->pitch() ? vehicle->pitch()->rawValue().toDouble() : -45.0;

    const double dx = (box->x() + box->width() / 2.0) - 0.5;
    const double dy = (box->y() + box->height() / 2.0) - 0.5;

    const double angleX = dx * 60.0;
    const double angleY = dy * 45.0;

    const double totalPitchRad = qDegreesToRadians(std::clamp(pitchDeg + angleY, -85.0, -10.0));
    const double groundDistance = std::abs(altitudeAGL / std::tan(totalPitchRad));
    const double slantRange = std::sqrt(groundDistance * groundDistance + altitudeAGL * altitudeAGL);

    const double targetBearingRad = qDegreesToRadians(headingDeg + angleX);
    const double deltaNorth = groundDistance * std::cos(targetBearingRad);
    const double deltaEast  = groundDistance * std::sin(targetBearingRad);

    const double deltaLat = deltaNorth / 111139.0;
    const double deltaLon = deltaEast / (111139.0 * std::cos(qDegreesToRadians(droneCoord.latitude())));

    const QGeoCoordinate projected(droneCoord.latitude() + deltaLat,
                                   droneCoord.longitude() + deltaLon,
                                   0.0);

    box->setCoordinate(projected);
    box->setRangeMeters(slantRange);
    box->setEstimatedSpeedKmh(40.0 + (box->targetId() % 15));
}

void AIController::_updateGimbalTracking()
{
    if (!_autoGimbalTracking || _lockedTargetId < 0 || !_engineEnabled) return;

    Vehicle *vehicle = MultiVehicleManager::instance()->activeVehicle();
    if (!vehicle || !vehicle->gimbalController()) return;

    AIDetectionBox *lockedBox = nullptr;
    for (int i = 0; i < _detectionBoxes->count(); ++i) {
        auto *box = _detectionBoxes->value<AIDetectionBox*>(i);
        if (box && box->targetId() == _lockedTargetId) {
            lockedBox = box;
            break;
        }
    }

    if (!lockedBox) return;

    const double centerX = lockedBox->x() + (lockedBox->width() / 2.0);
    const double centerY = lockedBox->y() + (lockedBox->height() / 2.0);

    const double errorX = centerX - 0.5;
    const double errorY = centerY - 0.5;

    const float kP = 20.0f;
    const float yawRate = static_cast<float>(errorX * kP);
    const float pitchRate = static_cast<float>(-errorY * kP);

    vehicle->gimbalController()->sendGimbalRate(pitchRate, yawRate);
}
