#!/usr/bin/env python

"""
Build the cmake binary in Debug mode, and place it within the package.
"""

import platform
import os
import urllib
import shutil
import subprocess
import tarfile

if platform.system() == 'Windows':
    cmake_exe = 'cmake.exe'
else:
    cmake_exe = 'cmake'


SOURCE_URL = 'http://www.cmake.org/files/v2.8/cmake-2.8.6.tar.gz'

def main():
    cmake_build_dir = 'cmake_binary_build'
    if not os.path.exists(cmake_build_dir):
        os.mkdir(cmake_build_dir)
    cwd = os.getcwd()
    os.chdir(cmake_build_dir)

    source_file = SOURCE_URL.split('/')[-1]
    if os.path.exists(source_file):
        print('Source found.')
    else:
        print('Downloading the CMake source...')
        urllib.urlretrieve(SOURCE_URL, source_file)

    print('Unpacking the source tarball...')
    with tarfile.open(source_file, 'r:gz') as cmake_tar:
        cmake_tar.extractall()

    build_dir = 'cmake_build'
    if not os.path.exists(build_dir):
        os.mkdir(build_dir)
    os.chdir(build_dir)

    print('Configuring...')
    subprocess.check_call([cmake_exe,
        '-DCMAKE_BUILD_TYPE=Debug',
        os.path.join('..',source_file[:-7])])

    print('Building...')
    subprocess.check_call([cmake_exe,
        '--build',
        '.'])

    print('Copying to package...')
    dest_dir = os.path.join('..', '..', 'src', 'cmakedbg', 'resources')
    if not os.path.exists(dest_dir):
        os.makedirs(dest_dir)
    shutil.copy2(os.path.join('bin', cmake_exe), dest_dir)

    os.chdir(cwd)

if __name__ == '__main__':
    main()
