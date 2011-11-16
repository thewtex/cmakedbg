from cmakedbg.debugger import Debugger

from cmakedbg_tests import create_build_dir

from nose import with_setup

import inspect

class TestDebugger:

    # For nose parallel test processing.
    _multiprocess_can_split_ = True

    def setUp(self):
        self.debugger = Debugger()

    def test_run_cmake(self):
        source_dir, build_dir = create_build_dir(self.test_run_cmake)
        self.debugger.run_cmake(source_dir)
