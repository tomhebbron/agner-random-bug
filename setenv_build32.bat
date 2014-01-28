rem http://www.pybytes.com/pywavelets/dev/preparing_windows_build_environment.html
rem Configure the environment for 32-bit builds.
rem Use "vcvars32.bat" for a 32-bit build.

"C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin\vcvars32.bat"
rem Convince setup.py to use the SDK tools.
set MSSdk=1
setenv /x86 /release
set DISTUTILS_USE_SDK=1


