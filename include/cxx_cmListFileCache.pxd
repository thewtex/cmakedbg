"""Cython declarations of the classes used to cache the contents of cached list files."""

from libcpp cimport bool
from libcpp.vector cimport vector
from libcpp.string cimport string

from cxx_cmMakefile cimport cmMakefile

cdef extern from "cmListFileCache.h":
    cdef cppclass cmListFileArgument:
        string Value
        bool Quoted
        char * FilePath
        long Line

    cdef cppclass cmListFileContext:
        string Name
        string FilePath
        long Line

    cdef cppclass cmListFileFunction(cmListFileContext):
        vector[cmListFileArgument] Arguments

    cdef cppclass cmListFile:
        bool ParseFile(char * path, bool topLevel, cmMakefile * mf)
        long int ModifiedTime
        vector[cmListFileFunction] Functions

