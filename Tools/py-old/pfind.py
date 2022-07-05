# Module providing pointer-finding facilities
# Used by pfinder & c2ea

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
def read_rom_words(romFileName):
	words = []

	with open(romFileName, 'rb') as rom:
		while True:
			word = rom.read(4)

			if word == b'':
				break

			words.append(word)

	return words

def pointer_iter(romFileName, value):
	target = value.to_bytes(4, 'little')
	words  = read_rom_words(romFileName)

	return (i * 4 for i, word in enumerate(words) if word == target)

@memoize
def pointer_offsets(romFileName, value):
	return tuple(pointer_iter(romFileName, value))
