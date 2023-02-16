python
import os
import sys
sys.path.insert(0, os.path.expanduser('~/.gdb'))

import qt5printers
qt5printers.register_printers(gdb.current_objfile())

if 'UNAMEOS' in os.environ:
 unameos=os.environ['UNAMEOS']
 if unameos == 'Msys' or unameos == 'Cygwin' or unameos == 'MinGW':
   from libstdcxx.v6.printers import register_libstdcxx_printers
else:
 from libstdcxx.v6.printers import register_libstdcxx_printers
 register_libstdcxx_printers (None)
end
