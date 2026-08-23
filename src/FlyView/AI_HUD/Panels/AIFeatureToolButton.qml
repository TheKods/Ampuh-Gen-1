import QtQuick
import QtQuick.Controls

import QGroundControl
import QGroundControl.Controls
import QGroundControl.AI

Rectangle {
    id: root
    width: Math.max(ScreenTools.defaultFontPixelWidth * 12, ScreenTools.minTouchPixels)
    height: Math.max(ScreenTools.defaultFontPixelHeight * 2.2, ScreenTools.minTouchPixels)
    radius: height / 2
    color: drawerOpen ? "#00E5FF" : Qt.rgba(0.08, 0.12, 0.18, 0.9)
    border.color: "#00E5FF"
    border.width: 1.5

    property bool drawerOpen: false
    signal toggleDrawer()

    Row {
        anchors.centerIn: parent
        spacing: 6

        QGCLabel {
            text: qsTr("AI CONTROLS")
            font.bold: true
            font.pointSize: ScreenTools.smallFontPointSize * 0.8
            color: root.drawerOpen ? "#000000" : "#00E5FF"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.drawerOpen = !root.drawerOpen
            root.toggleDrawer()
        }
    }
}
