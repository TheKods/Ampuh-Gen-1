# ============================================================================
# AI Module
# AI engine interface, socket receiver, hardware monitor, and HUD controller
# ============================================================================

qt_add_library(AIModule STATIC)

qt_add_qml_module(AIModule
    URI QGroundControl.AI
    VERSION 1.0
    RESOURCE_PREFIX /qml
    SOURCES
        AIController.cc
        AIController.h
        AIDetectionBox.cc
        AIDetectionBox.h
        AIDetectionManager.cc
        AIDetectionManager.h
        AIReceiverSocket.cc
        AIReceiverSocket.h
        AndroidSystemMonitor.cc
        AndroidSystemMonitor.h
        AIStatsData.h
    IMPORTS
        QtQuick
)

target_include_directories(AIModule
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/src/QmlControls
        ${CMAKE_SOURCE_DIR}/src/Utilities/Audio
        ${CMAKE_SOURCE_DIR}/src/Vehicle
        ${CMAKE_SOURCE_DIR}/src/Gimbal
        ${CMAKE_SOURCE_DIR}/src/FactSystem
)

target_link_libraries(AIModule
    PUBLIC
        Qt6::Core
        Qt6::Network
        Qt6::Qml
        Qt6::QmlIntegration
        Qt6::Quick
    PRIVATE
        QGCAudio
)
