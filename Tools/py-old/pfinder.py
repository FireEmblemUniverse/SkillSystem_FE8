# Pointer Finder finds pointers
# Given Rom, Pointer, New Pointer
# prints event format to stdout

import os, sys
import pfind

def parseNum(num):
	"""0x or $ is hex, 0b is binary, 0 is octal. Otherwise assume decimal."""
	
	num = str(num).strip()
	base = 10
	
	if (num[0] == '0') & (len(num) > 1):
		if num[1] == 'x':
			base = 16
		
		elif num[1] == 'b':
			base = 2
		
		else:
			base = 8
	
	elif num[0]=='$':
		base = 16
	
	return int(num, base)

def main():
	hwOffset = 0x8000000

	if len(sys.argv) < 4:
		sys.exit("Usage: {0} <rom> <target offset> <replacement expression> [--to-stdout (ignored)]".format(sys.argv[0]))

	rom         = sys.argv[1] # rom file name
	target      = (parseNum(sys.argv[2]) | hwOffset) # pointer (int)
	replacement = "POIN " + sys.argv[3] # offset or label

	print("PUSH")

	for offset in pfind.pointer_offsets(rom, target):
		print("ORG {}".format(hex(offset)))
		print(replacement)

	print("POP")

if __name__ == '__main__':
	main()
