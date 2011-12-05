set( cmDebugger_SRCS_FILENAMES
  pythonDebuggerGetNextCommandCallback.cxx
  cmBreakpoint.cxx
  cmDebugger.cxx
  )
set( cmDebugger_SRCS "" )
foreach( src ${cmDebugger_SRCS_FILENAMES} )
  list( APPEND cmDebugger_SRCS ${CMAKE_CURRENT_LIST_DIR}/${src} )
endforeach()

add_subdirectory( cmakedbg )
