#/usr/bin/env python3

import os, sys
import png

def read_int(input, byteCount, signed = False):
	return int.from_bytes(input.read(byteCount), byteorder = 'little', signed = signed)

GLYPH_COLOR_CHARS = ['  ', '██', '▒▒', '░░']

GLYPH_COLOR_VALUES = [
	(0,   0,   0),
	(128, 128, 128),
	(255, 255, 255),
	(64,  64,  64),
]

class FEGlyph:

	def __init__(self):
		self.pixels = [0 for i in range(16 * 16)]
		self.length = 0

	def read_from_file(self, file):
		read_int(file, 4) # ignore that part
		read_int(file, 1) # and also that part

		self.length = read_int(file, 1)

		read_int(file, 2) # and also this part

		for iy in range(16):
			line = read_int(file, 4)

			for ix in range(16):
				self.pixels[ix + 16 * iy] = 0x3 & (line >> (ix*2))

	def compute_effective_length(self):
		result = 0

		for iy in range(16):
			linelen = 0

			for ix in range(16):
				if self.pixels[ix + 16 * iy] == 0:
					continue

				if linelen < ix:
					linelen = ix + 1

			if result < linelen:
				result = linelen

		return result

	def __repr__(self):
		result = ''

		for iy in range(16):
			for ix in range(16):
				result += GLYPH_COLOR_CHARS[self.pixels[ix + 16 * iy]]

			result += '\n'

		return result

class CheapBitmap:

	def __init__(self, width, height):
		self.width = width
		self.height = height

		self.rows = [[0 for ix in range(width)] for iy in range(height)]

	def clear(self):
		for iy in range(self.height):
			for ix in range(self.width):
				self.rows[iy][ix] = 0

def make_glyph_sheet_rows(glyphs, glyphPerRow = 16):
	bitmap = CheapBitmap(glyphPerRow * 16, 16)
	col = 0

	for glyph in glyphs:
		for ix in range(16):
			for iy in range(16):
				bitmap.rows[iy][col * 16 + ix] = glyph.pixels[ix + 16 * iy]

		col += 1

		if col >= glyphPerRow:
			for row in bitmap.rows:
				yield row

			col = 0
			bitmap.clear()

	if col != 0:
		for row in bitmap.rows:
			yield row

if __name__ == '__main__':
	if len(sys.argv) < 4:
		sys.exit("usage: {} <ROM> <offset> <PNG>".format(sys.argv[0]))

	rom     = sys.argv[1]
	offset  = int(sys.argv[2], base = 0) & 0x1FFFFFF
	outFile = sys.argv[3]

	if rom == outFile:
		sys.exit("input is the same as output!")

	glyphs = []

	with open(rom, 'rb') as file:
		for i in range(0x100):
			glyph = FEGlyph()

			file.seek(offset + i*4)
			glyphOffset = read_int(file, 4) & 0x1FFFFFF

			if glyphOffset != 0:
				file.seek(glyphOffset)
				glyph.read_from_file(file)

			glyphs.append(glyph)

	pngWriter = png.Writer(
		size = (256, 256),
		palette = GLYPH_COLOR_VALUES
	)

	with open(outFile, 'wb') as file:
		pngWriter.write(file, make_glyph_sheet_rows(glyphs, 16))
