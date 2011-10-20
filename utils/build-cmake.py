#!/usr/bin/env python

"""
Build the cmake binary in Debug mode, and place it within the package.
"""

import os
import urllib
import subprocess
import tarfile

SOURCE_URL = 'http://www.cmake.org/files/v2.8/cmake-2.8.6.tar.gz'
CMAKE_EXE  = 'cmake'

cmake_build_dir = 'cmake_binary_build'
if not os.path.exists(cmake_build_dir):
    os.mkdir(cmake_build_dir)
os.chdir(cmake_build_dir)

print('Downloading the CMake source...')
source_file = SOURCE_URL.split('/')[-1]
urllib.urlretrieve(SOURCE_URL, source_file)

print('Unpacking the source tarball...')
with tarfile.open(source_file, 'r:gz') as cmake_tar:
    cmake_tar.extractall()

build_dir = 'cmake_build'
if not os.path.exists(build_dir):
    os.mkdir(build_dir)
os.chdir(build_dir)

print('Configuring...')
subprocess.check_call([CMAKE_EXE,
    '-DCMAKE_BUILD_TYPE=Debug',
    os.path.join('..',source_file[:-7])])

print('Building...')
subprocess.check_call([CMAKE_EXE,
    '--build',
    '.'])
