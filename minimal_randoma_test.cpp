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
    //now assembler versions.
    dotest<CRandomMersenneA>(seed);
    dotest<CRandomSFMTA>(seed);
}


int main (int argc, char *argv[]) {

    //minimal_randoma_test seed [PRNG [SFMT SFMTA Mersenne MersenneA]]
    int seed = 22342; // default - don't use.
    if (argc > 1) seed = atoi(argv[1]);

    int prng_choice = -1; // when -1, test all 4. Otherwise 1 = Mersenne, 2 = SFMT, 3 = MersenneA, 4 = SFMTA
    if (argc > 2) prng_choice = atoi(argv[2]);

    switch(prng_choice)
    {
        case -1:
            test_each(seed);
            break;
        case 1:
            dotest<CRandomMersenne>(seed);
            break;
        case 2:
            dotest<CRandomSFMT>(seed);
            break;
        case 3:
            dotest<CRandomMersenneA>(seed);
            break;
        case 4:
            dotest<CRandomSFMTA>(seed);
            break;
    }

    return 0;
}
