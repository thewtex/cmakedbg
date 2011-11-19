#include "cmDebugger.h"

#include "cmSystemTools.h"

#include <iostream>

cmDebugger
::cmDebugger():
  breakpointCount( 0 ),
  cmakePtr( new cmake ),
  debuggerGetNextCommandCallback( NULL )
{
  // This is needed for CMake to orientate itself to where the invocation directory
  // is located.
  cmSystemTools::FindExecutableDirectory( "cmake" );

  this->cmakePtr->SetDebuggerCallback( &callback, static_cast<void *>(this) );
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
  this->cmakePtr->Run( args );
}

void
cmDebugger
::LoadCache()
{
}

void
cmDebugger
::callback( const cmListFileFunction * listFileFunction, void * clientData )
{
  cmDebugger * self = static_cast< cmDebugger * >( clientData );

  std::cout << "Line reached: " << listFileFunction->Line << " for " << listFileFunction->Name << " in " << listFileFunction->FilePath << std::endl;
}
