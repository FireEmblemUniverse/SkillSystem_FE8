import os, sys, glob
import numpy as np
from numpy import *
from PIL import Image


# python Png2Font.py FontText芙.png

def GetImgArray(file):
	# in: png file
	# out: pal index array
	
	img = Image.open(file)
	array = np.array(img)
	return array


def NotdDir(in_file, out_file):

	in_file_name = os.path.basename(in_file)
	out_file_name = os.path.basename(out_file)
	
	
	print( in_file_name, " => ", out_file_name )
	

def Png2Font(file):
	
	(file_name, file_ext) = os.path.splitext(file)
	
	font_file = file_name + ".fefont"
	
	if ".png" != file_ext:
		sys.exit("please input .png file!")
	
	if os.path.exists(font_file):
		os.remove(font_file)
	
	png_arr = GetImgArray(file)
	
	if np.uint8 != type(png_arr[0,0]):
		print("! break: " + file_name)
		return

	# # if text file, then get line++
	# glyph_file_name = os.path.basename(file)
	# glyth_type = glyph_file_name[4:8]
	
	# if glyth_type == "Text":
	# 	for i in range(0xE, 0x0, -1):
	# 		for j in range(0x10):
	# 			png_arr[i+1,j] = png_arr[i,j]
		
	# 	for i in range(0x10):
	# 		png_arr[0,i] = 0


	# make font
	font_arr = np.empty(0x40, dtype = uint8) 
	arr = png_arr.flatten()
	
	for i in range(0x40):
		
		index = 4 * i
		
		font_arr[i] = \
			(arr[index + 3] << 6) & 0xC0 | \
			(arr[index + 2] << 4) & 0x30 | \
			(arr[index + 1] << 2) & 0x0C | \
			(arr[index + 0] << 0) & 0x03

	
	# save
	if os.path.exists(font_file):
		os.remove(font_file)
	
	with open(font_file, 'wb') as fp_dmp:
		fp_dmp.write(font_arr)
	
	NotdDir(file, font_file)
	return
	
def main():
	if len(sys.argv) == 2:
		if( "clean" == sys.argv[1] ):
			input_file = glob.glob(r'Glyph/*.fefont')
			for file in input_file:
				os.remove(file)
			print("Have cleaned all .fefont file in /Glyph!")
			
		else:
			Png2Font( sys.argv[1] )
	else:
		input_file = glob.glob(r'Glyph/*.png')
		
		for file in input_file:
			Png2Font(file)
	
	
	
if __name__ == '__main__':
    main()	