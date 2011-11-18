# A helper for setting the debugger callback due to a weird linking error.

from cxx_cmake cimport cmake

cdef extern from "debugger_helper.h":
    void set_cmake_python_debugger_callback( cmake * cmakeptr, object debugger )

