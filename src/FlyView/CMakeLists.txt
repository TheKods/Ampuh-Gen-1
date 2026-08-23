# ============================================================================
# Flight Display Module
# In-flight view, telemetry displays, and vehicle control UI
# ============================================================================

qt_add_library(FlyViewModule STATIC)

qt_add_qml_module(FlyViewModule
    URI QGroundControl.FlyView
    VERSION 1.0
    RESOURCE_PREFIX /qml
    QML_FILES
        AI_HUD/AIViews/AIBoundingBoxOverlay.qml
        AI_HUD/AIViews/AIMapTargetVisuals.qml
        AI_HUD/AIViews/AIPerformanceHUD.qml
        AI_HUD/HUDMasterContainer.qml
        AI_HUD/HUDModeToggleButton.qml
        AI_HUD/Panels/AIFeatureToolButton.qml
        AI_HUD/Panels/AIFeaturesControlDrawer.qml
        AI_HUD/UAVViews/UAVBatteryLinkPanel.qml
        AI_HUD/UAVViews/UAVFlightHorizonHUD.qml
        AI_HUD/UAVViews/UAVSpeedAltitudeTapes.qml
        CustomGuidedActionsController.qml
        DefaultChecklist.qml
        FixedWingChecklist.qml
        FlightDisplayViewDummy.qml
        FlightDisplayViewVideoOutput.qml
        FlightDisplayViewQtMultimedia.qml
        FlightDisplayViewUVC.qml
        FlightDisplayViewVideo.qml
        FlyView.qml
        FlyViewAdditionalActionsButton.qml
        FlyViewAdditionalActionsList.qml
        FlyViewAdditionalActionsPanel.qml
        FlyViewAdditionalCustomActionsList.qml
        FlyViewBottomRightRowLayout.qml
        FlyViewCustomLayer.qml
        FlyViewGeo.qml
        FlyViewGeoMap.qml
        FlyViewInsetViewer.qml
        FlyViewInstrumentPanel.qml
        FlyViewGripperButton.qml
        FlyViewGripperDropPanel.qml
        FlyViewMap.qml
        FlyViewMissionCompleteDialog.qml
        FlyViewPreFlightChecklistPopup.qml
        FlyViewToolStrip.qml
        FlyViewToolStripActionList.qml

        FlyViewTopRightColumnLayout.qml
        FlyViewTopRightPanel.qml
        FlyViewVideo.qml
        FlyViewWidgetLayer.qml
        GuidedActionConfirm.qml
        GuidedActionLand.qml
        GuidedActionPause.qml
        GuidedActionRTL.qml
        GuidedActionsController.qml
        GuidedActionTakeoff.qml
        GuidedToolStripAction.qml
        GuidedValueSlider.qml
        MultiRotorChecklist.qml
        MultiVehicleList.qml
        ObstacleDistanceOverlay.qml
        ObstacleDistanceOverlayMap.qml
        ObstacleDistanceOverlayVideo.qml
        OnScreenCameraTrackingController.qml
        OnScreenGimbalController.qml
        PreFlightBatteryCheck.qml
        PreFlightCheckList.qml
        PreFlightCheckListShowAction.qml
        PreFlightGPSCheck.qml
        PreFlightRCCheck.qml
        PreFlightSensorsHealthCheck.qml
        PreFlightSoundCheck.qml
        ProximityRadarValues.qml
        ProximityRadarVideoView.qml
        RoverChecklist.qml
        SubChecklist.qml
        TelemetryValuesBar.qml
        TerrainProgress.qml
        VehicleWarnings.qml
        VirtualJoystick.qml
        VTOLChecklist.qml
    IMPORTS
        QGroundControl.AI
    NO_PLUGIN
)

qt_add_resources(FlyViewModule flyview_resources
    PREFIX "/res"
    BASE "${CMAKE_SOURCE_DIR}/resources"
    FILES
        "${CMAKE_SOURCE_DIR}/resources/Gripper.svg"
        "${CMAKE_SOURCE_DIR}/resources/land.svg"
        "${CMAKE_SOURCE_DIR}/resources/NoVideoBackground.jpg"
        "${CMAKE_SOURCE_DIR}/resources/pause-mission.svg"
)

qt_add_resources(FlyViewModule flyview_qmlimages
    PREFIX "/qmlimages"
    BASE "${CMAKE_SOURCE_DIR}/resources"
    FILES
        "${CMAKE_SOURCE_DIR}/resources/check.svg"
)

target_link_libraries(FlyViewModule
    PRIVATE
        AIModule
)
