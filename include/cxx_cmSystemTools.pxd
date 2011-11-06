"""The cmSystemTools class Cython declaration."""

cdef extern from "cmSystemTools.h":
    cdef cppclass cmSystemTools:
        cmSystemTools()
        void FindExecutableDirectory(char * argv0)
