import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls
import QGroundControl.AI

Rectangle {
    id: root
    width: ScreenTools.defaultFontPixelWidth * 34
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    color: Qt.rgba(0.04, 0.07, 0.12, 0.96)
    border.color: "#00E5FF"
    border.width: 1

    signal closeRequested()

    ScrollView {
        anchors.fill: parent
        anchors.margins: ScreenTools.defaultFontPixelWidth * 0.8
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: ScreenTools.defaultFontPixelHeight * 0.7

            // Header Title
            RowLayout {
                Layout.fillWidth: true

                QGCLabel {
                    text: qsTr("TACTICAL AI CONTROL")
                    font.bold: true
                    font.pointSize: ScreenTools.defaultFontPointSize
                    color: "#00E5FF"
                    Layout.fillWidth: true
                }

                QGCButton {
                    text: qsTr("✕")
                    onClicked: root.closeRequested()
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Qt.rgba(0, 0.9, 1, 0.3)
            }

            // 1. Engine Power Control
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                QGCLabel {
                    text: qsTr("1. AI ENGINE STATUS")
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize
                    color: "#E0E0E0"
                }

                RowLayout {
                    Layout.fillWidth: true

                    QGCButton {
                        Layout.fillWidth: true
                        text: qsTr("ONLINE")
                        primary: QGCAIController.engineEnabled
                        onClicked: QGCAIController.setEngineEnabled(true)
                    }

                    QGCButton {
                        Layout.fillWidth: true
                        text: qsTr("STANDBY")
                        primary: !QGCAIController.engineEnabled
                        onClicked: QGCAIController.setEngineEnabled(false)
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Qt.rgba(1, 1, 1, 0.1)
            }

            // 2. Video Palette / Vision Shaders
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                QGCLabel {
                    text: qsTr("2. VISION PALETTE / SHADERS")
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize
                    color: "#E0E0E0"
                }

                GridLayout {
                    Layout.fillWidth: true
                    columns: 2
                    rowSpacing: 4
                    columnSpacing: 4

                    QGCButton {
                        Layout.fillWidth: true
                        text: qsTr("Normal RGB")
                        primary: QGCAIController.videoPalette === QGCAIController.NORMAL
                        onClicked: QGCAIController.setVideoPalette(QGCAIController.NORMAL)
                    }

                    QGCButton {
                        Layout.fillWidth: true
                        text: qsTr("Night Vision")
                        primary: QGCAIController.videoPalette === QGCAIController.NIGHT_VISION
                        onClicked: QGCAIController.setVideoPalette(QGCAIController.NIGHT_VISION)
                    }

                    QGCButton {
                        Layout.fillWidth: true
                        text: qsTr("Ironbow Thermal")
                        primary: QGCAIController.videoPalette === QGCAIController.IRONBOW
                        onClicked: QGCAIController.setVideoPalette(QGCAIController.IRONBOW)
                    }

                    QGCButton {
                        Layout.fillWidth: true
                        text: qsTr("White-Hot")
                        primary: QGCAIController.videoPalette === QGCAIController.WHITE_HOT
                        onClicked: QGCAIController.setVideoPalette(QGCAIController.WHITE_HOT)
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Qt.rgba(1, 1, 1, 0.1)
            }

            // 3. AI Model Selection
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                QGCLabel {
                    text: qsTr("3. ACTIVE YOLO MODEL")
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize
                    color: "#E0E0E0"
                }

                Repeater {
                    model: QGCAIController.availableModels

                    QGCButton {
                        Layout.fillWidth: true
                        text: modelData
                        primary: QGCAIController.activeModel === modelData
                        onClicked: QGCAIController.switchModel(modelData)
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Qt.rgba(1, 1, 1, 0.1)
            }

            // 4. Autonomous Tracking & Guided Actions
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 6

                QGCLabel {
                    text: qsTr("4. AUTONOMOUS GUEST ACTIONS")
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize
                    color: "#E0E0E0"
                }

                QGCCheckBox {
                    text: qsTr("Gimbal Auto-Tracking")
                    checked: QGCAIController.autoGimbalTracking
                    onClicked: QGCAIController.setAutoGimbalTracking(checked)
                }

                QGCCheckBox {
                    text: qsTr("Optical Auto-Zoom Target")
                    checked: QGCAIController.autoZoomEnabled
                    onClicked: QGCAIController.setAutoZoomEnabled(checked)
                }

                RowLayout {
                    Layout.fillWidth: true
                    enabled: QGCAIController.lockedTargetId >= 0

                    QGCButton {
                        Layout.fillWidth: true
                        text: qsTr("🚁 FLY TO TARGET")
                        onClicked: QGCAIController.flyToTarget(QGCAIController.lockedTargetId)
                    }

                    QGCButton {
                        Layout.fillWidth: true
                        text: qsTr("🔄 ORBIT TARGET")
                        onClicked: QGCAIController.orbitTarget(QGCAIController.lockedTargetId, 30.0)
                    }
                }

                QGCButton {
                    Layout.fillWidth: true
                    text: qsTr("📸 CAPTURE TARGET EVIDENCE")
                    enabled: QGCAIController.lockedTargetId >= 0
                    onClicked: QGCAIController.captureTargetEvidence(QGCAIController.lockedTargetId)
                }

                QGCButton {
                    Layout.fillWidth: true
                    text: QGCAIController.lockedTargetId >= 0 ? qsTr("UNLOCK TARGET #%1").arg(QGCAIController.lockedTargetId) : qsTr("NO TARGET LOCKED")
                    enabled: QGCAIController.lockedTargetId >= 0
                    onClicked: QGCAIController.unlockTarget()
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Qt.rgba(1, 1, 1, 0.1)
            }

            // 5. Sensitivity Threshold Slider
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                RowLayout {
                    Layout.fillWidth: true
                    QGCLabel {
                        text: qsTr("5. CONFIDENCE THRESHOLD")
                        font.bold: true
                        font.pointSize: ScreenTools.smallFontPointSize
                        color: "#E0E0E0"
                        Layout.fillWidth: true
                    }
                    QGCLabel {
                        text: qsTr("%1%").arg(Math.round(QGCAIController.confidenceThreshold * 100))
                        font.bold: true
                        font.pointSize: ScreenTools.smallFontPointSize
                        color: "#00E5FF"
                    }
                }

                Slider {
                    Layout.fillWidth: true
                    from: 0.20
                    to: 0.95
                    stepSize: 0.05
                    value: QGCAIController.confidenceThreshold
                    onMoved: QGCAIController.setConfidenceThreshold(value)
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Qt.rgba(1, 1, 1, 0.1)
            }

            // 6. Action Triggers & Tactical Voice
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 6

                QGCLabel {
                    text: qsTr("6. TRIGGER ACTIONS & VOICE")
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize
                    color: "#E0E0E0"
                }

                QGCCheckBox {
                    text: qsTr("Tactical Voice Announcer")
                    checked: QGCAIController.soundAlarmOnDetect
                    onClicked: QGCAIController.setSoundAlarmOnDetect(checked)
                }

                QGCCheckBox {
                    text: qsTr("Auto-Snapshot on Detection")
                    checked: QGCAIController.autoSnapshotOnDetect
                    onClicked: QGCAIController.setAutoSnapshotOnDetect(checked)
                }

                QGCCheckBox {
                    text: qsTr("Auto Geo-Tag Target on Map")
                    checked: QGCAIController.autoGeoTagOnDetect
                    onClicked: QGCAIController.setAutoGeoTagOnDetect(checked)
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Qt.rgba(1, 1, 1, 0.1)
            }

            // 7. Mobile & Display Field Settings
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 6

                QGCLabel {
                    text: qsTr("7. MOBILE FIELD DISPLAY")
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize
                    color: "#E0E0E0"
                }

                QGCCheckBox {
                    text: qsTr("☀️ Sunlight High-Contrast Mode")
                    checked: QGCAIController.sunlightHighContrast
                    onClicked: QGCAIController.setSunlightHighContrast(checked)
                }

                QGCCheckBox {
                    text: qsTr("🔒 Keep Screen ON (Anti-Sleep)")
                    checked: QGCAIController.keepScreenOn
                    onClicked: QGCAIController.setKeepScreenOn(checked)
                }
            }
        }
    }
}
