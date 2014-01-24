from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

import distutils.util

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
                                        extra_compile_args=['-O2','-msse2'],
                                        libraries=['aelf64'],
                                        library_dirs=['tmp'],
                                        #pyrex_gdb=True
                                        )]),
    include_dirs= [numpy.get_include(),"tmp"]
)

# #check what platform we're on, to choose correct Agner library
# agnerASM = 'aelf64'
# extra_compile_args = []
#
# if (distutils.util.get_platform() == 'win32'):
#     agnerASM = 'libacof32'
#     extra_compile_args += ['-msse2']
#
# if (re.match('macosx-[^-]+-x86_64', distutils.util.get_platform())):
#     agnerASM = 'aelf64'
#     os.environ["CC"] = "gcc"
#     os.environ["CXX"] = "gcc"
#
# if (distutils.util.get_platform() == 'linux-x86_32'):
#     agnerASM = 'acof32'
#     extra_compile_args += ['-msse2']
#
# if (distutils.util.get_platform() == 'linux-x86_32'):
#     agnerASM = 'aelf32'
#     extra_compile_args += ['-msse2']
#
#
# setup(
#     name        = "pyAgnerRandom: Python interface to Agner Fogg's random library",
#     author      = "Tom Hebbron",
#     author_email= "tom@hebbron.com",
#     url         = "https://github.com/tomhebbron/pyAgnerRandom",
#     ext_modules = cythonize([Extension("*",
#                                         sources=['pyAgnerRandom.pyx'],
#                                         #sources=['pyMT.pyx'],
#                                         #sources=['pySFMT.pyx'],
#                                         language="c++",
#                                         extra_compile_args=extra_compile_args,
#                                         libraries=[agnerASM],
#                                         library_dirs=['localcopy'],
#                                         #pyrex_gdb=True
#                                         )]),
#     include_dirs= [numpy.get_include(),"localcopy"]
# )


#C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\BIN\link.exe /DLL /nologo /INCREMENTAL:NO /LIBPATH:localcopy /LIBPATH:C:\users\tom\appdata\local\enthought\canopy32\user\libs /LIBPATH:C:\users\tom\appdata\local\enthought\canopy32\user\PCbuild libacof32.lib /EXPORT:initpyAgnerRandom build\temp.win32-2.7\Release\pyAgnerRandom.obj /OUT:T:\PycharmProjects\pyagner-random\pyAgnerRandom.pyd /IMPLIB:build\temp.win32-2.7\Release\pyAgnerRandom.lib /MANIFESTFILE:build\temp.win32-2.7\Release\pyAgnerRandom.pyd.manifest
#LINK : fatal error LNK1181: cannot open input file 'libacof32.lib'

# setup(
#     name        = "pyAgnerRandom: Python interface to Agner Fogg's random library",
#     author      = "Tom Hebbron",
#     author_email= "tom@hebbron.com",
#     url         = "https://github.com/tomhebbron/pyAgnerRandom",
#     ext_modules = cythonize([Extension("pyMT",
#                                         sources=["pyMT.pyx"],
#                                         language="c++",
#                                         extra_compile_args=['-msse2'],
#                                         #extra_compile_args=['-O3','-msse2'],
#                                         #libraries=['ad64'],
#                                         #library_dirs=['C:\Software\AgnerFogg'],
#                                         #pyrex_gdb=True
#                                         )]),
#     include_dirs= [numpy.get_include(),"c:\Software\AgnerFogg"]
# )


#http://stackoverflow.com/questions/2379898/make-distutils-look-for-numpy-header-files-in-the-correct-place
