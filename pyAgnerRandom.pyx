
cimport cython

#import numpy
#cimport numpy

from libc.stdlib cimport malloc, free


cdef extern from "asmlibran.h":

    ctypedef int uint32_t

    cdef cppclass CRandomMersenneA  :
        CRandomMersenneA(int seed)
        void RandomInit(int seed)
        int IRandom (int min, int max)
        int IRandomX (int min, int max)
        double Random()
        uint32_t BRandom()

    cdef cppclass CRandomSFMTA0 :
        CRandomSFMTA0(int seed)
        void RandomInit(int seed)
        int IRandom (int min, int max)
        int IRandomX (int min, int max)
        double Random()
        uint32_t BRandom()


cdef class MersenneA:
    cdef CRandomMersenneA *thisptr

    def __cinit__(self, int seed):
        self.thisptr = new CRandomMersenneA(seed)

    def __dealloc__(self):
        del self.thisptr

    def RandomInit(self, int seed):
        self.thisptr.RandomInit(seed)

    def IRandom(self, int min, int max):
        return self.thisptr.IRandom(min,max)

    def IRandomX(self, int min, int max):
        return self.thisptr.IRandomX(min,max)

    def Random(self):
        return self.thisptr.Random()

    def BRandom(self):
        return self.thisptr.BRandom()


cdef class SFMTA:
    cdef CRandomSFMTA0 *thisptr

    def __cinit__(self, int seed):
        self.thisptr = new CRandomSFMTA0(seed)

    def __dealloc__(self):
        del self.thisptr

    def RandomInit(self, int seed):
        self.thisptr.RandomInit(seed)

    def IRandom(self, int min, int max):
        return self.thisptr.IRandom(min,max)

    def IRandomX(self, int min, int max):
        return self.thisptr.IRandomX(min,max)

    def Random(self):
        return self.thisptr.Random()

    def BRandom(self):
        return self.thisptr.BRandom()


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cdef extern from "mersenne.cpp":

    ctypedef int uint32_t

    cdef cppclass CRandomMersenne :
        #CRandomSFMT(int seed, int IncludeMother) # Can't overload in cython yet - https://groups.google.com/forum/#!topic/cython-users/4ecKM-p8dPA
        CRandomMersenne(int seed)
        void RandomInit(int seed)                                   # Re-seed
        #void RandomInitByArray(int const seeds[], int NumSeeds)    # Seed by more than 32 bits
        int  IRandom  (int min, int max)                            # Output random integer
        int  IRandomX (int min, int max)                            # Output random integer, exact
        double Random()                                             # Output random floating point number
        uint32_t BRandom()                                          # Output random bits

cdef class Mersenne:

    cdef CRandomMersenne *thisptr   # pointer to underlying C++ object
    cdef int seed               # store current seed

    def __cinit__(self, int seed):
        self.seed = seed
        self.thisptr = new CRandomMersenne(seed)

    def __dealloc__(self):
        del self.thisptr

    def RandomInit(self, int seed):
        self.seed = seed
        self.thisptr.RandomInit(seed)

    def IRandom(self, int min, int max):
        return self.thisptr.IRandom(min,max)

    def IRandomX(self, int min, int max):
        return self.thisptr.IRandomX(min,max)

    def Random(self):
        return self.thisptr.Random()

    def BRandom(self):
        return self.thisptr.BRandom()


cdef extern from "sfmt.cpp":

    ctypedef int uint32_t

    cdef cppclass CRandomSFMT :
        CRandomSFMT(int seed, int IncludeMother)
        double Random()                                             # Output random floating point number

    cdef cppclass CRandomSFMT0 :
        CRandomSFMT0(int seed)                                       # Can't overload in cython yet - https://groups.google.com/forum/#!topic/cython-users/4ecKM-p8dPA
        void RandomInit(int seed)                                   # Re-seed
        #void RandomInitByArray(int const seeds[], int NumSeeds)    # Seed by more than 32 bits
        int  IRandom  (int min, int max)                            # Output random integer
        int  IRandomX (int min, int max)                            # Output random integer, exact
        double Random()                                             # Output random floating point number
        uint32_t BRandom()                                          # Output random bits


cdef class SFMTx:

    cdef CRandomSFMT *thisptr   # pointer to underlying C++ object
    cdef int seed               # store current seed

    def __cinit__(self, int seed):
        self.seed = seed
        self.thisptr = new CRandomSFMT(seed,0)

    def __dealloc__(self):
        del self.thisptr

    def Random(self):
        #return 0
        return self.thisptr.Random()


cdef class SFMT:

    cdef CRandomSFMT0 *thisptr   # pointer to underlying C++ object
    cdef int seed               # store current seed

    def __cinit__(self, int seed):
        self.seed = seed
        self.thisptr = new CRandomSFMT0(seed)

    def __dealloc__(self):
        del self.thisptr

    def RandomInit(self, int seed):
        self.seed = seed
        self.thisptr.RandomInit(seed)

    def IRandom(self, int min, int max):
        return self.thisptr.IRandom(min,max)

    def IRandomX(self, int min, int max):
        return self.thisptr.IRandomX(min,max)

    def Random(self):
        #return 0
        return self.thisptr.Random()

    def BRandom(self):
        return self.thisptr.BRandom()


cdef extern from "crashme.cpp":

    int crashme(int seed, int n)

    cdef cppclass wrapRandom:
        wrapRandom(int seed)
        double Random()


cdef class wrappedRandom:

    cdef wrapRandom *thisptr   # pointer to underlying C++ object
    cdef int seed               # store current seed

    def __cinit__(self, int seed):
        self.seed = seed
        self.thisptr = new wrapRandom(seed)

    def __dealloc__(self):
        del self.thisptr

    def Random(self):
        return self.thisptr.Random()



def Ccrash(seed=22342, n=4):
    crashme(seed,n)

def Ycrash(int seed=22342, int n=4):
    cdef CRandomSFMT0* rnd = new CRandomSFMT0(seed)

    #cdef CRandomMersenne* rnd = new CRandomMersenne(seed)
    for i in xrange(0,n):
        print " %f, " % (rnd.Random()),

def Pcrash(seed=22342, n=4):
    rnd = SFMT(seed)
    for i in xrange(0,n):
        print " %f, " % (rnd.Random()),

def Wcrash(seed=22342, n=4):
    rnd = wrappedRandom(seed)
    for i in xrange(0,n):
        print " %f, " % (rnd.Random()),


# function to guarantee a crash in windows
# setup SFMT with seed 22342 and call .Random() 4 times.

