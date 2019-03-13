import struct
caches = {}

def getOrSetNew(dicToCheck, key, newFunc):
    if key not in dicToCheck:
        dicToCheck[key] = newFunc()
    return dicToCheck[key]

def memoize(name = None):
    def decorator(f):
        global caches
        # If we are given a valid name for the function, associate it with that entry in the cache.
        if name is not None:
            cache = getOrSetNew(caches, name, lambda: {})
        else:
            cache = {}
        def g(*args):
            return getOrSetNew(cache, args, lambda: f(*args))
        # Set the cache as a function attribute so we can access it later (say for serialization)
        g.cache = cache
        return g
    return decorator

def hash(obj):
    if type(obj) is dict:
        sortedDict = sorted(obj)
        return tuple(map(
            lambda elem: (elem, hash(obj[elem])),
            sortedDict)).__hash__()
        # Use sorted so we get the same order for dicts whose
        # keys may have been added in other orders
    if type(obj) is list:
        return tuple(map(hash, obj)).__hash__()
    else:
        return obj.__hash__()


cachesLoaded = False
initialHash = None
def loadCache():
    global cachesLoaded
    global initialHash
    global caches
    
    if not cachesLoaded:
        import os, pickle
        if os.path.exists("./.cache"):
            try:
                with open("./.cache", 'rb') as f:
                    caches = pickle.load(f)
                    if type(caches) != dict: raise Exception
            except Exception:
                caches = {}
        initialHash = hash(caches)
        cachesLoaded = True

loadCache()

def writeCache():
    if initialHash != hash(caches):
        import pickle
        with open("./.cache", 'wb') as f:
            pickle.dump(caches, f, pickle.HIGHEST_PROTOCOL)

def deleteCache():
    global caches
    
    for name in caches:
        caches[name] = {}
    writeCache()

@memoize()
def readRom(romFileName):
    words = []
    with open(romFileName, 'rb') as rom:
        while True:
            word = rom.read(4)
            if word == b'':
                break
            words.append(struct.unpack('<I', word)[0]) #Use the raw data;
            # <I is little-endian 32 bit unsigned integer
    return words

@memoize(name = 'pointerOffsets')
def pointerOffsets(romFileName, value):
    return tuple(pointerIter(romFileName, value))

def pointerIter(romFileName, value):
    words = readRom(romFileName)
    return (i<<2 for i,x in enumerate(words) if x==value)
