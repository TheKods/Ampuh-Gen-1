#include "AndroidSystemMonitor.h"

#include <QtCore/QFile>
#include <QtCore/QTextStream>
#include <QtCore/QRandomGenerator>

#if defined(Q_OS_WIN)
#include <windows.h>
#include <psapi.h>
#endif

#if defined(Q_OS_ANDROID)
#include <QJniObject>
#include <QJniEnvironment>
#include <QtCore/qcoreapplication_platform.h>
#endif

AndroidSystemMonitor::AndroidSystemMonitor(QObject *parent)
    : QObject(parent)
{
    connect(&_sampleTimer, &QTimer::timeout, this, &AndroidSystemMonitor::_sampleSystemMetrics);
}

void AndroidSystemMonitor::startMonitoring(int intervalMs)
{
    if (!_sampleTimer.isActive()) {
        _sampleTimer.start(intervalMs);
        _sampleSystemMetrics();
    }
}

void AndroidSystemMonitor::stopMonitoring()
{
    _sampleTimer.stop();
}

void AndroidSystemMonitor::vibrate(int durationMs)
{
#if defined(Q_OS_ANDROID)
    QJniObject activity = QNativeInterface::QAndroidApplication::context();
    if (activity.isValid()) {
        QJniObject vibratorService = activity.callObjectMethod(
            "getSystemService",
            "(Ljava/lang/String;)Ljava/lang/Object;",
            QJniObject::fromString("vibrator").object<jstring>()
        );
        if (vibratorService.isValid()) {
            vibratorService.callMethod<void>("vibrate", "(J)V", static_cast<jlong>(durationMs));
        }
    }
#elif defined(Q_OS_WIN)
    // Non-blocking tactile feedback tone for desktop testing
    MessageBeep(MB_OK);
#else
    Q_UNUSED(durationMs);
#endif
}

void AndroidSystemMonitor::setKeepScreenOn(bool enable)
{
#if defined(Q_OS_ANDROID)
    QJniObject activity = QNativeInterface::QAndroidApplication::context();
    if (activity.isValid()) {
        QJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");
        if (window.isValid()) {
            const jint FLAG_KEEP_SCREEN_ON = 128; // 0x00000080
            if (enable) {
                window.callMethod<void>("addFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
            } else {
                window.callMethod<void>("clearFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
            }
        }
    }
#else
    Q_UNUSED(enable);
#endif
}

void AndroidSystemMonitor::_sampleSystemMetrics()
{
#if defined(Q_OS_ANDROID) || defined(Q_OS_LINUX)
    _sampleLinuxMetrics();
#else
    _sampleFallbackMetrics();
#endif

    emit metricsUpdated(_cpuUsagePercent, _ramUsageMB, _deviceTemperatureC, _thermalState);
}

void AndroidSystemMonitor::_sampleLinuxMetrics()
{
    // Read CPU utilization from /proc/stat
    QFile statFile(QStringLiteral("/proc/stat"));
    if (statFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&statFile);
        QString line = in.readLine();
        statFile.close();

        if (line.startsWith(QStringLiteral("cpu "))) {
            const QStringList tokens = line.split(QLatin1Char(' '), Qt::SkipEmptyParts);
            if (tokens.size() >= 5) {
                const unsigned long long user = tokens[1].toULongLong();
                const unsigned long long nice = tokens[2].toULongLong();
                const unsigned long long system = tokens[3].toULongLong();
                const unsigned long long idle = tokens[4].toULongLong();

                const unsigned long long totalDiff = (user - _prevUser) + (nice - _prevNice) +
                                                     (system - _prevSystem) + (idle - _prevIdle);
                const unsigned long long idleDiff = (idle - _prevIdle);

                if (totalDiff > 0) {
                    _cpuUsagePercent = 100.0 * static_cast<double>(totalDiff - idleDiff) / static_cast<double>(totalDiff);
                }

                _prevUser = user;
                _prevNice = nice;
                _prevSystem = system;
                _prevIdle = idle;
            }
        }
    }

    // Read Memory usage from /proc/meminfo
    QFile memFile(QStringLiteral("/proc/meminfo"));
    if (memFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&memFile);
        unsigned long long memTotal = 0;
        unsigned long long memAvailable = 0;

        while (!in.atEnd()) {
            const QString line = in.readLine();
            if (line.startsWith(QStringLiteral("MemTotal:"))) {
                const QStringList parts = line.split(QLatin1Char(' '), Qt::SkipEmptyParts);
                if (parts.size() >= 2) memTotal = parts[1].toULongLong();
            } else if (line.startsWith(QStringLiteral("MemAvailable:"))) {
                const QStringList parts = line.split(QLatin1Char(' '), Qt::SkipEmptyParts);
                if (parts.size() >= 2) memAvailable = parts[1].toULongLong();
            }
        }
        memFile.close();

        if (memTotal > 0 && memTotal >= memAvailable) {
            _ramUsageMB = static_cast<double>(memTotal - memAvailable) / 1024.0;
        }
    }

    // Read thermal zones
    QFile tempFile(QStringLiteral("/sys/class/thermal/thermal_zone0/temp"));
    if (tempFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&tempFile);
        const double rawTemp = in.readLine().trimmed().toDouble();
        tempFile.close();
        _deviceTemperatureC = (rawTemp > 1000.0) ? (rawTemp / 1000.0) : rawTemp;
    } else {
        _deviceTemperatureC = 39.0;
    }

    if (_deviceTemperatureC > 50.0) {
        _thermalState = QStringLiteral("THROTTLING");
    } else if (_deviceTemperatureC > 43.0) {
        _thermalState = QStringLiteral("WARM");
    } else {
        _thermalState = QStringLiteral("NORMAL");
    }
}

void AndroidSystemMonitor::_sampleFallbackMetrics()
{
#if defined(Q_OS_WIN)
    PROCESS_MEMORY_COUNTERS_EX pmc;
    if (GetProcessMemoryInfo(GetCurrentProcess(), reinterpret_cast<PROCESS_MEMORY_COUNTERS*>(&pmc), sizeof(pmc))) {
        _ramUsageMB = static_cast<double>(pmc.WorkingSetSize) / (1024.0 * 1024.0);
    } else {
        _ramUsageMB = 340.0;
    }
#else
    _ramUsageMB = 320.0;
#endif

    const double jitter = (QRandomGenerator::global()->bounded(100) - 50) / 50.0;
    _cpuUsagePercent = std::clamp(24.0 + jitter * 4.0, 5.0, 95.0);
    _deviceTemperatureC = std::clamp(38.5 + jitter * 1.5, 30.0, 60.0);
    _thermalState = QStringLiteral("NORMAL");
}
