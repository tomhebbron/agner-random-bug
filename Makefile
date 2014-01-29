

CYTHON_SOURCES := $(wildcard *.pyx)
CYTHON_MODULES := $(patsubst %.pyx,%.pyd,$(CYTHON_SOURCES))
CYTHON_CPP := $(patsubst %.pyx,%.cpp,$(CYTHON_SOURCES))

AGNER_DIR := tmp-agner-src
AGNER_LIB := $(AGNER_DIR)/libaelf64.a #default to Linux, 64 bit
MIN_TEST_EXE := minimal_randoma_test # the executable name (will need to add .exe for windows)

#set appropriate Agner lib path for current platform (Linux/Mac/Win)
ifeq ($(OS),Windows_NT)
    AGNER_LIB := $(AGNER_DIR)/libacof32.lib
    MIN_TEST_EXE:=minimal_randoma_test.exe
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Darwin)
        AGNER_LIB := $(AGNER_DIR)/libamac64.a
    endif
endif

#rules

all : $(CYTHON_MODULES)

$(CYTHON_MODULES): $(CYTHON_SOURCES) $(AGNER_LIB)
    #if OS is windows, run the setenv_build32.bat file
	python setup.py build_ext --inplace

$(AGNER_LIB) :
	-mkdir $(AGNER_DIR)
	curl "http://www.agner.org/random/randomc.zip" -o $(AGNER_DIR)/randomc.zip
	curl "http://www.agner.org/optimize/asmlib.zip" -o $(AGNER_DIR)/asmlib.zip

	unzip -o $(AGNER_DIR)/randomc.zip -d $(AGNER_DIR)
	unzip -o $(AGNER_DIR)/asmlib.zip -d $(AGNER_DIR)
	unzip -o $(AGNER_DIR)/asmlibSrc.zip -d $(AGNER_DIR)
	touch $(AGNER_LIB)


clean :
	python setup.py clean
	rm -f *.o *.so $(CYTHON_CPP) $(CYTHON_MODULES) minimal_randoma_test minimal_randoma_test.obj minimal_randoma_test.exe

test : $(CYTHON_MODULES) $(MIN_TEST_EXE)
	-python -c 'import pyAgnerRandom as pa; rnd = pa.Mersenne(22342); print rnd.Random()'
	-python -c 'import pyAgnerRandom as pa; rnd = pa.SFMT(22342); print rnd.Random()'
	-python -c 'import pyAgnerRandom as pa; rnd = pa.MersenneA(22342); print rnd.Random()'
	-python -c 'import pyAgnerRandom as pa; rnd = pa.SFMTA(22342); print rnd.Random()'

	-./$(MIN_TEST_EXE) 3523523 1
	-./$(MIN_TEST_EXE) 3523523 2
	-./$(MIN_TEST_EXE) 3523523 3
	-./$(MIN_TEST_EXE) 3523523 4



#windows
minimal_randoma_test.exe: minimal_randoma_test.cpp $(AGNER_LIB)
	"/cygdrive/c/Program Files (x86)/Microsoft Visual Studio 10.0/VC/vcvarsall.bat" # cygwin posix paths for simplicity
	cl -I $(AGNER_DIR) $^

#linux & mac
minimal_randoma_test: minimal_randoma_test.cpp $(AGNER_LIB)
	g++ -o minimal_randoma_test -g -I $(AGNER_DIR) $^


.PHONY: clean test fetch


