import os
import sys

from libcpp.vector cimport vector
from libcpp.string cimport string

from cxx_cmake cimport cmake
from cxx_cmake cimport PyObject
from cxx_cmSystemTools cimport FindExecutableDirectory
from cxx_cmListFileCache cimport cmListFileFunction

from debugger_helper cimport set_cmake_python_debugger_callback

cdef class Debugger:

    cdef cmake *cmakeptr

    def __cinit__(self):
        self.cmakeptr = new cmake()
        cdef PyObject * py_self = <PyObject *> self

    def __init__(self):
        set_cmake_python_debugger_callback(self.cmakeptr, self)

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
        cdef cmake * my_cmakeptr = self.cmakeptr
        with nogil:
            my_cmakeptr.Run(cmake_args)

    cdef void show(self, cmListFileFunction * lff):
        print("hello world")

cdef public void debugger_callback(cmListFileFunction * lff, object clientData) with gil:
    cdef Debugger debugger = <Debugger> clientData
    debugger.show(lff)

