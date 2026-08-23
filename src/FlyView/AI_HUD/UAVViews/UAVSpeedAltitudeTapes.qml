import QtQuick
import QtQuick.Controls

import QGroundControl
import QGroundControl.Controls

Item {
    id: root
    anchors.fill: parent

    property var vehicle: QGroundControl.multiVehicleManager.activeVehicle

    readonly property double groundSpeed: (vehicle && vehicle.groundSpeed) ? vehicle.groundSpeed.rawValue : 0.0
    readonly property double altitudeRel: (vehicle && vehicle.altitudeRelative) ? vehicle.altitudeRelative.rawValue : 0.0

    // Left Speed Tape
    Rectangle {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: ScreenTools.defaultFontPixelWidth * 1.5
        width: ScreenTools.defaultFontPixelWidth * 8
        height: ScreenTools.defaultFontPixelHeight * 12
        radius: 4
        color: Qt.rgba(0, 0, 0, 0.7)
        border.color: "#00FF66"
        border.width: 1

        Column {
            anchors.centerIn: parent
            spacing: 4

            QGCLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("SPD")
                font.pointSize: ScreenTools.smallFontPointSize * 0.7
                color: "#A0A0A0"
            }

            QGCLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("%1").arg(root.groundSpeed.toFixed(1))
                font.bold: true
                font.pointSize: ScreenTools.defaultFontPointSize
                color: "#00FF66"
            }

            QGCLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("m/s")
                font.pointSize: ScreenTools.smallFontPointSize * 0.65
                color: "#A0A0A0"
            }
        }
    }

    // Right Altitude Tape
    Rectangle {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: ScreenTools.defaultFontPixelWidth * 1.5
        width: ScreenTools.defaultFontPixelWidth * 8
        height: ScreenTools.defaultFontPixelHeight * 12
        radius: 4
        color: Qt.rgba(0, 0, 0, 0.7)
        border.color: "#00FF66"
        border.width: 1

        Column {
            anchors.centerIn: parent
            spacing: 4

            QGCLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("ALT")
                font.pointSize: ScreenTools.smallFontPointSize * 0.7
                color: "#A0A0A0"
            }

            QGCLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("%1").arg(root.altitudeRel.toFixed(1))
                font.bold: true
                font.pointSize: ScreenTools.defaultFontPointSize
                color: "#00FF66"
            }

            QGCLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("m")
                font.pointSize: ScreenTools.smallFontPointSize * 0.65
                color: "#A0A0A0"
            }
        }
    }
}
