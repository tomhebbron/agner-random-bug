

CYTHON_SOURCES := $(wildcard *.pyx)
CYTHON_MODULES := $(patsubst %.pyx,%.pyd,$(CYTHON_SOURCES))
CYTHON_CPP := $(patsubst %.pyx,%.cpp,$(CYTHON_SOURCES))

all : $(CYTHON_MODULES)

$(CYTHON_MODULES): $(CYTHON_SOURCES)
    #if OS is windows, run the setenv_build32.bat file

	python setup.py build_ext --inplace

clean :
	python setup.py clean
	rm -f *.o *.so $(CYTHON_CPP) $(CYTHON_MODULES) minimal_randoma_test minimal_randoma_test.obj minimal_randoma_test.exe
	rm -rf minimal_randoma_test.macexe.DSYM minimal_randoma_test.macexe

test : 
	-python -c 'import pyAgnerRandom as pa; rnd = pa.Mersenne(22342); print rnd.Random()'
	-python -c 'import pyAgnerRandom as pa; rnd = pa.SFMT(22342); print rnd.Random()'
	-python -c 'import pyAgnerRandom as pa; rnd = pa.MersenneA(22342); print rnd.Random()'
	-python -c 'import pyAgnerRandom as pa; rnd = pa.SFMTA(22342); print rnd.Random()'

	-minimal_randoma_test 3523523 1
	-minimal_randoma_test 3523523 2
	-minimal_randoma_test 3523523 3
	-minimal_randoma_test 3523523 4


.PHONY: clean test1


#windows
minimal_randoma_test.exe: minimal_randoma_test.cpp
	"/cygdrive/c/Program Files (x86)/Microsoft Visual Studio 10.0/VC/vcvarsall.bat" # cygwin posix paths for simplicity
	cl -Itmp minimal_randoma_test.cpp tmp/libacof32.lib

#mac
minimal_randoma_test.macexe: minimal_randoma_test.cpp
	g++ -o minimal_randoma_test.macexe -g -I tmp minimal_randoma_test.cpp tmp/libamac64.a

#linux
minimal_randoma_test: minimal_randoma_test.cpp
	g++ -o minimal_randoma_test -g -I tmp minimal_randoma_test.cpp tmp/libaelf64.a

