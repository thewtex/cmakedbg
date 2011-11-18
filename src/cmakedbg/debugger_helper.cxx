#include "debugger_helper.h"

#include "Python.h"
#include "cmListFileCache.h"
#include "debugger.h"

void set_cmake_python_debugger_callback( cmake * cmakeptr, PyObject * debugger)
{
  cmakeptr->SetDebuggerCallback( reinterpret_cast<cmake::DebuggerCallbackType>(&debugger_callback), static_cast<void *>( debugger ));
}
