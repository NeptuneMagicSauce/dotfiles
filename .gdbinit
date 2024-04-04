# for MinGW ->
set substitute-path C: /c

# do not print arguments in the stacktrace
# because it makes the stacktrace layout very hard to read
# when there are many arguments
# presence = only show if there are arguments present, not their values
# https://sourceware.org/gdb/current/onlinedocs/gdb.html/Print-Settings.html
set print frame-arguments presence

# save history
# https://sourceware.org/gdb/current/onlinedocs/gdb.html/Command-History.html
set history save on

# print structures with indentation
# https://sourceware.org/gdb/current/onlinedocs/gdb.html/Print-Settings.html
set print pretty on

# store the history file in the home directory
# default is current directory .
set history filename ~/.gdb_history
