import QtQuick
import QtQuick.Controls

import QGroundControl
import QGroundControl.Controls

Item {
    id: root
    anchors.fill: parent

    property var vehicle: QGroundControl.multiVehicleManager.activeVehicle

    readonly property double pitchAngle: (vehicle && vehicle.pitch) ? vehicle.pitch.rawValue : 0.0
    readonly property double rollAngle: (vehicle && vehicle.roll) ? vehicle.roll.rawValue : 0.0
    readonly property double headingAngle: (vehicle && vehicle.heading) ? vehicle.heading.rawValue : 0.0

    // Rotating Horizon & Pitch Ladder Container
    Item {
        id: horizonContainer
        anchors.centerIn: parent
        width: Math.min(parent.width, parent.height) * 0.7
        height: width
        rotation: -root.rollAngle
        clip: true

        // Pitch Ladder
        Item {
            id: pitchLadder
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            y: (parent.height / 2) + (root.pitchAngle * (parent.height / 60.0))

            // Center Horizon Line
            Rectangle {
                anchors.centerIn: parent
                width: parent.width * 0.8
                height: 2
                color: "#00FF66"
            }

            // Pitch Ticks Repeater (+30 to -30 degrees)
            Repeater {
                model: [-30, -20, -10, 10, 20, 30]

                Item {
                    anchors.centerIn: parent
                    y: (parent.height / 2) - (modelData * (parent.height / 60.0))
                    width: parent.width * 0.4
                    height: 2

                    Rectangle {
                        anchors.left: parent.left
                        width: parent.width * 0.4
                        height: 2
                        color: "#00FF66"
                    }

                    QGCLabel {
                        anchors.centerIn: parent
                        text: qsTr("%1").arg(Math.abs(modelData))
                        font.bold: true
                        font.pointSize: ScreenTools.smallFontPointSize * 0.75
                        color: "#00FF66"
                    }

                    Rectangle {
                        anchors.right: parent.right
                        width: parent.width * 0.4
                        height: 2
                        color: "#00FF66"
                    }
                }
            }
        }
    }

    // Fixed Aircraft Center Reticle
    Item {
        anchors.centerIn: parent
        width: 60
        height: 20

        // Left Wing
        Rectangle {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 20
            height: 3
            color: "#FFFF00"
        }
        // Center Dot
        Rectangle {
            anchors.centerIn: parent
            width: 6
            height: 6
            radius: 3
            color: "#FFFF00"
        }
        // Right Wing
        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 20
            height: 3
            color: "#FFFF00"
        }
    }

    // Top Compass Tape Header
    Rectangle {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: ScreenTools.defaultFontPixelHeight * 1.5
        width: ScreenTools.defaultFontPixelWidth * 24
        height: ScreenTools.defaultFontPixelHeight * 1.6
        radius: 4
        color: Qt.rgba(0, 0, 0, 0.7)
        border.color: "#00FF66"
        border.width: 1

        QGCLabel {
            anchors.centerIn: parent
            text: qsTr("HDG: %1°").arg(Math.round(root.headingAngle < 0 ? root.headingAngle + 360 : root.headingAngle))
            font.bold: true
            font.pointSize: ScreenTools.smallFontPointSize
            color: "#00FF66"
        }
    }
}
