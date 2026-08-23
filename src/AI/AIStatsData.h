#pragma once

#include <QtCore/QString>
#include <QtCore/QStringList>

/// Data structure holding comprehensive AI engine performance telemetry and hardware stats.
struct AIPerformanceMetrics {
    double inferenceFps         = 0.0;
    double streamFps            = 60.0;
    double preProcessLatencyMs  = 0.0;
    double inferenceLatencyMs   = 0.0;
    double postProcessLatencyMs = 0.0;
    double totalLatencyMs       = 0.0;
    double cpuUsagePercent      = 0.0;
    double gpuUsagePercent      = 0.0;
    double ramUsageMB           = 0.0;
    double deviceTemperatureC   = 0.0;
    QString thermalState        = QStringLiteral("NORMAL");
    QString hardwareBackend     = QStringLiteral("Qualcomm NPU / OpenCL");
    QString activeModelName     = QStringLiteral("YOLOv8s-FP16 (General)");
    int detectedObjectsCount    = 0;
};

/// Raw detection box data transferred from the AI engine.
struct AIDetectionRawData {
    int targetId                = -1;
    QString className;
    double confidence           = 0.0;
    double x                    = 0.0; // Normalized 0.0 - 1.0
    double y                    = 0.0; // Normalized 0.0 - 1.0
    double width                = 0.0; // Normalized 0.0 - 1.0
    double height               = 0.0; // Normalized 0.0 - 1.0
    QString trackingStatus      = QStringLiteral("TRACKING"); // "TRACKING", "LOCKED", "LOST"
};
