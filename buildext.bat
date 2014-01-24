gcc.exe -mno-cygwin -mdll -Os -Wall -Ic:\users\tom\appdata\local\enthought\canopy32\user\lib\site-packages\numpy\core\include -Itmp -IC:\Users\tom\AppData\Local\Enthought\Canopy32\App\appdata\canopy-1.1.0.1371.win-x86\include -Ic:\users\tom\appdata\local\enthought\canopy32\user\PC -c pyAgnerRandom.cpp -o build\temp.win32-2.7\Release\pyagnerrandom.o -msse2
g++.exe -mno-cygwin -shared -s build\temp.win32-2.7\Release\pyagnerrandom.o build\temp.win32-2.7\Release\pyAgnerRandom.def -Ltmp -Lc:\users\tom\appdata\local\enthought\canopy32\user\libs -Lc:\users\tom\appdata\local\enthought\canopy32\user\PCbuild -llibacof32 -lpython27 -lmsvcr90 -o pyAgnerRandom.pyd

cl.exe /c /nologo /Ox /MD /W3 /GS- /DNDEBUG -Ic:\users\tom\appdata\local\enthought\canopy32\user\lib\site-packages\numpy\core\include -Itmp -IC:\Users\tom\AppData\Local\Enthought\Canopy32\App\appdata\canopy-1.1.0.1371.win-x86\include -Ic:\users\tom\appdata\local\enthought\canopy32\user\PC /TppyAgnerRandom.cpp /Fobuild\temp.win32-2.7\Release\pyAgnerRandom.obj -msse4
link.exe /DLL /nologo /INCREMENTAL:NO /LIBPATH:tmp /LIBPATH:c:\users\tom\appdata\local\enthought\canopy32\user\libs /LIBPATH:c:\users\tom\appdata\local\enthought\canopy32\user\PCbuild libacof32.lib /EXPORT:initpyAgnerRandom build\temp.win32-2.7\Release\pyAgnerRandom.obj /OUT:C:\Users\tom\Documents\GitHub\agner-random-bug\pyAgnerRandom.pyd /IMPLIB:build\temp.win32-2.7\Release\pyAgnerRandom.lib /MANIFESTFILE:build\temp.win32-2.7\Release\pyAgnerRandom.pyd.manifest


cl.exe /c /nologo /Ox /MD /W3 /GS- /DNDEBUG -Ic:\users\tom\appdata\local\enthought\canopy32\user\lib\site-packages\numpy\core\include -Itmp -IC:\Users\tom\AppData\Local\Enthought\Canopy32\App\appdata\canopy-1.1.0.1371.win-x86\include -Ic:\users\tom\appdata\local\enthought\canopy32\user\PC /TppyAgnerRandom.cpp /Fobuild\temp.win32-2.7\Release\pyAgnerRandom.obj

cl /c /nologo /Ox /MD /W3 /GS- /DNDEBUG -Ic:\users\tom\appdata\local\enthought\canopy32\user\lib\site-packages\numpy\core\include -Itmp -IC:\Users\tom\AppData\Local\Enthought\Canopy32\App\appdata\canopy-1.1.0.1371.win-x86\include -Ic:\users\tom\appdata\local\enthought\canopy32\user\PC /TppyAgnerRandom.cpp

cl -Itmp minimal_randoma_test.cpp tmp\libacof32.lib

#mac
g++ -o minimal_randoma_test.macexe -g -I tmp minimal_randoma_test.cpp tmp/libamac64.a 

#windows
cl -Itmp minimal_randoma_test.cpp tmp\libacof32.lib

#linux
g++ -o minimal_randoma_test -g -I tmp minimal_randoma_test.cpp tmp/libaelf64.a 
