"""The cmake class Cython declaration."""

from libcpp.vector cimport vector
from libcpp.string cimport string

cdef enum MessageType:
    AUTHOR_WARNING,
    FATAL_ERROR,
    INTERNAL_ERROR,
    MESSAGE,
    WARNING,
    LOG

cdef extern from "cmake.h":
    cdef cppclass cmake:
        cmake()
        void SetHomeDirectory(char * dir)
        char * GetHomeDirectory()
        void SetStartDirectory(char * dir)
        char * GetStartDirectory()
        int Run(vector[string] & args) nogil
