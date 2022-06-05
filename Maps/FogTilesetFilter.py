# This script will create a fog palette by modifying the r, g and b values
# of every colour of the input Tileset palette.
# Run the script with the -h argument to see the input arguments it takes.
#
# Made by Huichelaar.
# Many thanks to Snek's tmx2tsa for working as an argparse example.
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-i', default="MapPalette.dmp", help='Input tileset palette file. default is MapPalette.dmp')
parser.add_argument('-o', default="MapPalette2.dmp", help='Output tileset palette file. default is MapPalette2.dmp')
parser.add_argument('-r', default=12, type=int, help='Red value modifier, [-31, 31]. Default is 4')
parser.add_argument('-g', default=-8, type=int, help='Green value modifier, [-31, 31]. Default is -16')
parser.add_argument('-b', default=-8, type=int, help='Blue value modifier, [-31, 31]. Default is -16')
args = parser.parse_args()


input = open(args.i, "rb")
output = open(args.o, "wb")


# Add these values to each colour's R G and B.
redModifier = args.r
greenModifier = args.g
blueModifier = args.b


# Copy first 80 colours
output.write(input.read(160))
input.seek(0)


# Modify colours and concatenate.
for i in range(80):

    inputEntry = ord(input.read(1)) | (ord(input.read(1)) << 8)

    red = (inputEntry & 31) + redModifier
    green = ((inputEntry >> 5) & 31) + greenModifier
    blue = ((inputEntry >> 10) & 31) + blueModifier

    if red < 0:
      red = 0
    elif red > 31:
      red = 31
    if green < 0:
      green = 0
    elif green > 31:
      green = 31
    if blue < 0:
      blue = 0
    elif blue > 31:
      blue = 31

    outputEntry = red | (green << 5) | (blue << 10)

    output.write((outputEntry).to_bytes(2, byteorder='little', signed=False))


input.close()
output.close()
