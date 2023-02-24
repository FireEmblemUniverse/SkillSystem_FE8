#!/usr/bin/env python3

import numpy as np
import cv2
from os import scandir

#import png
from PIL import Image, ImagePalette



def QuantizeToGivenPalette(im, palette):
    """Quantize image to a given palette.
    
    The input image is expected to be a Numpy array.
    The palette is expected to be a list of R,G,B values."""

    # Calculate the distance to each palette entry from each pixel
    distance = np.linalg.norm(im[:,:,None] - palette[None,None,:], axis=3)

    # Now choose whichever one of the palette colours is nearest for each pixel
    palettised = np.argmin(distance, axis=2).astype(np.uint8)

    return palettised

# Open input image and palettise to "inPalette" so each pixel is replaced by palette index
# ... so all black pixels become 0, all red pixels become 1, all green pixels become 2...

# subfolder info here
# make it edit pal for all files in folder 


for entry in scandir():
    if entry.is_file():
        info = entry.stat()
        try:
            img_pal = Image.open('image_pal.png')
        except:
            print('Failed to find image_pal.png')
            break 
        
        try:
            test_im = Image.open(f'{entry.name}') # only proceed for images 
            print(f'{entry.name}')
            
            im=cv2.imread(f'{entry.name}',cv2.IMREAD_COLOR)
            im_pal = cv2.imread("image_pal.png", cv2.IMREAD_COLOR)

            #inPalette = im_pal
            
            inPalette = np.reshape( img_pal.getpalette(), (-1, 3) )

            # reorder because it in one place it goes [0,1,2] and another [2,1,0]
            for i in inPalette:
                #print(inPalette[i])
                k = i[0]
                i[0] = i[2]
                i[2] = k
                #print(inPalette[i])
                
                

            #inPalette = np.array(img_pal.getcolors())
            # match to vanilla palette as closely as possible 
            ##inPalette = np.array([
            ##   [200,248,192],             
            ##   [248,248,248],           
            ##   [184,192,200],          
            ##   [128,144,144],
            ##   [32,56,40], 
            ##   [32,208,216],
            ##   [8,8,160],             
            ##   [240,80,56],           
            ##   [144,120,112],          
            ##   [208,176,176],
            ##   [96,128,40], 
            ##   [184,200,104],
            ##   [48,80,112],          
            ##   [112,128,152],
            ##   [64,56,80], 
            ##   [0,96,192]], 
            ##   )



            r = QuantizeToGivenPalette(im,inPalette)

            # Now make LUT (Look Up Table) with the 16 new colours
            ##LUT = np.zeros((16,3),dtype=np.uint8)
            ##LUT[0]=[200,248,192]
            ##LUT[1]=[248,248,248]
            ##LUT[2]=[184,192,200]
            ##LUT[3]=[128,144,144]
            ##LUT[4]=[32,56,40]
            ##LUT[5]=[32,208,216]
            ##LUT[6]=[8,8,160]
            ##LUT[7]=[240,80,56]
            ##LUT[8]=[144,120,112]
            ##LUT[9]=[208,176,176]
            ##LUT[10]=[96,128,40]
            ##LUT[11]=[184,200,104]
            ##LUT[12]=[48,80,112]
            ##LUT[13]=[112,128,152]
            ##LUT[14]=[64,56,80]
            ##LUT[15]=[0,96,192]
            ### Look up each pixel in the LUT
            ##result = LUT[r]
            result = r 
            # cv.COLOR_BGR5652RGB
            #img = result 
            #img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
            # Save result
            cv2.imwrite(f'{entry.name}', result)
            ##im_1 = Image.open(r'result.png').quantize(16)
            ##im_1 = im_1.save('result.png')


            img_pil = Image.open(f'{entry.name}')


            ##
            ##MyPalette = np.array([
            ##   [192,248,200],             
            ##   [248,248,248],           
            ##   [200,192,184],          
            ##   [144,144,128],
            ##   [40,56,32], 
            ##   [216,208,32],
            ##   [160,8,8],             
            ##   [56,80,240],           
            ##   [112,120,144],          
            ##   [178,176,208],
            ##   [40,128,96], 
            ##   [104,200,184],
            ##   [112,80,48],          
            ##   [152,128,112],
            ##   [80,56,64], 
            ##   [192,96,0]], 
            ##   )
            # Convert to mode 'P', and apply palette as flat list
            #img_pil = img_pil.convert('P')
            img_pil = img_pil.quantize(16, palette=img_pal)

            img_pal.close()
            #palette = [value for color in MyPalette for value in color]
            #img_pil.putpalette(palette)

            # Save indexed image for comparison
            img_pil.save(f'{entry.name}')
        except:
            pass

print('Finished.')

