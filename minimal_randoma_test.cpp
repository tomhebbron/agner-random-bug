#include <stdio.h>
#include <cstdlib>
#include <stdexcept>

#include "asmlibran.h"
#include "randomc.h"
//#include "sfmt.h"

#include "mersenne.cpp"
#include "sfmt.cpp"
//#include "mother.cpp"


/**
Windows, g++

gcc -o win32miimaltest.exe minimal_randoma_test.cpp -msse2 -I agner-asm -I agner-c -L agner-asm agner-asm\libacof32.lib
g++ -o minimal_randoma_test -msse2 -I tmp -L tmp  minimal_randoma_test.cpp -laelf64

Linux

Mac

*/


template<typename T>
void dotest(const int seed)
{
    printf("\nUsing seed %i\n", seed);
    T prng(0);
    printf("   constructed\n");
    prng.RandomInit(seed);
    printf("   seeded\n");
    for(int i=0; i<100; ++i)
    {
        printf("%f, ",prng.Random());
    }
    printf("%f\n", prng.Random());
    printf("\n");
}

void test_each(int seed)
{
    dotest<CRandomMersenne>(seed);
    dotest<CRandomSFMT>(seed);

    dotest<CRandomSFMTA>(seed);
    dotest<CRandomMersenneA>(seed);
}


int main (int argc, char *argv[]) {
    
    //Single parameter - the seed
    int given_seed = 22342;
    if (argc > 1) given_seed = atoi(argv[1]);
	test_each(given_seed);
   return 0;
}
