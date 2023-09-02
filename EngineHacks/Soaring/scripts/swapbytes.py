# Pointer Finder finds pointers
# Given Rom, Pointer, New Pointer
# prints event format to stdout

import os
import sys, argparse

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
  parser = argparse.ArgumentParser()
  parser.add_argument("infile", help="File to swap bytes for")
  args = parser.parse_args()
  infile = args.infile
  with open(infile,'rb+') as f:
    while True:
      hi = f.read(1)
      if hi==b'': #assumes file is even number of bytes
        break
      lo = f.read(1)
      f.seek(-2, 1) #relative to current pos
      f.write(lo)
      f.write(hi)
  print("Done!")
  

if __name__ == '__main__':
  main()