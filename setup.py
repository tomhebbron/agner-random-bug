from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

import distutils.util

import numpy

import re, os

AGNERDIR = "tmp-agner-src" #assume Agner Random headers and static library files are in ./tmp/

#check what platform we're on, to choose correct Agner library
#http://stackoverflow.com/questions/2379898/make-distutils-look-for-numpy-header-files-in-the-correct-place


agnerASM = 'aelf64'
extra_compile_args = []

if (distutils.util.get_platform() == 'win32'):
    agnerASM = 'libacof32'
    #extra_compile_args += ['-msse2']

if (re.match('macosx-[^-]+-x86_64', distutils.util.get_platform())):
    agnerASM = 'amac64'

if (distutils.util.get_platform() == 'linux-x86_32'):
    agnerASM = 'acof32'
    extra_compile_args += ['-msse2']

if (distutils.util.get_platform() == 'linux-x86_64'):
    agnerASM = 'aelf64'
    extra_compile_args += ['-msse2']

setup(
    name        = "pyAgnerRandom: Python interface to Agner Fogg's random library",
    author      = "Tom Hebbron",
    author_email= "tom@hebbron.com",
    url         = "https://github.com/tomhebbron/pyAgnerRandom",
    ext_modules = cythonize([Extension("*",
                                        sources=['pyAgnerRandom.pyx'],
                                        language="c++",
                                        extra_compile_args=extra_compile_args,
                                        libraries=[agnerASM],
                                        library_dirs=[AGNERDIR],
                                        #pyrex_gdb=True
                                        )]),
    include_dirs= [numpy.get_include(),AGNERDIR]
)


