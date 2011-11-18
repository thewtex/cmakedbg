get_directory_property( cmake_includes DIRECTORY ${CMake_SOURCE_DIR}/Source
  INCLUDE_DIRECTORIES )
include_directories( ${CMAKEDBG_SOURCE_DIR}/include 
  ${cmake_includes}
  ${CMAKEDBG_BINARY_DIR}/src/cmakedbg
  )

set_source_files_properties( debugger.pyx PROPERTIES CYTHON_IS_CXX TRUE )

cython_add_module( debugger debugger.pyx debugger_helper.cxx
  )
target_link_libraries( debugger CMakeLib cmsys 
  ${CMAKE_EXPAT_LIBRARIES} ${CMAKE_ZLIB_LIBRARIES}
  ${CMAKE_TAR_LIBRARIES} ${CMAKE_COMPRESS_LIBRARIES}
  ${CMAKE_CURL_LIBRARIES} )
