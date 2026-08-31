# Install script for directory: C:/Project/qgroundcontrol-master/.cache/CPM/expat/a11c/expat

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

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/_deps/expat-build/expat_config.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/RelWithDebInfo/lib/libexpat.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "C:/Project/qgroundcontrol-master/.cache/CPM/expat/a11c/expat/lib/expat.h"
    "C:/Project/qgroundcontrol-master/.cache/CPM/expat/a11c/expat/lib/expat_external.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/_deps/expat-build/RelWithDebInfo/expat.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/AmpuhGen1" TYPE FILE FILES
    "C:/Project/qgroundcontrol-master/.cache/CPM/expat/a11c/expat/AUTHORS"
    "C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/_deps/expat-build/changelog"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/expat-2.7.5" TYPE FILE FILES
    "C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/_deps/expat-build/cmake/expat-config.cmake"
    "C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/_deps/expat-build/cmake/expat-config-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/expat-2.7.5/expat.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/expat-2.7.5/expat.cmake"
         "C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/_deps/expat-build/CMakeFiles/Export/lib/cmake/expat-2.7.5/expat.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/expat-2.7.5/expat-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/expat-2.7.5/expat.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/expat-2.7.5" TYPE FILE FILES "C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/_deps/expat-build/CMakeFiles/Export/lib/cmake/expat-2.7.5/expat.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/expat-2.7.5" TYPE FILE FILES "C:/Project/qgroundcontrol-master/.cxx/RelWithDebInfo/xu43l2ac/arm64-v8a/_deps/expat-build/CMakeFiles/Export/lib/cmake/expat-2.7.5/expat-relwithdebinfo.cmake")
  endif()
endif()

