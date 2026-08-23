#pragma once

#include <QtCore/QObject>
#include <QtCore/QThread>
#include <QtCore/QTimer>
#include <QtCore/QStringList>
#include <QtPositioning/QGeoCoordinate>
#include <QtQmlIntegration/QtQmlIntegration>

#include "AIStatsData.h"

class QmlObjectListModel;
class AIReceiverSocket;
class AndroidSystemMonitor;

class AIController : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(QGCAIController)
    QML_SINGLETON
    Q_MOC_INCLUDE("QmlObjectListModel.h")

public:
    enum class HUDMode {
        AI_MODE = 0,
        UAV_MODE = 1,
        HYBRID_MODE = 2
    };
    Q_ENUM(HUDMode)

    enum class VideoPalette {
        NORMAL = 0,
        WHITE_HOT = 1,
        BLACK_HOT = 2,
        IRONBOW = 3,
        NIGHT_VISION = 4
    };
    Q_ENUM(VideoPalette)

    Q_PROPERTY(HUDMode hudMode READ hudMode WRITE setHudMode NOTIFY hudModeChanged)
    Q_PROPERTY(VideoPalette videoPalette READ videoPalette WRITE setVideoPalette NOTIFY videoPaletteChanged)
    Q_PROPERTY(bool engineEnabled READ isEngineEnabled WRITE setEngineEnabled NOTIFY engineEnabledChanged)
    Q_PROPERTY(QString activeModel READ activeModel WRITE switchModel NOTIFY activeModelChanged)
    Q_PROPERTY(QStringList availableModels READ availableModels CONSTANT)
    Q_PROPERTY(QString activeClassFilter READ activeClassFilter WRITE setClassFilter NOTIFY activeClassFilterChanged)
    Q_PROPERTY(double confidenceThreshold READ confidenceThreshold WRITE setConfidenceThreshold NOTIFY confidenceThresholdChanged)
    Q_PROPERTY(int lockedTargetId READ lockedTargetId WRITE lockTargetById NOTIFY lockedTargetIdChanged)
    Q_PROPERTY(bool autoGimbalTracking READ autoGimbalTracking WRITE setAutoGimbalTracking NOTIFY autoGimbalTrackingChanged)
    Q_PROPERTY(bool autoZoomEnabled READ autoZoomEnabled WRITE setAutoZoomEnabled NOTIFY autoZoomEnabledChanged)
    Q_PROPERTY(bool showMotionTrails READ showMotionTrails WRITE setShowMotionTrails NOTIFY showMotionTrailsChanged)
    Q_PROPERTY(double intrusionRadiusMeters READ intrusionRadiusMeters WRITE setIntrusionRadiusMeters NOTIFY intrusionRadiusMetersChanged)
    Q_PROPERTY(bool intrusionAlertActive READ intrusionAlertActive NOTIFY intrusionAlertActiveChanged)
    Q_PROPERTY(QString intrusionAlertMessage READ intrusionAlertMessage NOTIFY intrusionAlertActiveChanged)
    Q_PROPERTY(bool autoSnapshotOnDetect READ autoSnapshotOnDetect WRITE setAutoSnapshotOnDetect NOTIFY autoSnapshotOnDetectChanged)
    Q_PROPERTY(bool autoGeoTagOnDetect READ autoGeoTagOnDetect WRITE setAutoGeoTagOnDetect NOTIFY autoGeoTagOnDetectChanged)
    Q_PROPERTY(bool soundAlarmOnDetect READ soundAlarmOnDetect WRITE setSoundAlarmOnDetect NOTIFY soundAlarmOnDetectChanged)
    Q_PROPERTY(bool sunlightHighContrast READ sunlightHighContrast WRITE setSunlightHighContrast NOTIFY sunlightHighContrastChanged)
    Q_PROPERTY(bool keepScreenOn READ keepScreenOn WRITE setKeepScreenOn NOTIFY keepScreenOnChanged)
    Q_PROPERTY(QmlObjectListModel* detectionBoxes READ detectionBoxes CONSTANT)

    // Performance Telemetry Properties
    Q_PROPERTY(double inferenceFps READ inferenceFps NOTIFY performanceMetricsChanged)
    Q_PROPERTY(double streamFps READ streamFps NOTIFY performanceMetricsChanged)
    Q_PROPERTY(double preProcessLatencyMs READ preProcessLatencyMs NOTIFY performanceMetricsChanged)
    Q_PROPERTY(double inferenceLatencyMs READ inferenceLatencyMs NOTIFY performanceMetricsChanged)
    Q_PROPERTY(double postProcessLatencyMs READ postProcessLatencyMs NOTIFY performanceMetricsChanged)
    Q_PROPERTY(double totalLatencyMs READ totalLatencyMs NOTIFY performanceMetricsChanged)
    Q_PROPERTY(double cpuUsagePercent READ cpuUsagePercent NOTIFY performanceMetricsChanged)
    Q_PROPERTY(double gpuUsagePercent READ gpuUsagePercent NOTIFY performanceMetricsChanged)
    Q_PROPERTY(double ramUsageMB READ ramUsageMB NOTIFY performanceMetricsChanged)
    Q_PROPERTY(double deviceTemperatureC READ deviceTemperatureC NOTIFY performanceMetricsChanged)
    Q_PROPERTY(QString thermalState READ thermalState NOTIFY performanceMetricsChanged)
    Q_PROPERTY(QString hardwareBackend READ hardwareBackend NOTIFY performanceMetricsChanged)
    Q_PROPERTY(int detectedCount READ detectedCount NOTIFY performanceMetricsChanged)

public:
    explicit AIController(QObject *parent = nullptr);
    ~AIController() override;

    static AIController* instance();

    [[nodiscard]] HUDMode hudMode() const { return _hudMode; }
    [[nodiscard]] VideoPalette videoPalette() const { return _videoPalette; }
    [[nodiscard]] bool isEngineEnabled() const { return _engineEnabled; }
    [[nodiscard]] QString activeModel() const { return _activeModel; }
    [[nodiscard]] QStringList availableModels() const { return _availableModels; }
    [[nodiscard]] QString activeClassFilter() const { return _activeClassFilter; }
    [[nodiscard]] double confidenceThreshold() const { return _confidenceThreshold; }
    [[nodiscard]] int lockedTargetId() const { return _lockedTargetId; }
    [[nodiscard]] bool autoGimbalTracking() const { return _autoGimbalTracking; }
    [[nodiscard]] bool autoZoomEnabled() const { return _autoZoomEnabled; }
    [[nodiscard]] bool showMotionTrails() const { return _showMotionTrails; }
    [[nodiscard]] double intrusionRadiusMeters() const { return _intrusionRadiusMeters; }
    [[nodiscard]] bool intrusionAlertActive() const { return _intrusionAlertActive; }
    [[nodiscard]] QString intrusionAlertMessage() const { return _intrusionAlertMessage; }
    [[nodiscard]] bool autoSnapshotOnDetect() const { return _autoSnapshotOnDetect; }
    [[nodiscard]] bool autoGeoTagOnDetect() const { return _autoGeoTagOnDetect; }
    [[nodiscard]] bool soundAlarmOnDetect() const { return _soundAlarmOnDetect; }
    [[nodiscard]] bool sunlightHighContrast() const { return _sunlightHighContrast; }
    [[nodiscard]] bool keepScreenOn() const { return _keepScreenOn; }
    [[nodiscard]] QmlObjectListModel* detectionBoxes() const { return _detectionBoxes; }

    [[nodiscard]] double inferenceFps() const { return _perfMetrics.inferenceFps; }
    [[nodiscard]] double streamFps() const { return _perfMetrics.streamFps; }
    [[nodiscard]] double preProcessLatencyMs() const { return _perfMetrics.preProcessLatencyMs; }
    [[nodiscard]] double inferenceLatencyMs() const { return _perfMetrics.inferenceLatencyMs; }
    [[nodiscard]] double postProcessLatencyMs() const { return _perfMetrics.postProcessLatencyMs; }
    [[nodiscard]] double totalLatencyMs() const { return _perfMetrics.totalLatencyMs; }
    [[nodiscard]] double cpuUsagePercent() const { return _perfMetrics.cpuUsagePercent; }
    [[nodiscard]] double gpuUsagePercent() const { return _perfMetrics.gpuUsagePercent; }
    [[nodiscard]] double ramUsageMB() const { return _perfMetrics.ramUsageMB; }
    [[nodiscard]] double deviceTemperatureC() const { return _perfMetrics.deviceTemperatureC; }
    [[nodiscard]] QString thermalState() const { return _perfMetrics.thermalState; }
    [[nodiscard]] QString hardwareBackend() const { return _perfMetrics.hardwareBackend; }
    [[nodiscard]] int detectedCount() const { return _perfMetrics.detectedObjectsCount; }

    Q_INVOKABLE void setHudMode(HUDMode mode);
    Q_INVOKABLE void toggleHudMode();
    Q_INVOKABLE void setVideoPalette(VideoPalette palette);
    Q_INVOKABLE void cycleVideoPalette();
    Q_INVOKABLE void setClassFilter(const QString &filter);
    Q_INVOKABLE void setEngineEnabled(bool enabled);
    Q_INVOKABLE void switchModel(const QString &modelName);
    Q_INVOKABLE void setConfidenceThreshold(double threshold);
    Q_INVOKABLE void lockTargetById(int targetId);
    Q_INVOKABLE void unlockTarget();
    Q_INVOKABLE void cycleNextTarget();
    Q_INVOKABLE void setAutoGimbalTracking(bool enabled);
    Q_INVOKABLE void setAutoZoomEnabled(bool enabled);
    Q_INVOKABLE void setShowMotionTrails(bool enabled);
    Q_INVOKABLE void setIntrusionRadiusMeters(double radius);
    Q_INVOKABLE void dismissIntrusionAlert();
    Q_INVOKABLE void setAutoSnapshotOnDetect(bool enabled);
    Q_INVOKABLE void setAutoGeoTagOnDetect(bool enabled);
    Q_INVOKABLE void setSoundAlarmOnDetect(bool enabled);
    Q_INVOKABLE void setSunlightHighContrast(bool enabled);
    Q_INVOKABLE void toggleSunlightHighContrast();
    Q_INVOKABLE void setKeepScreenOn(bool enabled);
    Q_INVOKABLE void triggerHapticFeedback(int durationMs = 50);

    // Autonomous Flight Guided Actions to Target
    Q_INVOKABLE void flyToTarget(int targetId);
    Q_INVOKABLE void orbitTarget(int targetId, double radiusMeters = 30.0);
    Q_INVOKABLE void setTargetAsROI(int targetId);
    Q_INVOKABLE void captureTargetEvidence(int targetId);
    Q_INVOKABLE QString exportMissionReport();

signals:
    void hudModeChanged();
    void videoPaletteChanged();
    void engineEnabledChanged();
    void activeModelChanged();
    void activeClassFilterChanged();
    void confidenceThresholdChanged();
    void lockedTargetIdChanged();
    void autoGimbalTrackingChanged();
    void autoZoomEnabledChanged();
    void showMotionTrailsChanged();
    void intrusionRadiusMetersChanged();
    void intrusionAlertActiveChanged();
    void autoSnapshotOnDetectChanged();
    void autoGeoTagOnDetectChanged();
    void soundAlarmOnDetectChanged();
    void sunlightHighContrastChanged();
    void keepScreenOnChanged();
    void performanceMetricsChanged();

private slots:
    void _handleDetections(const QList<AIDetectionRawData> &detections);
    void _handlePerformanceMetrics(const AIPerformanceMetrics &metrics);
    void _handleSystemMetrics(double cpu, double ram, double temp, const QString &thermalState);
    void _updateGimbalTracking();

private:
    void _projectTargetGeolocation(class AIDetectionBox *box);
    void _checkPerimeterIntrusions();
    void _playVoiceAlert(const QString &phrase);

    static AIController *_instance;

    HUDMode _hudMode = HUDMode::AI_MODE;
    VideoPalette _videoPalette = VideoPalette::NORMAL;
    bool _engineEnabled = true;
    QString _activeModel = QStringLiteral("YOLOv8s-FP16 (General)");
    QStringList _availableModels;
    QString _activeClassFilter = QStringLiteral("ALL");
    double _confidenceThreshold = 0.60;
    int _lockedTargetId = -1;
    bool _autoGimbalTracking = false;
    bool _autoZoomEnabled = false;
    bool _showMotionTrails = true;
    double _intrusionRadiusMeters = 150.0;
    bool _intrusionAlertActive = false;
    QString _intrusionAlertMessage;
    bool _autoSnapshotOnDetect = false;
    bool _autoGeoTagOnDetect = false;
    bool _soundAlarmOnDetect = true;
    bool _sunlightHighContrast = false;
    bool _keepScreenOn = true;

    QmlObjectListModel *_detectionBoxes = nullptr;
    AIPerformanceMetrics _perfMetrics;

    QThread _receiverThread;
    AIReceiverSocket *_receiverSocket = nullptr;
    AndroidSystemMonitor *_systemMonitor = nullptr;
    QTimer _trackingTimer;
    qint64 _lastVoiceAlertTime = 0;
    qint64 _lastIntrusionTime = 0;
};
