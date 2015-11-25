if(EXISTS "/Users/lukas/Downloads/shiny-server-master/tmp/external/node/download/node-v5.0.0.tar.gz")
  file("SHA256" "/Users/lukas/Downloads/shiny-server-master/tmp/external/node/download/node-v5.0.0.tar.gz" hash_value)
  if("x${hash_value}" STREQUAL "x698d9662067ae6a20a2586e5c09659735fc0050769a0d8f76f979189ceaccdf4")
    return()
  endif()
endif()
message(STATUS "downloading...
     src='http://nodejs.org/dist/v5.0.0/node-v5.0.0.tar.gz'
     dst='/Users/lukas/Downloads/shiny-server-master/tmp/external/node/download/node-v5.0.0.tar.gz'
     timeout='none'")




file(DOWNLOAD
  "http://nodejs.org/dist/v5.0.0/node-v5.0.0.tar.gz"
  "/Users/lukas/Downloads/shiny-server-master/tmp/external/node/download/node-v5.0.0.tar.gz"
  SHOW_PROGRESS
  # no TIMEOUT
  STATUS status
  LOG log)

list(GET status 0 status_code)
list(GET status 1 status_string)

if(NOT status_code EQUAL 0)
  message(FATAL_ERROR "error: downloading 'http://nodejs.org/dist/v5.0.0/node-v5.0.0.tar.gz' failed
  status_code: ${status_code}
  status_string: ${status_string}
  log: ${log}
")
endif()

message(STATUS "downloading... done")
