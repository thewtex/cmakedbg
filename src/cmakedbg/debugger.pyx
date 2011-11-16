import os
import sys

from libcpp.vector cimport vector
from libcpp.string cimport string

from cxx_cmake cimport cmake
from cxx_cmSystemTools cimport FindExecutableDirectory
from cxx_cmListFileCache cimport cmListFileFunction

cdef void debugger_callback(cmListFileFunction * lff, void * clientData) with gil:
    print(str(lff.Name.c_str()))

cdef class Debugger:

    cdef cmake *cmakeptr

    def __cinit__(self):
        self.cmakeptr = new cmake()
        self.cmakeptr.SetDebuggerCallback(&debugger_callback)

    def __dealloc__(self):
        del self.cmakeptr

    def run_cmake(self, *args, argv0=sys.argv[0]):
        """Run cmake with the given command line arguments."""

        cdef vector[string] cmake_args
        cdef char * c_argv0
        c_argv0 = argv0
        cmake_args.push_back(string(c_argv0))
        # This is needed for CMake to orientate itself to where the invocation directory
        # is located.
        FindExecutableDirectory('cmake')
        cdef char * c_str
        for aa in args:
            aa_str = str(aa)
            c_str  = aa_str
            cmake_args.push_back(string(c_str))
        self.cmakeptr.Run(cmake_args)

