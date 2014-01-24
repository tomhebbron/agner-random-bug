from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

import distutils.util

#print "python setup.py build_ext --inplace
#don't use mingw32 - it doesn't match the compilaer used for the python binary, and you will get bizarre errors.
# --compiler=mingw32"


import numpy

import re, os

setup(
    name        = "pyAgnerRandom: Python interface to Agner Fogg's random library",
    author      = "Tom Hebbron",
    author_email= "tom@hebbron.com",
    url         = "https://github.com/tomhebbron/pyAgnerRandom",
    ext_modules = cythonize([Extension("pyAgnerRandom",
                                        sources=["pyAgnerRandom.pyx"],
                                        language="c++",
                                        #extra_compile_args=['-msse4'],# sse is on by default in the Microsoft compiler.
                                        libraries=['libacof32'], # needs lib prefix, but no .lib suffix to be found by linker
                                        library_dirs=['tmp']
                                        )]),
    include_dirs= [numpy.get_include(),"tmp"]
)

#http://stackoverflow.com/questions/2817869/error-unable-to-find-vcvarsall-bat
#Let distuils find visual c compiler
#SET VS90COMNTOOLS=%VS110COMNTOOLS%

#C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\BIN\link.exe /DLL /nologo /INCREMENTAL:NO /LIBPATH:localcopy /LIBPATH:C:\users\tom\appdata\local\enthought\canopy32\user\libs /LIBPATH:C:\users\tom\appdata\local\enthought\canopy32\user\PCbuild libacof32.lib /EXPORT:initpyAgnerRandom build\temp.win32-2.7\Release\pyAgnerRandom.obj /OUT:T:\PycharmProjects\pyagner-random\pyAgnerRandom.pyd /IMPLIB:build\temp.win32-2.7\Release\pyAgnerRandom.lib /MANIFESTFILE:build\temp.win32-2.7\Release\pyAgnerRandom.pyd.manifest
#LINK : fatal error LNK1181: cannot open input file 'libacof32.lib'

#http://stackoverflow.com/questions/2379898/make-distutils-look-for-numpy-header-files-in-the-correct-place

#g++ -mno-cygwin -shared -s build\temp.win32-2.7\Release\pyagnerrandom.o build\temp.win32-2.7\Release\pyagnerrandom.def -Ltmp -L
#g++.exe -mno-cygwin -shared -s build\temp.win32-2.7\Release\pyagnerrandom.o build\temp.win32-2.7\Release\pyAgnerRandom.def -Ltmp -Lc:\users\tom\appdata\local\enthought\canopy32\user\libs -Lc:\users\tom\appdata\local\enthought\canopy32\user\PCbuild -lacof32.lib -lpython27 -lmsvcr90 -o pyAgnerRandom.pyd
#gcc.exe -mno-cygwin -O3 -Wall -Itmp -IC:\Users\tom\AppData\Local\Enthought\Canopy32\App\appdata\canopy-1.1.0.1371.win-x86\include -Ic:\users\tom\appdata\local\enthought\canopy32\user\PC -c pyAgnerRandom.cpp -o build\temp.win32-2.7\Release\pyagnerrandom.o -msse2