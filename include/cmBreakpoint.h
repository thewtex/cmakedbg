#ifndef __cmBreakpoint_h
#define __cmBreakpoint_h

#include <string>

class cmBreakpoint
{
public:
  std::string  file;
  unsigned int lineNumber;
  bool         enabled;

  cmBreakpoint();
  cmBreakpoint( const std::string _file,
                const unsigned int _lineNumber,
                const bool _enabled = true );
  cmBreakpoint & operator=( const cmBreakpoint & rhs );

  void print( std::iostream & strm );
};

#endif
