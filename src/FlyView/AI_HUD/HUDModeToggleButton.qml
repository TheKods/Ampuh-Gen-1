import QtQuick
import QtQuick.Controls

import QGroundControl
import QGroundControl.Controls
import QGroundControl.AI

Rectangle {
    id: root
    width: ScreenTools.defaultFontPixelWidth * 14
    height: Math.max(ScreenTools.defaultFontPixelHeight * 2.2, ScreenTools.minTouchPixels)
    radius: height / 2
    color: Qt.rgba(0.08, 0.12, 0.18, 0.9)
    border.color: QGCAIController.hudMode === QGCAIController.AI_MODE ? "#00E5FF" : (QGCAIController.hudMode === QGCAIController.UAV_MODE ? "#00FF66" : "#FFCC00")
    border.width: 2

    readonly property string modeText: {
        switch (QGCAIController.hudMode) {
        case QGCAIController.AI_MODE: return qsTr("HUD: AI MODE")
        case QGCAIController.UAV_MODE: return qsTr("HUD: UAV MODE")
        case QGCAIController.HYBRID_MODE: return qsTr("HUD: HYBRID")
        default: return qsTr("HUD MODE")
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: 6

        Rectangle {
            width: 8
            height: 8
            radius: 4
            color: root.border.color
            anchors.verticalCenter: parent.verticalCenter
        }

        QGCLabel {
            text: root.modeText
            font.bold: true
            font.pointSize: ScreenTools.smallFontPointSize * 0.85
            color: "#FFFFFF"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            QGCAIController.toggleHudMode()
        }
    }
}
