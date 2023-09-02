# Pointer Finder finds pointers
# Given Rom, Pointer, New Pointer
# prints event format to stdout

import struct

def to_bytes(val):
	#pack into little endian, signed halfwords
	return struct.pack('<h', val)


def main():

	with open('pleftmatrix.dmp', 'wb') as out:
		# angle 0
		for zdist in range(256):
			bytevalue = to_bytes(- (zdist - (zdist>>2) - (zdist>>5)))
			out.write(bytevalue)
		#angle 1
		for zdist in range(256):
			bytevalue = to_bytes(- ((zdist>>1) - (zdist>>3)))
			out.write(bytevalue)
		# angle 2
		for zdist in range(256):
			bytevalue = to_bytes(0)
			out.write(bytevalue)
		#angle 3
		for zdist in range(256):
			bytevalue = to_bytes((zdist>>1) - (zdist>>3))
			out.write(bytevalue)
		# angle 4
		for zdist in range(256):
			bytevalue = to_bytes((zdist - (zdist>>2) - (zdist>>5)))
			out.write(bytevalue)
		#angle 5
		for zdist in range(256):
			bytevalue = to_bytes(zdist - (zdist>>4) - (zdist>>6))
			out.write(bytevalue)
		# angle 6
		for zdist in range(256):
			bytevalue = to_bytes(zdist)
			out.write(bytevalue)
		#angle 7
		for zdist in range(256):
			bytevalue = to_bytes((zdist - (zdist>>4) - (zdist>>6)))
			out.write(bytevalue)
		# angle 8
		for zdist in range(256):
			bytevalue = to_bytes((zdist - (zdist>>2) - (zdist>>5)))
			out.write(bytevalue)
		#angle 9
		for zdist in range(256):
			bytevalue = to_bytes(((zdist>>1) - (zdist>>3)))
			out.write(bytevalue)
		# angle 10
		for zdist in range(256):
			bytevalue = to_bytes(0)
			out.write(bytevalue)
		#angle 11
		for zdist in range(256):
			bytevalue = to_bytes(- ((zdist>>1) - (zdist>>3)))
			out.write(bytevalue)
		# angle 12
		for zdist in range(256):
			bytevalue = to_bytes(- (zdist - (zdist>>2) - (zdist>>5)))
			out.write(bytevalue)
		#angle 13
		for zdist in range(256):
			bytevalue = to_bytes(- (zdist - (zdist>>4) - (zdist>>6)))
			out.write(bytevalue)
		# angle 14
		for zdist in range(256):
			bytevalue = to_bytes(-zdist)
			out.write(bytevalue)
		#angle 15
		for zdist in range(256):
			bytevalue = to_bytes(- (zdist - (zdist>>4) - (zdist>>6)))
			out.write(bytevalue)
	print("done!")
  

if __name__ == '__main__':
  main()