import os
import sys

from libcpp.vector cimport vector
from libcpp.string cimport string

from cxx_cmDebugger cimport cmDebugger

cdef class Debugger:

    cdef cmDebugger * cmDebuggerPtr

    def __cinit__(self):
        self.cmDebuggerPtr = new cmDebugger()

    def __dealloc__(self):
        del self.cmDebuggerPtr

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
