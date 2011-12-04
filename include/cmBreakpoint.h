#ifndef __cmBreakpoint_h
#define __cmBreakpoint_h

#include <string>

class cmBreakpoint
{
public:
  std::string  file;
  unsigned int lineNumber;
  bool         enabled;

  cmBreakpoint(): lineNumber( 0 ), enabled( false ) {}

  void print( std::iostream );
};

#endif
