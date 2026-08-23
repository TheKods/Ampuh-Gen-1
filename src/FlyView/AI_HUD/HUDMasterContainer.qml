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

    // 2. AI Performance Telemetry Panel (Active in AI_MODE)
    AIPerformanceHUD {
        id: aiPerfPanel
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: ScreenTools.defaultFontPixelWidth * 1.5
        anchors.topMargin: ScreenTools.defaultFontPixelHeight * 4.5
        visible: QGCAIController.hudMode === QGCAIController.AI_MODE && !aiDrawer.visible
        z: 10
    }

    // 3. UAV Artificial Horizon & Pitch Ladder (Active in UAV_MODE)
    UAVFlightHorizonHUD {
        id: uavHorizon
        anchors.fill: parent
        visible: QGCAIController.hudMode === QGCAIController.UAV_MODE
    }

    // 4. UAV Speed & Altitude Tapes (Active in UAV_MODE)
    UAVSpeedAltitudeTapes {
        id: uavTapes
        anchors.fill: parent
        visible: QGCAIController.hudMode === QGCAIController.UAV_MODE
    }

    // 5. UAV Flight Status Bar (Active in UAV_MODE and HYBRID_MODE)
    UAVBatteryLinkPanel {
        id: uavStatusPanel
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: ScreenTools.defaultFontPixelHeight * 1.2
        visible: QGCAIController.hudMode === QGCAIController.UAV_MODE || QGCAIController.hudMode === QGCAIController.HYBRID_MODE
        z: 10
    }

    // 6. Top-Right Quick Action Bar (Mode Switcher & AI Controls Button)
    Row {
        id: topControlRow
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: ScreenTools.defaultFontPixelHeight * 1.2
        anchors.rightMargin: ScreenTools.defaultFontPixelWidth * 1.5
        spacing: ScreenTools.defaultFontPixelWidth * 0.8
        z: 20

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

    // 7. Slide-Out AI Features Control Drawer
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
