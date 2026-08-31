# Install script for directory: C:/Project/qgroundcontrol-master/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/staging")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "C:/Users/ASUS/AppData/Local/Android/Sdk/ndk/27.2.12479018/toolchains/llvm/prebuilt/windows-x86_64/bin/llvm-objdump.exe")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/MAVLink/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/ADSB/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/AI/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/AnalyzeView/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/API/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/AutoPilotPlugins/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Camera/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Comms/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/FactSystem/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/FirmwarePlugin/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/FlyView/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/FlightMap/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/GeoMap/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/FollowMe/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Gimbal/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/GPS/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Utilities/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/LogManager/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Joystick/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/MissionManager/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/PlanView/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/PositionManager/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/QmlControls/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Settings/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Terrain/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/AppSettings/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/FirstRunPromptDialogs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Toolbar/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Vehicle/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/VideoManager/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Viewer3D/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/Android/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/src/QtLocationPlugin/cmake_install.cmake")
endif()

