#! /usr/bin/python
import pyAgnerRandom as pa
import os

seed = int(os.urandom(2).encode('hex'),16)

seed = 9849842
seed = 22342

print seed

for A in [pa.Mersenne, pa.SFMT, pa.SFMTx, pa.MersenneA, pa.SFMTA, pa.SFMTx]: #, pa.SFMT]:
    print str(A),
    rnd = A(seed)
    print rnd.Random()




#r = parnd.SFMT(seed)
r = pa.SFMTA(seed)
for i in xrange(1,100): print r.Random(), # crashes after 3 random numbers after seed 22342 on SFMT C or Asm.
