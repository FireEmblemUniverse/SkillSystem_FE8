import png 
from PIL import Image, ImageDraw, ImageOps, ImageEnhance, ImageFilter
from os import scandir
import os 
import libimagequant as liq


directory = 'png_test/'
dir_entries = scandir(directory)
for entry in dir_entries:
    if entry.is_file():
        info = entry.stat()
        print(f'{entry.name}')
        
        img = directory + (f"{entry.name}")

        img = png.Reader(img)
        width, height, input_rgba_pixels, info = img.read_flat()

        attr = liq.Attr()
        input_image = attr.create_rgba(input_rgba_pixels, width, height, info.get('gamma', 0))

        #attr = liq.Attr()
       # attr.max_colors = 16

        result = input_image.quantize(attr)

        
        out_pixels = result.remap_image(input_image)
        out_palette = result.get_palette()
        
        #out_img = Image.frombytes('P', (img.width, img.height), out_pixels)
        #palette_data = []
##        for color in out_palette:
##            palette_data.append(color.r)
##            palette_data.append(color.g)
##            palette_data.append(color.b)
##            #palette_data.append(color.a)
##
##            palette_data[0] = 0
##            palette_data[1] = 255
##            palette_data[2] = 0
        # Save it
        writer = png.Writer(input_image.width, input_image.height, palette=out_palette)
        with open('output.png', 'wb') as f:
            writer.write_array(f, out_pixels)

        #out_img.putpalette(palette_data)

        #out_img.save(f"png_test/{entry.name}", quality=100, optimize=True)






