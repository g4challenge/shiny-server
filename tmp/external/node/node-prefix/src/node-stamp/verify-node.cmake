set(file "/Users/lukas/Downloads/shiny-server-master/tmp/external/node/download/node-v5.0.0.tar.gz")
message(STATUS "verifying file...
     file='${file}'")
set(expect_value "698d9662067ae6a20a2586e5c09659735fc0050769a0d8f76f979189ceaccdf4")
set(attempt 0)
set(succeeded 0)
while(${attempt} LESS 3 OR ${attempt} EQUAL 3 AND NOT ${succeeded})
  file(SHA256 "${file}" actual_value)
  if("${actual_value}" STREQUAL "${expect_value}")
    set(succeeded 1)
  elseif(${attempt} LESS 3)
    message(STATUS "SHA256 hash of ${file}
does not match expected value
  expected: ${expect_value}
    actual: ${actual_value}
Retrying download.
")
    file(REMOVE "${file}")
    execute_process(COMMAND ${CMAKE_COMMAND} -P "/Users/lukas/Downloads/shiny-server-master/tmp/external/node/node-prefix/src/node-stamp/download-node.cmake")
  endif()
  math(EXPR attempt "${attempt} + 1")
endwhile()

if(${succeeded})
  message(STATUS "verifying file... done")
else()
  message(FATAL_ERROR "error: SHA256 hash of
  ${file}
does not match expected value
  expected: ${expect_value}
    actual: ${actual_value}
")
endif()
