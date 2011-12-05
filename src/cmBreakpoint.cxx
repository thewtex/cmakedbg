#include "cmBreakpoint.h"

cmBreakpoint
::cmBreakpoint():
  lineNumber( 0 ),
  enabled( false )
{
}

cmBreakpoint
::cmBreakpoint( const std::string _file,
                const unsigned int _lineNumber,
                const bool _enabled ):
  file( _file ),
  lineNumber( _lineNumber ),
  enabled( _enabled )
{
}

cmBreakpoint &
cmBreakpoint
::operator=( const cmBreakpoint & rhs )
{
  if ( this == &rhs )
    {
    return *this;
    }

  this->file       = rhs.file;
  this->lineNumber = rhs.lineNumber;
  this->enabled    = rhs.enabled;

  return *this;
};

void
cmBreakpoint
::print( std::iostream & strm )
{
}
