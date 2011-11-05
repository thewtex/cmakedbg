from cmakedbg.debugger import Debugger

from unittest import TestCase

class TestDebugger(TestCase):

    def setUp(self):
        self.debugger = Debugger()

    def test_run_cmake(self):
        self.debugger.run_cmake()

