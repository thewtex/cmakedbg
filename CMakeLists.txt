cmake_minimum_required( VERSION 2.8 )

project( CMAKEDBG )

set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_LIST_DIR}/cmake )

# add_cython_module(), etc.
include( UseCython )

# With CMake, a clean separation can be made between the source tree and the
# build tree.  When all source is compiled, as with pure C/C++, the source is
# no-longer needed in the build tree.  However, with pure *.py source, the
# source is processed directly.  To handle this, we reproduce the availability
# of the source files in the build tree.
add_custom_target( ReplicatePythonSourceTree ALL ${CMAKE_COMMAND} -P
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/ReplicatePythonSourceTree.cmake
  ${CMAKE_CURRENT_BINARY_DIR}
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} )

if( NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/submodules/cmake/.git )
  message( FATAL_ERROR "The CMake submodule was not found.  Please run
  git submodule --init update
In the source tree." )
endif()

include_directories( ${CMAKEDBG_SOURCE_DIR}/include )

add_subdirectory( src )
add_subdirectory( bin )
