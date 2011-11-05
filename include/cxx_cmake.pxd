# The cmake class Cython declaration.

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
