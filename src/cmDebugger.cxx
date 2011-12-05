#include "cmDebugger.h"

#include "cmSystemTools.h"

#include <iostream>

#include "pythonDebuggerGetNextCommandCallback.h"

cmDebugger
::cmDebugger():
  breakpointCount( 0 ),
  debuggerGetNextCommandCallback( NULL )
{
  // This is needed for CMake to orientate itself to where the invocation directory
  // is located.
  cmSystemTools::FindExecutableDirectory( "cmake" );

  cmakePtr = std::shared_ptr< cmake >( new cmake );

  this->cmakePtr->SetDebuggerCallback( &callback, static_cast<void *>(this) );

  // By default, we always break after loading the cache.
  BreakpointPtrType loadCacheBreakpoint( new cmBreakpoint( "CMakeCache.txt", 0 ));
  this->breakpoints["LoadCache"] = loadCacheBreakpoint;
}

cmDebugger
::~cmDebugger()
{
}

void
cmDebugger
::SetDebuggerGetNextCommandCallback( DebuggerGetNextCommandCallbackType f, void * clientData )
{
  this->debuggerGetNextCommandCallback = f;
  this->debuggerGetNextCommandCallbackClientData = clientData;
}

int
cmDebugger
::Run( const std::vector<std::string> & args )
{
  this->cmakePtr->SetArgs( args );
  if(cmSystemTools::GetErrorOccuredFlag())
    {
    return -1;
    }
  this->cmakePtr->SetCMakeCommand( args[0].c_str() );

  if(this->cmakePtr->LoadCache() < 0)
    {
    cmSystemTools::Error("Error executing cmake::LoadCache(). Aborting.\n");
    return -1;
    }
  if ( this->breakpoints["LoadCache"]->enabled )
    {
    (*(this->debuggerGetNextCommandCallback))( this->debuggerGetNextCommandCallbackClientData );
    }

  if ( !this->cmakePtr->SetCacheArgs(args) )
    {
    cmSystemTools::Error("Problem processing arguments. Aborting.\n");
    return -1;
    }

  return this->cmakePtr->Configure();
}

void
cmDebugger
::callback( const cmListFileFunction * listFileFunction, void * clientData )
{
  cmDebugger * self = static_cast< cmDebugger * >( clientData );

  (*(self->debuggerGetNextCommandCallback))( self->debuggerGetNextCommandCallbackClientData );
}
