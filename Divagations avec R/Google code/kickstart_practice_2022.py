def hindex(liste:list) -> list:
    k = [1 for i in range(len(list))]
    for i in range(len(list)):
        k[i] = len([1 for j in list[:i] if j>k[i]])
    return k

hindex([5,1,2])