import os, sys

def main(infile, outfile):
	'''
	find and replace within lyn exported events
	'''
	with open(infile, 'r') as f:
		text = f.read()
		text = text.replace('{','').replace('}','').replace('4-CURRENTOFFSET', '8-CURRENTOFFSET').replace('POIN gKeyState', 'WORD gKeyState').replace('POIN gPaletteBuffer', 'WORD gPaletteBuffer').replace('POIN iwram_clr_blend_asm', 'WORD iwram_clr_blend_asm').replace('POIN iwram_Render_arm', 'WORD iwram_Render_arm')

	with open(outfile, 'w') as o:
		o.write(text)


if __name__ == '__main__':
	argv = sys.argv
	main(argv[1], argv[2])
