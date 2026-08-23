#pragma once

#include <QtCore/QObject>
#include <QtCore/QTimer>
#include <QtCore/QString>

class AndroidSystemMonitor : public QObject
{
    Q_OBJECT

public:
    explicit AndroidSystemMonitor(QObject *parent = nullptr);
    ~AndroidSystemMonitor() override = default;

    [[nodiscard]] double cpuUsagePercent() const { return _cpuUsagePercent; }
    [[nodiscard]] double ramUsageMB() const { return _ramUsageMB; }
    [[nodiscard]] double deviceTemperatureC() const { return _deviceTemperatureC; }
    [[nodiscard]] QString thermalState() const { return _thermalState; }

    void startMonitoring(int intervalMs = 1000);
    void stopMonitoring();

    void vibrate(int durationMs = 50);
    void setKeepScreenOn(bool enable);

signals:
    void metricsUpdated(double cpuUsagePercent, double ramUsageMB, double temperatureC, const QString &thermalState);

private slots:
    void _sampleSystemMetrics();

private:
    void _sampleLinuxMetrics();
    void _sampleFallbackMetrics();

    QTimer _sampleTimer;
    double _cpuUsagePercent = 0.0;
    double _ramUsageMB = 0.0;
    double _deviceTemperatureC = 38.5;
    QString _thermalState = QStringLiteral("NORMAL");

    unsigned long long _prevUser = 0;
    unsigned long long _prevNice = 0;
    unsigned long long _prevSystem = 0;
    unsigned long long _prevIdle = 0;
};
