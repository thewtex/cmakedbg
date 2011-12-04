import os
import sys

from libcpp.vector cimport vector
from libcpp.string cimport string

from cxx_cmDebugger cimport cmDebugger
from cxx_pythonDebuggerGetNextCommandCallback cimport pythonDebuggerGetNextCommandCallback

def default_get_next_command_callback():
    print('getting next command...')

cdef class Debugger:

    cdef cmDebugger * cmDebuggerPtr
    get_next_command_callback = default_get_next_command_callback

    def __cinit__(self):
        self.cmDebuggerPtr = new cmDebugger()

    def __init__(self):
        self.cmDebuggerPtr.SetDebuggerGetNextCommandCallback(&pythonDebuggerGetNextCommandCallback,
                default_get_next_command_callback)

    def __dealloc__(self):
        del self.cmDebuggerPtr

    def set_get_next_command_callback(self, callback):
        self.get_next_command_callback = callback
        self.cmDebuggerPtr.SetDebuggerGetNextCommandCallback(&pythonDebuggerGetNextCommandCallback, callback)

    def run(self, *args, argv0=sys.argv[0]):
        """Run cmake with the given command line arguments."""

        cdef vector[string] cmake_args
        cdef char * c_argv0
        c_argv0 = argv0
        cmake_args.push_back(string(c_argv0))
        cdef char * c_str
        for aa in args:
            aa_str = str(aa)
            c_str  = aa_str
            cmake_args.push_back(string(c_str))
        with nogil:
            self.cmDebuggerPtr.Run(cmake_args)
