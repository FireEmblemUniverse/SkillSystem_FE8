#!/usr/bin/env python

import os, sys, subprocess

def main(argv):
	# print(cmd)
	output = subprocess.run(argv, capture_output=True)
	# output = '"' + output.split('\n').join('"\n') + '"'
	# outstring = '"' + output.stdout.decode().replace('\r\n', '"\r\n"') + '"'
	# outstring = outstring.replace('\r\n""','').replace(' ','%20')
	outstring = output.stdout.decode().replace(' ','%20')
	print(outstring)
	# return outstring.encode()

if __name__ == "__main__":
	argv = sys.argv
	main(argv[1:])