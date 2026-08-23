import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls
import QGroundControl.AI

Rectangle {
    id: root
    width: ScreenTools.defaultFontPixelWidth * 32
    implicitHeight: mainCol.height + ScreenTools.defaultFontPixelHeight * 0.8
    radius: ScreenTools.defaultFontPixelWidth * 0.8
    color: Qt.rgba(0.04, 0.07, 0.12, 0.88)
    border.color: "#00E5FF"
    border.width: 1

    ColumnLayout {
        id: mainCol
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: ScreenTools.defaultFontPixelWidth * 0.8
        spacing: ScreenTools.defaultFontPixelHeight * 0.35

        // Header Title Bar
        RowLayout {
            Layout.fillWidth: true

            Rectangle {
                width: 8
                height: 8
                radius: 4
                color: QGCAIController.engineEnabled ? "#00FF66" : "#FF3B30"
                Layout.alignment: Qt.AlignVCenter
            }

            QGCLabel {
                text: qsTr("AI ENGINE TELEMETRY")
                font.bold: true
                font.pointSize: ScreenTools.smallFontPointSize
                color: "#00E5FF"
                Layout.fillWidth: true
            }

            QGCLabel {
                text: qsTr("%1 TARGETS").arg(QGCAIController.detectedCount)
                font.bold: true
                font.pointSize: ScreenTools.smallFontPointSize * 0.85
                color: "#FFFFFF"
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: Qt.rgba(0, 0.9, 1, 0.3)
        }

        // Active Model & Backend
        QGCLabel {
            text: qsTr("MODEL: %1").arg(QGCAIController.activeModel)
            font.pointSize: ScreenTools.smallFontPointSize * 0.8
            color: "#E0E0E0"
            Layout.fillWidth: true
            elide: Text.ElideRight
        }

        QGCLabel {
            text: qsTr("NPU ENGINE: %1").arg(QGCAIController.hardwareBackend)
            font.pointSize: ScreenTools.smallFontPointSize * 0.75
            color: "#80DEEA"
            Layout.fillWidth: true
            elide: Text.ElideRight
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: Qt.rgba(1, 1, 1, 0.1)
        }

        // FPS Metrics
        RowLayout {
            Layout.fillWidth: true

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 1
                QGCLabel {
                    text: qsTr("INFERENCE FPS")
                    font.pointSize: ScreenTools.smallFontPointSize * 0.7
                    color: "#A0A0A0"
                }
                QGCLabel {
                    text: qsTr("%1 FPS").arg(QGCAIController.inferenceFps.toFixed(1))
                    font.bold: true
                    font.pointSize: ScreenTools.defaultFontPointSize
                    color: QGCAIController.inferenceFps >= 24 ? "#00FF66" : "#FFCC00"
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 1
                QGCLabel {
                    text: qsTr("CAMERA STREAM")
                    font.pointSize: ScreenTools.smallFontPointSize * 0.7
                    color: "#A0A0A0"
                }
                QGCLabel {
                    text: qsTr("%1 FPS").arg(QGCAIController.streamFps.toFixed(1))
                    font.bold: true
                    font.pointSize: ScreenTools.defaultFontPointSize
                    color: "#00E5FF"
                }
            }
        }

        // Latency Breakdown
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            RowLayout {
                Layout.fillWidth: true
                QGCLabel {
                    text: qsTr("TOTAL LATENCY")
                    font.pointSize: ScreenTools.smallFontPointSize * 0.7
                    color: "#A0A0A0"
                    Layout.fillWidth: true
                }
                QGCLabel {
                    text: qsTr("%1 ms").arg(QGCAIController.totalLatencyMs.toFixed(1))
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize * 0.9
                    color: QGCAIController.totalLatencyMs < 40 ? "#00FF66" : (QGCAIController.totalLatencyMs < 75 ? "#FFCC00" : "#FF3B30")
                }
            }

            QGCLabel {
                text: qsTr("Pre: %1ms | Inf: %2ms | Post: %3ms")
                    .arg(QGCAIController.preProcessLatencyMs.toFixed(1))
                    .arg(QGCAIController.inferenceLatencyMs.toFixed(1))
                    .arg(QGCAIController.postProcessLatencyMs.toFixed(1))
                font.pointSize: ScreenTools.smallFontPointSize * 0.75
                color: "#B0BEC5"
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: Qt.rgba(1, 1, 1, 0.1)
        }

        // Hardware Resource Telemetry
        GridLayout {
            Layout.fillWidth: true
            columns: 2
            rowSpacing: 4
            columnSpacing: 8

            // CPU Usage
            RowLayout {
                spacing: 4
                QGCLabel {
                    text: qsTr("CPU:")
                    font.pointSize: ScreenTools.smallFontPointSize * 0.75
                    color: "#A0A0A0"
                }
                QGCLabel {
                    text: qsTr("%1%").arg(Math.round(QGCAIController.cpuUsagePercent))
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize * 0.8
                    color: QGCAIController.cpuUsagePercent > 80 ? "#FF3B30" : "#E0E0E0"
                }
            }

            // GPU/NPU Usage
            RowLayout {
                spacing: 4
                QGCLabel {
                    text: qsTr("NPU/GPU:")
                    font.pointSize: ScreenTools.smallFontPointSize * 0.75
                    color: "#A0A0A0"
                }
                QGCLabel {
                    text: qsTr("%1%").arg(Math.round(QGCAIController.gpuUsagePercent))
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize * 0.8
                    color: "#00E5FF"
                }
            }

            // RAM Usage
            RowLayout {
                spacing: 4
                QGCLabel {
                    text: qsTr("RAM:")
                    font.pointSize: ScreenTools.smallFontPointSize * 0.75
                    color: "#A0A0A0"
                }
                QGCLabel {
                    text: qsTr("%1 MB").arg(Math.round(QGCAIController.ramUsageMB))
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize * 0.8
                    color: "#E0E0E0"
                }
            }

            // Device Thermal
            RowLayout {
                spacing: 4
                QGCLabel {
                    text: qsTr("THERMAL:")
                    font.pointSize: ScreenTools.smallFontPointSize * 0.75
                    color: "#A0A0A0"
                }
                QGCLabel {
                    text: qsTr("%1 (%2°C)").arg(QGCAIController.thermalState).arg(Math.round(QGCAIController.deviceTemperatureC))
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize * 0.75
                    color: QGCAIController.thermalState === "THROTTLING" ? "#FF3B30" : (QGCAIController.thermalState === "WARM" ? "#FFCC00" : "#00FF66")
                }
            }
        }
    }
}
