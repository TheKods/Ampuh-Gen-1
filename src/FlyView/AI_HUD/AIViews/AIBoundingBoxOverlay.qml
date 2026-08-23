import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls
import QGroundControl.AI

Item {
    id: root
    anchors.fill: parent
    clip: true

    property real videoWidth: parent.width
    property real videoHeight: parent.height

    // 1. Thermal & Night Vision Shader Filter Overlay
    Rectangle {
        anchors.fill: parent
        visible: QGCAIController.videoPalette !== QGCAIController.NORMAL
        opacity: 0.35

        color: {
            switch (QGCAIController.videoPalette) {
            case QGCAIController.NIGHT_VISION: return "#00FF44"
            case QGCAIController.IRONBOW: return "#FF3D00"
            case QGCAIController.WHITE_HOT: return "#FFFFFF"
            case QGCAIController.BLACK_HOT: return "#000000"
            default: return "transparent"
            }
        }
    }

    // 2. Tactical Bounding Boxes
    Repeater {
        model: QGCAIController.detectionBoxes

        Item {
            id: boxItem
            x: modelData.x * root.videoWidth
            y: modelData.y * root.videoHeight
            width: Math.max(modelData.width * root.videoWidth, 36)
            height: Math.max(modelData.height * root.videoHeight, 36)
            visible: QGCAIController.engineEnabled

            readonly property bool isLocked: modelData.isLocked
            readonly property color boxColor: modelData.boxColorHex
            readonly property real cornerLen: Math.min(width, height) * 0.28

            // Tactical Corner Brackets
            Canvas {
                id: cornerCanvas
                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)

                    ctx.strokeStyle = boxItem.boxColor
                    ctx.lineWidth = boxItem.isLocked ? 3.0 : 2.0
                    var cl = boxItem.cornerLen

                    // Top-Left
                    ctx.beginPath()
                    ctx.moveTo(0, cl)
                    ctx.lineTo(0, 0)
                    ctx.lineTo(cl, 0)
                    ctx.stroke()

                    // Top-Right
                    ctx.beginPath()
                    ctx.moveTo(width - cl, 0)
                    ctx.lineTo(width, 0)
                    ctx.lineTo(width, cl)
                    ctx.stroke()

                    // Bottom-Right
                    ctx.beginPath()
                    ctx.moveTo(width, height - cl)
                    ctx.lineTo(width, height)
                    ctx.lineTo(width - cl, height)
                    ctx.stroke()

                    // Bottom-Left
                    ctx.beginPath()
                    ctx.moveTo(cl, height)
                    ctx.lineTo(0, height)
                    ctx.lineTo(0, height - cl)
                    ctx.stroke()
                }

                Connections {
                    target: boxItem
                    function onIsLockedChanged() { cornerCanvas.requestPaint() }
                    function onBoxColorChanged() { cornerCanvas.requestPaint() }
                    function onWidthChanged() { cornerCanvas.requestPaint() }
                    function onHeightChanged() { cornerCanvas.requestPaint() }
                }
            }

            // Target Crosshair Reticle when Locked
            Item {
                anchors.centerIn: parent
                width: 20
                height: 20
                visible: boxItem.isLocked

                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width
                    height: 2
                    color: "#FF3B30"
                }
                Rectangle {
                    anchors.centerIn: parent
                    width: 2
                    height: parent.height
                    color: "#FF3B30"
                }
                Rectangle {
                    anchors.centerIn: parent
                    width: 8
                    height: 8
                    radius: 4
                    color: "transparent"
                    border.color: "#FF3B30"
                    border.width: 1.5
                }
            }

            // Top-Left Tactical Label Tag
            Rectangle {
                anchors.bottom: parent.top
                anchors.left: parent.left
                anchors.bottomMargin: 3
                height: ScreenTools.defaultFontPixelHeight * 1.35
                width: tagRow.width + ScreenTools.defaultFontPixelWidth * 0.8
                radius: 3
                color: Qt.rgba(0.04, 0.07, 0.10, 0.90)
                border.color: boxItem.boxColor
                border.width: 1

                Row {
                    id: tagRow
                    anchors.centerIn: parent
                    spacing: 4

                    Rectangle {
                        width: 6
                        height: 6
                        radius: 3
                        color: boxItem.boxColor
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    QGCLabel {
                        text: qsTr("%1 #%2 [%3%]").arg(modelData.className).arg(modelData.targetId).arg(Math.round(modelData.confidence * 100))
                        font.pointSize: ScreenTools.smallFontPointSize * 0.85
                        font.bold: true
                        color: boxItem.boxColor
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            // Bottom-Right Range & Speed Badge
            Rectangle {
                anchors.top: parent.bottom
                anchors.right: parent.right
                anchors.topMargin: 3
                height: ScreenTools.defaultFontPixelHeight * 1.15
                width: rangeRow.width + ScreenTools.defaultFontPixelWidth * 0.6
                radius: 2
                color: Qt.rgba(0.04, 0.07, 0.10, 0.90)
                border.color: boxItem.boxColor
                border.width: 1
                visible: modelData.rangeMeters > 0

                Row {
                    id: rangeRow
                    anchors.centerIn: parent
                    spacing: 4

                    QGCLabel {
                        text: qsTr("RNG: %1m | %2 km/h").arg(Math.round(modelData.rangeMeters)).arg(Math.round(modelData.estimatedSpeedKmh))
                        font.pointSize: ScreenTools.smallFontPointSize * 0.72
                        font.bold: true
                        color: boxItem.boxColor
                    }
                }
            }

            // Floating Action Buttons on Locked Target (Fly To / Orbit)
            Row {
                anchors.bottom: parent.top
                anchors.right: parent.right
                anchors.bottomMargin: 3
                spacing: 4
                visible: boxItem.isLocked

                Rectangle {
                    width: ScreenTools.defaultFontPixelWidth * 6
                    height: ScreenTools.defaultFontPixelHeight * 1.3
                    radius: 3
                    color: "#FF3B30"

                    QGCLabel {
                        anchors.centerIn: parent
                        text: qsTr("FLY TO")
                        font.bold: true
                        font.pointSize: ScreenTools.smallFontPointSize * 0.7
                        color: "#FFFFFF"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: QGCAIController.flyToTarget(modelData.targetId)
                    }
                }

                Rectangle {
                    width: ScreenTools.defaultFontPixelWidth * 6
                    height: ScreenTools.defaultFontPixelHeight * 1.3
                    radius: 3
                    color: "#00E5FF"

                    QGCLabel {
                        anchors.centerIn: parent
                        text: qsTr("ORBIT")
                        font.bold: true
                        font.pointSize: ScreenTools.smallFontPointSize * 0.7
                        color: "#000000"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: QGCAIController.orbitTarget(modelData.targetId, 30.0)
                    }
                }
            }

            // Touch Area to Lock/Unlock Target
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (boxItem.isLocked) {
                        QGCAIController.unlockTarget()
                    } else {
                        QGCAIController.lockTargetById(modelData.targetId)
                    }
                }
            }
        }
    }
}
