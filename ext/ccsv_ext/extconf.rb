require 'mkmf'

abort "missing malloc()" unless have_func "malloc"
abort "missing free()"   unless have_func "free"

create_header
create_makefile('ccsv_ext/ccsv_ext')
