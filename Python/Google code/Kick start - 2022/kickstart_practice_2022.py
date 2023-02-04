import random
import math
L = [random.randrange(start=1, stop=50, step=1) for i in range(100)]

L.count(10)

occ = [1 for i in L if i 10]
print(len(occ))
print(L)