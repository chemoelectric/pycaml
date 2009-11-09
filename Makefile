OCAMLMAKEFILE = /usr/include/OCamlMakefile
PYTHON_INCLUDE_PATH = "/usr/include/python${PYVER}"
PYTHON_LIBRARY_PATH = "/usr/$(get_libdir)/python${PYVER}"

CLIBS=$(PYCAML_CLIBS) "pthread" "dl" $(UTIL_CLIBS) "m" "c"

PACKS=unix str

SOURCES=pycaml.ml pycaml.mli pycaml_stubs.c
RESULT=pycaml
THREADS=yes
#NO_CUSTOM=NO_CUSTOM
LDFLAGS = -lpython${PYVER}
CFLAGS  = -g -O2 -fPIC -Wall -Werror

#EXTLIBDIRS=\ $(LIBDIRS)
#OCAMLLDFLAGS=$(DEBUGFLAGS) -linkall
INCDIRS=$(PYTHON_INCLUDE_PATH)
LIBDIRS=$(PYTHON_LIBRARY_PATH)

# We turn on debugger support in all our modules for now.
#OCAMLBCFLAGS=$(OCAMLDEBUGFLAGS)
#OCAMLBLDFLAGS=$(OCAMLDEBUGFLAGS)

all: pycaml_stubs.h native-code-library byte-code-library

mrproper: clean
	rm -rf *~ *.cmi *.cmo *.a *.cma *.cmxa doc *.so deps

deps: META pycaml.ml pycaml.mli pycaml_stubs.c pycaml_stubs.h
	touch deps

.PHONY: mrproper

include $(OCAMLMAKEFILE)
