# Given an indexed png-image with a 256-colour palette, dump to FEGBA-insertable format.
from sys import exit
import argparse
from PIL import Image
import lzss

parser = argparse.ArgumentParser()
parser.add_argument("colCount",help="Colour count is either 224 or 256. 224 colours allows displaying portraits and chatbubbles as well as CGTEXTBOX. 256 colours only allows displaying CGTEXTBOX.")
parser.add_argument("file",help="PNG file to convert.")
parser.add_argument("outputGfx",help="Output graphics dump filename.")
parser.add_argument("outputPal",help="Output palette dump filename.")
args = parser.parse_args()

# Check for issues with input file.
colCount = int(args.colCount)
im = Image.open(args.file)
if im.mode != "P":
  print("Error: input image, " + args.file + " is not in indexed colour mode!")
  exit()
if ((colCount != 224) and (colCount != 256)):
  print("Error: colCount argument is " + args.colCount + " needs to be either 224 or 256!")
  exit()
if (int(im.width) & 0x7):
  print("Error: input image, " + args.file + " has width: " + str(im.width) + ", needs to be a multiple of 8!")
  exit()
if (int(im.height) & 0x7):
  print("Error: input image, " + args.file + " has height: " + str(im.height) + ", needs to be a multiple of 8!")
  exit()

# Transform into 8bpp binary and compress.
paletteIncr = 0
if (colCount == 224):
  paletteIncr = 32              # PaletteSlots 2 and 3 are occupied by text and chatbubble palettes.
arr = [0 for i in range(im.width*im.height)]
i = 0
for ytile in range(im.height>>3):
  vOffs = ytile*8
  for xtile in range(im.width>>3):
    hOffs = xtile*8
    for y in range(8):
      for x in range(8):
        col = im.getpixel((x+hOffs, y+vOffs))
        if (col > 31):
          col += paletteIncr    # Leave potentially used paletteslots empty.
          if (col > 255):
            print("Error: input image, " + args.file + " makes use of more than 224 colours, despite given colCount argument being 224!")
            exit()
        arr[i] = col
        i += 1
out = lzss.compress(arr)

# Write gfx to file.
f = open(args.outputGfx, "wb")
f.write(out)
f.close()

# Extract palette and write to file.
pal = im.getpalette()
if (colCount == 224):
  pal = pal[:672]               # Scrap last 32 colours for 224 colour images.
pal5bitcol = list()
f = open(args.outputPal, "wb")
for i in range(0, len(pal), 3):
  f.write((pal[i]>>3 | ((pal[i+1]>>3)<<5) | ((pal[i+2]>>3)<<10)).to_bytes(2, "little"))
f.close()