"""The cmSystemTools Cython declaration."""

cdef extern from "cmSystemTools.h" namespace "cmSystemTools":
    void FindExecutableDirectory(char * argv0)
