#include "pythonDebuggerGetNextCommandCallback.h"

#include "Python.h"

void pythonDebuggerGetNextCommandCallback( void * clientData )
{
  #ifdef WITH_THREAD
  PyGILState_STATE _gilstate_save = PyGILState_Ensure();
  #endif

  PyObject * callback = static_cast< PyObject * >( clientData );
  PyObject * result = PyObject_CallObject( callback, NULL );
  if( result == NULL )
    {
    //! \todo error handling?
    return;
    }
  Py_DECREF( result );

  #ifdef WITH_THREAD
  PyGILState_Release(_gilstate_save);
  #endif
}
