from cxx_cmake cimport cmake

cdef class Debugger:

    cdef cmake *cmakeptr

    def __cinit__(self):
        self.cmakeptr = new cmake()

    def __dealloc__(self):
        del self.cmakeptr

    def run_cmake(self):
        print('home directory:')
        print(self.cmakeptr.GetHomeDirectory())
