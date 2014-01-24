
#include "asmlibran.h"
#include "randomc.h"
#include "sfmt.h"

#include <cstdio>

int crashme(const int seed=22342, const int n=4)
{
    CRandomSFMT0 rnd(seed);
    for (int i=0; i<n; ++i)
    {
        printf("%f, ",rnd.Random());
    }
    return 0;
}


class wrapRandom {
public:
    wrapRandom (int seed);
    double Random();
private:
    CRandomSFMT0 *rnd;

};


wrapRandom::wrapRandom(int seed)
{
    this->rnd = new CRandomSFMT0(seed);
}

double wrapRandom::Random()
{
    return this->rnd->Random();
}






