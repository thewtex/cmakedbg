#ifndef __debugger_helper_h
#define __debugger_helper_h

#include "Python.h"

#include "cmake.h"

/** A workaround for setting the debugger callback because a linking error that
 * occurs when attempting to set it in Python. */
void set_cmake_python_debugger_callback( cmake * cmakeptr, PyObject * debugger);

#endif
