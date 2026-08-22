import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls
import Custom.Widgets

Item {
    id: customFlyViewRoot

    property var parentToolInsets
    property var totalToolInsets: _totalToolInsets
    property var mapControl

    readonly property string noGPS: qsTr("NO GPS")
    readonly property real   indicatorValueWidth: ScreenTools.defaultFontPixelWidth * 7

    property var    _activeVehicle:   QGroundControl.multiVehicleManager.activeVehicle
    property real   _indicatorDiameter: ScreenTools.defaultFontPixelWidth * 18
    property real   _indicatorsHeight: ScreenTools.defaultFontPixelHeight
    property var    _sepColor:        qgcPal.globalTheme === QGCPalette.Light ? Qt.rgba(0,0,0,0.3) : Qt.rgba(1,1,1,0.2)
    property color  _indicatorsColor: qgcPal.text
    property bool   _isVehicleGps:    _activeVehicle ? _activeVehicle.gps.count.rawValue > 1 && _activeVehicle.gps.hdop.rawValue < 2.0 : false
    property string _altitude:        _activeVehicle ? (isNaN(_activeVehicle.altitudeRelative.value) ? "0.0" : _activeVehicle.altitudeRelative.value.toFixed(1)) + ' ' + _activeVehicle.altitudeRelative.units : "0.0 m"
    property string _groundSpeed:     _activeVehicle ? (isNaN(_activeVehicle.groundSpeed.value) ? "0.0" : _activeVehicle.groundSpeed.value.toFixed(1)) + ' ' + _activeVehicle.groundSpeed.units : "0.0 m/s"
    property string _distanceStr:     isNaN(_distance) ? "0 m" : _distance.toFixed(0) + ' ' + QGroundControl.unitsConversion.appSettingsHorizontalDistanceUnitsString
    property real   _heading:         _activeVehicle ? Math.round(_activeVehicle.heading.rawValue) : 0
    property real   _distance:        _activeVehicle ? _activeVehicle.distanceToHome.rawValue : 0
    property real   _batteryPercent:  _activeVehicle ? _activeVehicle.battery.percentRemaining.rawValue : 0
    property real   _batteryVoltage:  _activeVehicle ? _activeVehicle.battery.voltage.rawValue : 0
    property string _flightMode:      _activeVehicle ? _activeVehicle.flightMode : qsTr("DISCONNECTED")
    property bool   _armed:           _activeVehicle ? _activeVehicle.armed : false
    property real   _toolsMargin:     ScreenTools.defaultFontPixelWidth * 0.75

    QGCToolInsets {
        id: _totalToolInsets
        leftEdgeTopInset:       parentToolInsets.leftEdgeTopInset
        leftEdgeCenterInset:    parentToolInsets.leftEdgeCenterInset
        leftEdgeBottomInset:    parentToolInsets.leftEdgeBottomInset
        rightEdgeTopInset:      parentToolInsets.rightEdgeTopInset
        rightEdgeCenterInset:   parentToolInsets.rightEdgeCenterInset
        rightEdgeBottomInset:   parent.width - compassBackground.x
        topEdgeLeftInset:       parentToolInsets.topEdgeLeftInset
        topEdgeCenterInset:     compassBar.y + compassBar.height + _toolsMargin
        topEdgeRightInset:      parentToolInsets.topEdgeRightInset
        bottomEdgeLeftInset:    parentToolInsets.bottomEdgeLeftInset
        bottomEdgeCenterInset:  telemetryStatusBar.height + (_toolsMargin * 2)
        bottomEdgeRightInset:   parent.height - attitudeIndicator.y
    }

    //-------------------------------------------------------------------------
    // Top Compass Heading Ribbon (AMPUH Gen 1 Cyber HUD)
    //-------------------------------------------------------------------------
    Rectangle {
        id: compassBar
        height: ScreenTools.defaultFontPixelHeight * 1.8
        width: Math.min(parent.width * 0.45, ScreenTools.defaultFontPixelWidth * 48)
        anchors.top: parent.top
        anchors.topMargin: parentToolInsets.topEdgeCenterInset + _toolsMargin
        anchors.horizontalCenter: parent.horizontalCenter
        color: Qt.rgba(10/255, 15/255, 29/255, 0.85)
        border.color: "#00f0ff"
        border.width: 1
        radius: 4
        clip: true

        // Center Heading Marker
        Rectangle {
            anchors.centerIn: parent
            width: 2
            height: parent.height
            color: "#00f0ff"
            z: 2
        }

        Repeater {
            model: 24 // 0° to 345° in 15° steps
            QGCLabel {
                readonly property int _angle: modelData * 15
                readonly property real _degWidth: compassBar.width / 180 // 180° visible across the ribbon
                readonly property real _diff: {
                    var d = (_angle - _heading) % 360
                    if (d > 180) d -= 360
                    else if (d < -180) d += 360
                    return d
                }
                readonly property real _centerOffset: _diff * _degWidth

                anchors.verticalCenter: parent.verticalCenter
                x: (compassBar.width * 0.5) + _centerOffset - (width * 0.5)
                visible: Math.abs(_centerOffset) <= (compassBar.width * 0.5 + width)

                color: (_angle % 90 == 0) ? "#00f0ff" : (_angle % 45 == 0 ? "#38bdf8" : "#64748b")
                font.bold: _angle % 45 == 0
                font.pointSize: (_angle % 90 == 0) ? ScreenTools.defaultFontPointSize : ScreenTools.smallFontPointSize
                text: {
                    switch(_angle) {
                    case 0:   return "N"
                    case 45:  return "NE"
                    case 90:  return "E"
                    case 135: return "SE"
                    case 180: return "S"
                    case 225: return "SW"
                    case 270: return "W"
                    case 315: return "NW"
                    default:  return (_angle % 30 == 0) ? _angle.toString() : "|"
                    }
                }
            }
        }

        // Digital Heading Badge
        Rectangle {
            anchors.bottom: parent.top
            anchors.bottomMargin: 2
            anchors.horizontalCenter: parent.horizontalCenter
            width: ScreenTools.defaultFontPixelWidth * 6
            height: ScreenTools.defaultFontPixelHeight * 1.2
            color: "#0f172a"
            border.color: "#00f0ff"
            border.width: 1
            radius: 3
            z: 3

            QGCLabel {
                anchors.centerIn: parent
                text: _heading.toString().padStart(3, '0') + "°"
                color: "#00f0ff"
                font.bold: true
                font.pointSize: ScreenTools.smallFontPointSize
            }
        }
    }

    //-------------------------------------------------------------------------
    // Bottom Telemetry Quick Status Bar
    //-------------------------------------------------------------------------
    Rectangle {
        id: telemetryStatusBar
        anchors.bottom: parent.bottom
        anchors.bottomMargin: _toolsMargin
        anchors.horizontalCenter: parent.horizontalCenter
        height: ScreenTools.defaultFontPixelHeight * 2.2
        width: Math.min(parent.width * 0.65, ScreenTools.defaultFontPixelWidth * 70)
        color: Qt.rgba(10/255, 15/255, 29/255, 0.90)
        border.color: "#334155"
        border.width: 1
        radius: 6

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: ScreenTools.defaultFontPixelWidth
            anchors.rightMargin: ScreenTools.defaultFontPixelWidth
            spacing: ScreenTools.defaultFontPixelWidth * 1.5

            // Mode & Armed Status
            Rectangle {
                Layout.preferredHeight: parent.height * 0.7
                Layout.preferredWidth: modeLabel.contentWidth + ScreenTools.defaultFontPixelWidth * 1.5
                color: _armed ? "#064e3b" : "#7f1d1d"
                border.color: _armed ? "#10b981" : "#ef4444"
                border.width: 1
                radius: 4

                QGCLabel {
                    id: modeLabel
                    anchors.centerIn: parent
                    text: (_armed ? "ARMED: " : "DISARMED: ") + _flightMode
                    color: _armed ? "#6ee7b7" : "#fca5a5"
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize
                }
            }

            // Altitude Telemetry
            RowLayout {
                spacing: 4
                QGCLabel { text: "ALT:"; color: "#94a3b8"; font.pointSize: ScreenTools.smallFontPointSize }
                QGCLabel { text: _altitude; color: "#00f0ff"; font.bold: true; font.pointSize: ScreenTools.defaultFontPointSize }
            }

            // Speed Telemetry
            RowLayout {
                spacing: 4
                QGCLabel { text: "SPD:"; color: "#94a3b8"; font.pointSize: ScreenTools.smallFontPointSize }
                QGCLabel { text: _groundSpeed; color: "#00f0ff"; font.bold: true; font.pointSize: ScreenTools.defaultFontPointSize }
            }

            // Distance to Home
            RowLayout {
                spacing: 4
                QGCLabel { text: "DIST:"; color: "#94a3b8"; font.pointSize: ScreenTools.smallFontPointSize }
                QGCLabel { text: _distanceStr; color: "#f8fafc"; font.bold: true; font.pointSize: ScreenTools.defaultFontPointSize }
            }

            // Battery Status
            RowLayout {
                spacing: 4
                QGCLabel { text: "BAT:"; color: "#94a3b8"; font.pointSize: ScreenTools.smallFontPointSize }
                QGCLabel {
                    text: (_batteryPercent >= 0 ? _batteryPercent.toFixed(0) + "%" : "--%") + (_batteryVoltage > 0 ? " (" + _batteryVoltage.toFixed(1) + "V)" : "")
                    color: _batteryPercent > 30 ? "#10b981" : (_batteryPercent > 15 ? "#f59e0b" : "#ef4444")
                    font.bold: true
                    font.pointSize: ScreenTools.defaultFontPointSize
                }
            }
        }
    }

    //-------------------------------------------------------------------------
    // Tactical Mini Attitude & Compass (Bottom Right)
    //-------------------------------------------------------------------------
    Rectangle {
        id: compassBackground
        anchors.bottom: attitudeIndicator.bottom
        anchors.right: attitudeIndicator.left
        anchors.rightMargin: -attitudeIndicator.width / 2
        width: -anchors.rightMargin + compassBezel.width + (_toolsMargin * 2)
        height: attitudeIndicator.height * 0.8
        radius: 6
        color: Qt.rgba(15/255, 23/255, 42/255, 0.85)
        border.color: "#334155"
        border.width: 1

        Rectangle {
            id: compassBezel
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: _toolsMargin
            width: height
            height: parent.height - 16
            radius: height / 2
            border.color: "#38bdf8"
            border.width: 1.5
            color: "transparent"
        }

        Image {
            id: headingNeedle
            anchors.centerIn: compassBezel
            height: compassBezel.height * 0.75
            width: height
            source: "/custom/img/compass_needle.svg"
            fillMode: Image.PreserveAspectFit
            sourceSize.height: height
            transform: [
                Rotation {
                    origin.x: headingNeedle.width / 2
                    origin.y: headingNeedle.height / 2
                    angle: _heading
                }
            ]
        }
    }

    Rectangle {
        id: attitudeIndicator
        anchors.bottomMargin: _toolsMargin + parentToolInsets.bottomEdgeRightInset
        anchors.rightMargin: _toolsMargin
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        height: ScreenTools.defaultFontPixelHeight * 6.5
        width: height
        radius: height * 0.5
        color: Qt.rgba(15/255, 23/255, 42/255, 0.95)
        border.color: "#00f0ff"
        border.width: 1.5

        CustomAttitudeWidget {
            size: parent.height * 0.92
            vehicle: _activeVehicle
            showHeading: false
            anchors.centerIn: parent
        }
    }
}
