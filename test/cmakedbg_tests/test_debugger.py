from cmakedbg.debugger import Debugger

from cmakedbg_tests import create_build_dir

from nose import with_setup

import inspect

class TestDebugger:

    # For nose parallel test processing.
    _multiprocess_can_split_ = True

    def setUp(self):
        self.debugger = Debugger()

    def test_run(self):
        source_dir, build_dir = create_build_dir(self.test_run)
        self.debugger.run(source_dir)
