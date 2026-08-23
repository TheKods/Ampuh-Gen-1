import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls
import QGroundControl.AI

import "./AIViews"
import "./UAVViews"
import "./Panels"

Item {
    id: root
    anchors.fill: parent

    property var parentToolInsets
    property var totalToolInsets: _toolInsets
    property var mapControl

    // Tool insets for custom layers
    QGCToolInsets {
        id: _toolInsets
        leftEdgeTopInset: parentToolInsets ? parentToolInsets.leftEdgeTopInset : 0
        leftEdgeCenterInset: parentToolInsets ? parentToolInsets.leftEdgeCenterInset : 0
        leftEdgeBottomInset: parentToolInsets ? parentToolInsets.leftEdgeBottomInset : 0
        rightEdgeTopInset: parentToolInsets ? parentToolInsets.rightEdgeTopInset : 0
        rightEdgeCenterInset: parentToolInsets ? parentToolInsets.rightEdgeCenterInset : 0
        rightEdgeBottomInset: parentToolInsets ? parentToolInsets.rightEdgeBottomInset : 0
        topEdgeLeftInset: parentToolInsets ? parentToolInsets.topEdgeLeftInset : 0
        topEdgeCenterInset: parentToolInsets ? parentToolInsets.topEdgeCenterInset : 0
        topEdgeRightInset: parentToolInsets ? parentToolInsets.topEdgeRightInset : 0
        bottomEdgeLeftInset: parentToolInsets ? parentToolInsets.bottomEdgeLeftInset : 0
        bottomEdgeCenterInset: parentToolInsets ? parentToolInsets.bottomEdgeCenterInset : 0
        bottomEdgeRightInset: parentToolInsets ? parentToolInsets.bottomEdgeRightInset : 0
    }

    // 0. Mobile 2-Finger Swipe Gesture Handler for Fast HUD Mode Cycling
    DragHandler {
        id: twoFingerSwipe
        target: null
        minimumPointCount: 2
        maximumPointCount: 2
        xAxis.enabled: true
        yAxis.enabled: false

        property real startX: 0
        property bool swipeTriggered: false

        onActiveChanged: {
            if (active) {
                startX = centroid.position.x
                swipeTriggered = false
            }
        }

        onCentroidChanged: {
            if (active && !swipeTriggered) {
                var deltaX = centroid.position.x - startX
                if (Math.abs(deltaX) > ScreenTools.defaultFontPixelWidth * 8) {
                    QGCAIController.toggleHudMode()
                    swipeTriggered = true
                }
            }
        }
    }

    // 1. AI Bounding Box Layer (Active in AI_MODE and HYBRID_MODE)
    AIBoundingBoxOverlay {
        id: boundingBoxOverlay
        anchors.fill: parent
        visible: (QGCAIController.hudMode === QGCAIController.AI_MODE || QGCAIController.hudMode === QGCAIController.HYBRID_MODE) && QGCAIController.engineEnabled
    }

    // 1b. AI Map Target Visuals (Projects YOLO detections onto Satellite Map)
    AIMapTargetVisuals {
        id: mapTargetVisuals
        mapControl: root.mapControl
    }

    // 2. Virtual Perimeter Intrusion Siren Alert Banner
    Rectangle {
        id: intrusionBanner
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: ScreenTools.defaultFontPixelHeight * 4.0
        width: Math.min(parent.width * 0.75, ScreenTools.defaultFontPixelWidth * 42)
        height: ScreenTools.defaultFontPixelHeight * 2.2
        radius: 4
        color: "#CCFF0033"
        border.color: "#FF3B30"
        border.width: 2
        visible: QGCAIController.intrusionAlertActive
        z: 25

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            running: intrusionBanner.visible
            NumberAnimation { from: 1.0; to: 0.4; duration: 400 }
            NumberAnimation { from: 0.4; to: 1.0; duration: 400 }
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 6

            QGCLabel {
                text: qsTr("⚠️ %1").arg(QGCAIController.intrusionAlertMessage)
                font.bold: true
                font.pointSize: ScreenTools.defaultFontPointSize * 0.95
                color: "#FFFFFF"
                Layout.fillWidth: true
            }

            QGCButton {
                text: qsTr("MUTE")
                onClicked: QGCAIController.dismissIntrusionAlert()
            }
        }
    }

    // 3. Quick Target Class Filter Chips Bar (Top Center)
    Row {
        id: filterChipsRow
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: ScreenTools.defaultFontPixelHeight * 1.2
        spacing: ScreenTools.defaultFontPixelWidth * 0.6
        visible: (QGCAIController.hudMode === QGCAIController.AI_MODE || QGCAIController.hudMode === QGCAIController.HYBRID_MODE) && QGCAIController.engineEnabled
        z: 20

        Repeater {
            model: [
                { name: "ALL", label: "ALL", color: "#00E5FF" },
                { name: "PERSON", label: "🟢 PERSON", color: "#00FF66" },
                { name: "VEHICLE", label: "🔵 VEHICLE", color: "#00E5FF" },
                { name: "BOAT", label: "🟡 BOAT", color: "#FFD600" }
            ]

            Rectangle {
                width: chipText.contentWidth + ScreenTools.defaultFontPixelWidth * 1.2
                height: ScreenTools.defaultFontPixelHeight * 1.3
                radius: height / 2
                color: QGCAIController.activeClassFilter === modelData.name ?
                       Qt.rgba(0, 0.9, 1, 0.85) : Qt.rgba(0.04, 0.07, 0.12, 0.85)
                border.color: modelData.color
                border.width: 1

                QGCLabel {
                    id: chipText
                    anchors.centerIn: parent
                    text: modelData.label
                    font.bold: true
                    font.pointSize: ScreenTools.smallFontPointSize * 0.8
                    color: QGCAIController.activeClassFilter === modelData.name ?
                           "#000000" : modelData.color
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: QGCAIController.setClassFilter(modelData.name)
                }
            }
        }
    }

    // 4. AI Performance Telemetry Panel (Active in AI_MODE)
    AIPerformanceHUD {
        id: aiPerfPanel
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: ScreenTools.defaultFontPixelWidth * 1.5
        anchors.topMargin: ScreenTools.defaultFontPixelHeight * 4.5
        visible: QGCAIController.hudMode === QGCAIController.AI_MODE && !aiDrawer.visible
        z: 10
    }

    // 5. UAV Artificial Horizon & Pitch Ladder (Active in UAV_MODE)
    UAVFlightHorizonHUD {
        id: uavHorizon
        anchors.fill: parent
        visible: QGCAIController.hudMode === QGCAIController.UAV_MODE
    }

    // 6. UAV Speed & Altitude Tapes (Active in UAV_MODE)
    UAVSpeedAltitudeTapes {
        id: uavTapes
        anchors.fill: parent
        visible: QGCAIController.hudMode === QGCAIController.UAV_MODE
    }

    // 7. UAV Flight Status Bar (Active in UAV_MODE and HYBRID_MODE)
    UAVBatteryLinkPanel {
        id: uavStatusPanel
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: ScreenTools.defaultFontPixelHeight * 1.2
        visible: QGCAIController.hudMode === QGCAIController.UAV_MODE || QGCAIController.hudMode === QGCAIController.HYBRID_MODE
        z: 10
    }

    // 8. Top-Right Quick Action Bar (Mode Switcher, Target Cycler & AI Controls Button)
    Row {
        id: topControlRow
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: ScreenTools.defaultFontPixelHeight * 1.2
        anchors.rightMargin: ScreenTools.defaultFontPixelWidth * 1.5
        spacing: ScreenTools.defaultFontPixelWidth * 0.8
        z: 20

        Rectangle {
            width: ScreenTools.defaultFontPixelWidth * 5.5
            height: ScreenTools.defaultFontPixelHeight * 2.0
            radius: 4
            color: Qt.rgba(0.04, 0.07, 0.12, 0.85)
            border.color: "#00E5FF"
            border.width: 1
            visible: QGCAIController.detectionBoxes.count > 0

            QGCLabel {
                anchors.centerIn: parent
                text: qsTr("⏭️ NEXT")
                font.bold: true
                font.pointSize: ScreenTools.smallFontPointSize * 0.75
                color: "#00E5FF"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: QGCAIController.cycleNextTarget()
            }
        }

        HUDModeToggleButton {
            id: modeToggleBtn
        }

        AIFeatureToolButton {
            id: aiToolBtn
            onToggleDrawer: {
                aiDrawer.visible = !aiDrawer.visible
            }
        }
    }

    // 9. Slide-Out AI Features Control Drawer
    AIFeaturesControlDrawer {
        id: aiDrawer
        visible: false
        z: 30
        onCloseRequested: {
            visible = false
            aiToolBtn.drawerOpen = false
        }
    }
}
