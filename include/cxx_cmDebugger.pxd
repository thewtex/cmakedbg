from libcpp.vector cimport vector
from libcpp.string cimport string

cdef extern from "cmDebugger.h":
    cdef cppclass cmDebugger:
        cmDebugger()
        int Run(vector[string] & args) nogil
