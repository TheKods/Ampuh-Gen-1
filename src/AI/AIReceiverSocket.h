#pragma once

#include <QtCore/QObject>
#include <QtCore/QList>
#include <QtCore/QTimer>
#include <QtNetwork/QUdpSocket>

#include "AIStatsData.h"

class AIReceiverSocket : public QObject
{
    Q_OBJECT

public:
    explicit AIReceiverSocket(quint16 port = 9090, QObject *parent = nullptr);
    ~AIReceiverSocket() override = default;

    [[nodiscard]] bool isSimulationMode() const { return _simulationMode; }
    void setSimulationMode(bool enabled);
    void setPort(quint16 port);

public slots:
    void startListening();
    void stopListening();

signals:
    void detectionsReceived(const QList<AIDetectionRawData> &detections);
    void performanceMetricsReceived(const AIPerformanceMetrics &metrics);

private slots:
    void _processPendingDatagrams();
    void _generateSimulatedData();

private:
    void _parsePayload(const QByteArray &datagram);

    quint16 _port = 9090;
    QUdpSocket *_socket = nullptr;
    QTimer _simTimer;
    bool _simulationMode = true;

    // Simulation animation state
    double _simAngle = 0.0;
};
