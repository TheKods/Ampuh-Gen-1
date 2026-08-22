# ============================================================================
# AMPUH Gen 1 GCS - Custom Build Configuration Overrides
# ============================================================================

# ----------------------------------------------------------------------------
# Application Branding & Metadata
# ----------------------------------------------------------------------------
set(QGC_APP_NAME "AmpuhGen1" CACHE STRING "App Name" FORCE)
set(QGC_APP_DESCRIPTION "AMPUH Gen 1 Autonomous UAV Ground Control Station" CACHE STRING "Application description" FORCE)
set(QGC_CUSTOM_BUILD ON CACHE BOOL "Enable custom build" FORCE)
set(QGC_USE_MOCCACHE OFF CACHE BOOL "Disable moccache" FORCE)
set(QGC_ENABLE_GST_VIDEOSTREAMING OFF CACHE BOOL "Enable GStreamer video backend" FORCE)
set(GStreamer_REQUIRE_CHECKSUM OFF CACHE BOOL "Require GStreamer checksums" FORCE)
set(QGC_ORG_NAME "AMPUH" CACHE STRING "Organization name" FORCE)
set(QGC_ORG_DOMAIN "ampuh.id" CACHE STRING "Organization domain" FORCE)
set(QGC_PACKAGE_NAME "id.ampuh.gen1" CACHE STRING "Package identifier" FORCE)
set(QGC_ANDROID_PACKAGE_NAME "id.ampuh.gen1" CACHE STRING "Android package identifier" FORCE)

# ----------------------------------------------------------------------------
# Custom Icons and Graphics
# ----------------------------------------------------------------------------

# macOS Icon
if(EXISTS "${CMAKE_SOURCE_DIR}/${QGC_CUSTOM_DIR}/res/icons/custom_qgroundcontrol.icns")
    set(QGC_MACOS_ICON_PATH "${CMAKE_SOURCE_DIR}/${QGC_CUSTOM_DIR}/res/icons/custom_qgroundcontrol.icns" CACHE FILEPATH "MacOS Icon Path" FORCE)
endif()

# Linux AppImage Icon
if(EXISTS "${CMAKE_SOURCE_DIR}/${QGC_CUSTOM_DIR}/res/icons/custom_qgroundcontrol.svg")
    set(QGC_APPIMAGE_ICON_SCALABLE_PATH "${CMAKE_SOURCE_DIR}/${QGC_CUSTOM_DIR}/res/icons/custom_qgroundcontrol.svg" CACHE FILEPATH "AppImage Icon SVG Path" FORCE)
endif()

# Windows Installer Header
if(EXISTS "${CMAKE_SOURCE_DIR}/${QGC_CUSTOM_DIR}/deploy/windows/installheader.bmp")
    set(QGC_WINDOWS_INSTALL_HEADER_PATH "${CMAKE_SOURCE_DIR}/${QGC_CUSTOM_DIR}/deploy/windows/installheader.bmp" CACHE FILEPATH "Windows Install Header Path" FORCE)
endif()

# Windows Application Icon
if(EXISTS "${CMAKE_SOURCE_DIR}/${QGC_CUSTOM_DIR}/deploy/windows/WindowsQGC.ico")
    set(QGC_WINDOWS_ICON_PATH "${CMAKE_SOURCE_DIR}/${QGC_CUSTOM_DIR}/deploy/windows/WindowsQGC.ico" CACHE FILEPATH "Windows Icon Path" FORCE)
endif()

# ----------------------------------------------------------------------------
# Feature Set Customization
# ----------------------------------------------------------------------------
set(QGC_DISABLE_APM_PLUGIN_FACTORY OFF CACHE BOOL "Disable APM Plugin Factory" FORCE)
set(QGC_DISABLE_PX4_PLUGIN_FACTORY OFF CACHE BOOL "Disable PX4 Plugin Factory" FORCE)
