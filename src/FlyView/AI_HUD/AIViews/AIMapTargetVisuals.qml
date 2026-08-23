import QtQuick
import QtLocation
import QtPositioning

import QGroundControl
import QGroundControl.Controls
import QGroundControl.AI

Item {
    id: root

    property var mapControl ///< The FlightMap to add visuals to

    Instantiator {
        model: QGCAIController.detectionBoxes

        delegate: MapQuickItem {
            id: mapMarker
            coordinate: modelData.coordinate
            anchorPoint.x: markerContent.width / 2
            anchorPoint.y: markerContent.height / 2
            visible: modelData.coordinate.isValid && QGCAIController.engineEnabled

            sourceItem: Item {
                id: markerContent
                width: 44
                height: 44

                readonly property bool isLocked: modelData.isLocked
                readonly property color markerColor: isLocked ? "#FF3B30" : "#00E5FF"

                // Pulsing Target Circle
                Rectangle {
                    anchors.centerIn: parent
                    width: isLocked ? 38 : 28
                    height: width
                    radius: width / 2
                    color: "transparent"
                    border.color: markerContent.markerColor
                    border.width: isLocked ? 2.5 : 1.5

                    SequentialAnimation on scale {
                        loops: Animation.Infinite
                        running: markerContent.isLocked
                        NumberAnimation { from: 1.0; to: 1.4; duration: 600; easing.type: Easing.OutQuad }
                        NumberAnimation { from: 1.4; to: 1.0; duration: 600; easing.type: Easing.InQuad }
                    }
                }

                // Center Target Dot
                Rectangle {
                    anchors.centerIn: parent
                    width: 8
                    height: 8
                    radius: 4
                    color: markerContent.markerColor
                }

                // Target Tag Badge
                Rectangle {
                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 2
                    height: ScreenTools.defaultFontPixelHeight * 1.1
                    width: tagText.contentWidth + ScreenTools.defaultFontPixelWidth * 0.6
                    radius: 2
                    color: Qt.rgba(0.04, 0.07, 0.10, 0.90)
                    border.color: markerContent.markerColor
                    border.width: 1

                    QGCLabel {
                        id: tagText
                        anchors.centerIn: parent
                        text: qsTr("%1 #%2").arg(modelData.className).arg(modelData.targetId)
                        font.pointSize: ScreenTools.smallFontPointSize * 0.75
                        font.bold: true
                        color: markerContent.markerColor
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        QGCAIController.lockTargetById(modelData.targetId)
                    }
                }
            }

            Component.onCompleted: {
                if (root.mapControl) {
                    root.mapControl.addMapItem(mapMarker)
                }
            }

            Component.onDestruction: {
                if (root.mapControl) {
                    root.mapControl.removeMapItem(mapMarker)
                }
            }
        }
    }
}
