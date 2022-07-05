import sys, os

# like Pointer Finder, but for BLs/function calls

# Authored by Colorz
def memoize(func):
	cache = {}

	def wrapper(*args):
		if args in cache:
			return cache[args]

		else:
			result = func(*args)
			cache[args] = result

			return result

	return wrapper

@memoize
def read_rom_halfwords(romFileName):
	hwords = []

	with open(romFileName, 'rb') as rom:
		while True:
			hword = rom.read(2)

			if hword == b'':
				break

			hwords.append(hword)

	return hwords

def make_bls(co, to):
	op  = (to - co - 4) >> 1
	bl1 = (((op>>11)&0x7ff)|0xf000)
	bl2 = ((op&0x7ff)|0xf800)

	return (bl1, bl2)

def bl_iter(romFileName, targetOffset):
	hwords = read_rom_halfwords(romFileName)

	last = None

	for i, hword in enumerate(hwords):
		if last != None:
			co  = (i-1) * 2
			bls = make_bls(co, targetOffset)

			if last == bls[0].to_bytes(2, 'little') and hword == bls[1].to_bytes(2, 'little'):
				yield co

		last = hword

@memoize
def bl_offsets(romFileName, targetOffset):
	return tuple(bl_iter(romFileName, targetOffset))

def main(args):
	target = int(args[2], base = 0) & 0x1FFFFFF

	for offset in bl_offsets(args[0], int(args[1], base = 0) & 0x1FFFFFF):
		bl = make_bls(offset, target)

		print('ORG ${:X}'.format(offset))
		print('\tSHORT ${:X} ${:X}'.format(bl[0], bl[1]))

if __name__ == '__main__':
	main(sys.argv[1:])
