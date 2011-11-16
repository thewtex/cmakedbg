"""Cython declaration of the cmake cmMakefile class."""

cdef extern from "cmMakefile.h":
    cdef cppclass cmMakefile:
        cmMakefile()
