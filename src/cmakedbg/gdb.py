import pkg_resources

if platform.system() == 'Windows':
    cmake_exe = 'cmake.exe'
else:
    cmake_exe = 'cmake'

cmake_binary = pkg_resources.resource_filename('cmakedbg', 'resources/' + cmake_exe)
