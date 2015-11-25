# Install script for directory: /Users/lukas/Downloads/shiny-server-master

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/Users/lukas/Downloads/shiny-server-master/tmp")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
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

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/shiny-server" TYPE DIRECTORY FILES
    "/Users/lukas/Downloads/shiny-server-master/assets"
    "/Users/lukas/Downloads/shiny-server-master/samples"
    "/Users/lukas/Downloads/shiny-server-master/build"
    "/Users/lukas/Downloads/shiny-server-master/config"
    "/Users/lukas/Downloads/shiny-server-master/ext"
    "/Users/lukas/Downloads/shiny-server-master/lib"
    "/Users/lukas/Downloads/shiny-server-master/manual.test"
    "/Users/lukas/Downloads/shiny-server-master/node_modules"
    "/Users/lukas/Downloads/shiny-server-master/R"
    "/Users/lukas/Downloads/shiny-server-master/templates"
    "/Users/lukas/Downloads/shiny-server-master/test"
    "/Users/lukas/Downloads/shiny-server-master/tools"
    USE_SOURCE_PERMISSIONS)
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/shiny-server/bin" TYPE PROGRAM FILES
    "/Users/lukas/Downloads/shiny-server-master/bin/node"
    "/Users/lukas/Downloads/shiny-server-master/bin/npm"
    "/Users/lukas/Downloads/shiny-server-master/bin/shiny-server"
    "/Users/lukas/Downloads/shiny-server-master/tmp/bin/deploy-example"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/shiny-server" TYPE FILE FILES
    "/Users/lukas/Downloads/shiny-server-master/binding.gyp"
    "/Users/lukas/Downloads/shiny-server-master/config.html"
    "/Users/lukas/Downloads/shiny-server-master/COPYING"
    "/Users/lukas/Downloads/shiny-server-master/NEWS"
    "/Users/lukas/Downloads/shiny-server-master/package.json"
    "/Users/lukas/Downloads/shiny-server-master/README.md"
    "/Users/lukas/Downloads/shiny-server-master/tmp/NOTICE"
    "/Users/lukas/Downloads/shiny-server-master/tmp/VERSION"
    "/Users/lukas/Downloads/shiny-server-master/tmp/GIT_VERSION"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/Users/lukas/Downloads/shiny-server-master/tmp/src/cmake_install.cmake")
  include("/Users/lukas/Downloads/shiny-server-master/tmp/external/node/cmake_install.cmake")
  include("/Users/lukas/Downloads/shiny-server-master/tmp/external/pandoc/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/Users/lukas/Downloads/shiny-server-master/tmp/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
