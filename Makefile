

CYTHON_SOURCES := $(wildcard *.pyx)
CYTHON_MODULES := $(patsubst %.pyx,%.pyd,$(CYTHON_SOURCES))
CYTHON_CPP := $(patsubst %.pyx,%.cpp,$(CYTHON_SOURCES))

all : $(CYTHON_MODULES)

$(CYTHON_MODULES): $(CYTHON_SOURCES)
	python setup.py build_ext --inplace
	# --compiler=mingw32

clean :
	python setup.py clean
	rm -f *.o *.so $(CYTHON_CPP) $(CYTHON_MODULES)

test1:
	python -c 'import pyAgnerRandom as pa; rnd = pa.SFMTA(22342); for i in xrange(1,100): print rnd.Random(),'


.PHONY: clean test1


#windows
minimal_randoma_test.exe: minimal_randoma_test.cpp
	#"C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarrsall.bat"
	cl -Itmp minimal_randoma_test.cpp tmp/libacof32.lib

#mac
minimal_randoma_test.macexe: minimal_randoma_test.cpp
	g++ -o minimal_randoma_test.macexe -g -I tmp minimal_randoma_test.cpp tmp/libamac64.a

#linux
minimal_randoma_test: minimal_randoma_test.cpp
	g++ -o minimal_randoma_test -g -I tmp minimal_randoma_test.cpp tmp/libaelf64.a

