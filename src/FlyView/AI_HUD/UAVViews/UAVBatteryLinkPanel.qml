import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls

Rectangle {
    id: root
    width: ScreenTools.defaultFontPixelWidth * 42
    height: ScreenTools.defaultFontPixelHeight * 2.2
    radius: 6
    color: Qt.rgba(0.05, 0.08, 0.12, 0.85)
    border.color: "#00FF66"
    border.width: 1

    property var vehicle: QGroundControl.multiVehicleManager.activeVehicle

    readonly property string flightMode: vehicle ? vehicle.flightMode : qsTr("DISCONNECTED")
    readonly property int batteryPercent: (vehicle && vehicle.battery && vehicle.battery.percentRemaining) ? Math.round(vehicle.battery.percentRemaining.rawValue) : 0
    readonly property double batteryVoltage: (vehicle && vehicle.battery && vehicle.battery.voltage) ? vehicle.battery.voltage.rawValue : 0.0
    readonly property double climbRate: (vehicle && vehicle.climbRate) ? vehicle.climbRate.rawValue : 0.0
    readonly property double distToHome: (vehicle && vehicle.distanceToHome) ? vehicle.distanceToHome.rawValue : 0.0
    readonly property int satCount: (vehicle && vehicle.gps && vehicle.gps.count) ? vehicle.gps.count.rawValue : 0

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: ScreenTools.defaultFontPixelWidth
        anchors.rightMargin: ScreenTools.defaultFontPixelWidth
        spacing: ScreenTools.defaultFontPixelWidth

        // Flight Mode
        RowLayout {
            spacing: 4
            Rectangle {
                width: 6
                height: 6
                radius: 3
                color: root.vehicle ? "#00FF66" : "#FF3B30"
            }
            QGCLabel {
                text: root.flightMode
                font.bold: true
                font.pointSize: ScreenTools.smallFontPointSize * 0.85
                color: "#FFFFFF"
            }
        }

        Rectangle {
            width: 1
            height: parent.height * 0.6
            color: Qt.rgba(1, 1, 1, 0.2)
        }

        // Battery
        RowLayout {
            spacing: 4
            QGCLabel {
                text: qsTr("BAT:")
                font.pointSize: ScreenTools.smallFontPointSize * 0.75
                color: "#A0A0A0"
            }
            QGCLabel {
                text: qsTr("%1% (%2V)").arg(root.batteryPercent).arg(root.batteryVoltage.toFixed(1))
                font.bold: true
                font.pointSize: ScreenTools.smallFontPointSize * 0.85
                color: root.batteryPercent > 25 ? "#00FF66" : "#FF3B30"
            }
        }

        Rectangle {
            width: 1
            height: parent.height * 0.6
            color: Qt.rgba(1, 1, 1, 0.2)
        }

        // Climb Rate
        RowLayout {
            spacing: 4
            QGCLabel {
                text: qsTr("CLIMB:")
                font.pointSize: ScreenTools.smallFontPointSize * 0.75
                color: "#A0A0A0"
            }
            QGCLabel {
                text: qsTr("%1 m/s").arg(root.climbRate.toFixed(1))
                font.bold: true
                font.pointSize: ScreenTools.smallFontPointSize * 0.85
                color: "#E0E0E0"
            }
        }

        Rectangle {
            width: 1
            height: parent.height * 0.6
            color: Qt.rgba(1, 1, 1, 0.2)
        }

        // GPS & Distance
        RowLayout {
            spacing: 4
            QGCLabel {
                text: qsTr("GPS:")
                font.pointSize: ScreenTools.smallFontPointSize * 0.75
                color: "#A0A0A0"
            }
            QGCLabel {
                text: qsTr("%1 Sats | %2m").arg(root.satCount).arg(Math.round(root.distToHome))
                font.bold: true
                font.pointSize: ScreenTools.smallFontPointSize * 0.85
                color: "#00E5FF"
            }
        }
    }
}
