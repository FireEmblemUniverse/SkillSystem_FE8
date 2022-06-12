from PIL import Image, ImageDraw, ImageOps, ImageEnhance, ImageFilter
from os import scandir
import os 
import libimagequant as liq
import png 

directory = 'raw/'
portrait_size = (64,64)
portrait_offset = (128,48)

dir_entries = scandir(directory)
for entry in dir_entries:
    if entry.is_file():
        info = entry.stat()
        print(f'{entry.name}')

#step 1: open & resize image
        
        portrait_filename = directory + (f"{entry.name}")
        im = Image.open(portrait_filename).convert('RGBA')



        mug = im


        mug = mug.resize(portrait_size, Image.LANCZOS) # NEAREST, BILINEAR, BICUBIC, LANCZOS 

        im_por_temp = Image.open("blank.png")

        im5 = Image.new("RGBA", im_por_temp.size)

        im5.paste(mug, portrait_offset, mug)

        img = im5

        attr = liq.Attr()



        img2 = png.Reader(portrait_filename)
        width, height, data, info = img2.read_flat()

        input_image = attr.create_rgba(img.tobytes(), img.width, img.height, info.get('gamma', 0))

        attr = liq.Attr()
        attr.max_colors = 16

        result = input_image.quantize(attr)
        out_pixels = result.remap_image(input_image)
        out_palette = result.get_palette()
        out_img = Image.frombytes('P', (img.width, img.height), out_pixels)
        palette_data = []
        for color in out_palette:
            palette_data.append(color.r)
            palette_data.append(color.g)
            palette_data.append(color.b)
            #palette_data.append(color.a)
        # If index 0/1/2 is all white, then we don't adjust it
        # Usually index 0/1/2 is the transparent bg colour
        
        if ((palette_data[0] == 255) | (palette_data[0] == 0)):
            if ((palette_data[1] == 255) | (palette_data[1] == 0)):
                if ((palette_data[2] != 255) | (palette_data[2] != 0)):
                    palette_data[0] = 0
                    palette_data[1] = 255
                    palette_data[2] = 0

        out_img.putpalette(palette_data)
        
        


        im5 = out_img#.quantize(16)

        im5.save(f"Png/{entry.name}", quality=100, optimize=True)

        #print(f"Png/{entry.name}" + ".txt")
        #with open(f"bin/{entry.name}" + ".bin", 'w') as fp: 
         #   pass # make a bunch of empty .bin files to write over when exporting via feb 

        with open(f"Png/{entry.name}" + ".txt", 'w') as f:
            f.write('/// - Mode 1\n')
            f.write('C03\n')
            f.write('C07\n')
            f.write('7 p- ' + f"{entry.name}\n")
            f.write('C05\n')
            f.write('C01\n')
            f.write('7 p- ' + f"{entry.name}\n")
            f.write('C06\n')
            f.write('C0D\n')
            f.write('~~~\n')
            f.write('/// - Mode 3\n')
            f.write('C03\n')
            f.write('C07\n')
            f.write('7 p- ' + f"{entry.name}\n")
            f.write('C05\n')
            f.write('C01\n')
            f.write('7 p- ' + f"{entry.name}\n")
            f.write('C06\n')
            f.write('C0D\n')
            f.write('~~~\n')
            f.write('/// - Mode 5\n')
            f.write('C03\n')
            f.write('C07\n')
            f.write('7 p- ' + f"{entry.name}\n")
            f.write('C06\n')
            f.write('C0D\n')
            f.write('~~~\n')
            f.write('/// - Mode 6\n')
            f.write('C03\n')
            f.write('C07\n')
            f.write('7 p- ' + f"{entry.name}\n")
            f.write('C05\n')
            f.write('C01\n')
            f.write('~~~\n')
            f.write('/// - Mode 7\n')
            f.write('C02\n')
            f.write('4 p- ' + f"{entry.name}\n")
            f.write('4 p- ' + f"{entry.name}\n")
            f.write('C0E\n')
            f.write('20 p- ' + f"{entry.name}\n")
            f.write('4 p- ' + f"{entry.name}\n")
            f.write('4 p- ' + f"{entry.name}\n")
            f.write('C01\n')
            f.write('C0D\n')
            f.write('~~~\n')
            f.write('/// - Mode 8\n')
            f.write('C02\n')
            f.write('4 p- ' + f"{entry.name}\n")
            f.write('4 p- ' + f"{entry.name}\n")
            f.write('C0E\n')
            f.write('20 p- ' + f"{entry.name}\n")
            f.write('4 p- ' + f"{entry.name}\n")
            f.write('4 p- ' + f"{entry.name}\n")
            f.write('C01\n')
            f.write('C0D\n')
            f.write('~~~\n')
            f.write('/// - Mode 9\n')
            f.write('3 p- ' + f"{entry.name}\n")
            f.write('C01\n')
            f.write('~~~\n')
            f.write('/// - Mode 10\n')
            f.write('3 p- ' + f"{entry.name}\n")
            f.write('C01\n')
            f.write('~~~\n')
            f.write('/// - Mode 11\n')
            f.write('3 p- ' + f"{entry.name}\n")
            f.write('C01\n')
            f.write('~~~\n')
            f.write('/// - Mode 12\n')
            f.write('4 p- ' + f"{entry.name}\n")
            f.write('C01\n')
            f.write('~~~\n')
            f.write('/// - End of animation\n')



