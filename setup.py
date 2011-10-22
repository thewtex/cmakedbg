import distribute_setup
distribute_setup.use_setuptools()

import os
import platform
from setuptools import setup, find_packages
import sys

if platform.system() == 'Windows':
    cmake_exe = 'cmake.exe'
else:
    cmake_exe = 'cmake'

# Build the binary cmake executable in Debug mode.
repo_dir = os.path.dirname(os.path.realpath(__file__))
if not os.path.exists(os.path.join(repo_dir, 'src', 'cmakedbg', 'resources', cmake_exe)):
    sys.path.insert(0, os.path.join(repo_dir, 'utils'))
    import build_cmake
    build_cmake.main()

setup(
    name = "cmakedbg",
    version = "0.0.0",
    packages = ['cmakedbg'],
    package_dir = {'':os.path.join(repo_dir, 'src')},
    package_data = {
        'cmakedbg': ['resources/*']
        },
    eager_resources = ['cmakedbg/resources/' + cmake_exe],
    scripts = ['cmake-dbg'],
    author = 'Matt McCormick',
    author_email = 'matt.mccormick@kitware.com',
    description = 'A debugger for CMake configuration scripts.',
    license = 'Apache',
    keywords = 'debugger cmake',
    url = 'http://kitware.com',
    entry_points = {
        'console_scripts': [ 'cmake-dbg = cmakedbg.cmd:main' ],
        'gui_scripts':     [ 'ccmake-dbg = cmakedbg.curses:main']
        },
    tests_require = ['nose', 'coverage'],
    test_suite = 'nose.collector',
    zip_safe = False,
)
