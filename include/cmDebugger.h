#ifndef __cmDebugger_h
#define __cmDebugger_h

#include <map>
#include <memory>
#include <vector>

#include "cmake.h"
#include "cmListFileCache.h"

#include "cmBreakpoint.h"

/** \brief A debugger interface to cmake. */
class cmDebugger
{
public:
  typedef std::shared_ptr< cmBreakpoint > BreakpointPtrType;
  typedef std::map< std::string, BreakpointPtrType > BreakpointsType;

  typedef void (*DebuggerGetNextCommandCallbackType)( void * clientData );

  cmDebugger();
  ~cmDebugger();

  /** Set the the callback to get the next debugger command when a breakpoint is
   * reached. */
  void SetDebuggerGetNextCommandCallback( DebuggerGetNextCommandCallbackType f, void * clientData );

  /** Start up cmake with the given command line arguments. Return non-zero on
   * failure. */
  int Run(const std::vector<std::string> & args);

private:

  std::shared_ptr< cmake > cmakePtr;

  DebuggerGetNextCommandCallbackType debuggerGetNextCommandCallback;
  void *                             debuggerGetNextCommandCallbackClientData;

  BreakpointsType breakpoints;
  // Gets incremented every time a breakpoint is set so there is always a unique
  // default breakpoint name.
  unsigned int    breakpointCount;

  static void callback( const cmListFileFunction * listFileFunction, void * self );
};

#endif
