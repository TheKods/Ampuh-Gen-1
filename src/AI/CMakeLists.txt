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
        ${CMAKE_SOURCE_DIR}/src/Vehicle/FactGroups
        ${CMAKE_SOURCE_DIR}/src/Gimbal
        ${CMAKE_SOURCE_DIR}/src/FactSystem
        ${CMAKE_SOURCE_DIR}/src/MAVLink
        ${CMAKE_SOURCE_DIR}/src/MAVLink/Signing
        ${CMAKE_SOURCE_DIR}/src/Comms
        ${CMAKE_SOURCE_DIR}/src/MissionManager
        ${CMAKE_SOURCE_DIR}/src/GeoFence
        ${CMAKE_SOURCE_DIR}/src/PositionManager
        ${CMAKE_SOURCE_DIR}/src/Camera
        ${CMAKE_SOURCE_DIR}/src/Utilities
        ${CMAKE_SOURCE_DIR}/src/Audio
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_BINARY_DIR}
        ${mavlink_BINARY_DIR}/include/mavlink
        ${mavlink_BINARY_DIR}/include/mavlink/${QGC_MAVLINK_DIALECT}
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

add_dependencies(AIModule mavlink_enums)
