from PIL import Image, ImageDraw, ImageOps, ImageEnhance, ImageFilter
from os import scandir
import os 
import libimagequant as liq
import png 

directory = 'test batch/'
directory = 'raw/'
resize_portrait = (60,60)
portrait_border_offset = (16,8)
portrait_offset = (18,10)
minimug_offset = (96,16)
minimug_border_offset = (96,16)
resize_minimug = (32,32)
enable_portrait_bg = False 
enable_portrait_border = False
enable_minimug_border = True
mug_contrast = 0.8


dir_entries = scandir(directory)
for entry in dir_entries:
    if entry.is_file():
        info = entry.stat()
        print(f'{entry.name}')

#step 1: open & resize image
        
        portrait_filename = directory + (f"{entry.name}")
        minimug_filename = directory + "minimugs/" + (f"{entry.name}")
        
        im = Image.open(portrait_filename)
        if os.path.isfile(minimug_filename):
            im_mini = Image.open(minimug_filename)
        else:
            im_mini = ImageEnhance.Contrast(im).enhance(mug_contrast)



        mug = im
        mug = ImageEnhance.Contrast(im).enhance(mug_contrast)#.convert('RGBA')
        #mug = ImageEnhance.Brightness(mug).enhance(1.2)


        mug = mug.resize(resize_portrait, Image.LANCZOS) # NEAREST, BILINEAR, BICUBIC, LANCZOS 
        

        #minimug = ImageEnhance.Contrast(im).enhance(0.6).convert('RGBA')
        #minimug = ImageEnhance.Brightness(minimug).enhance(1.2)
        minimug = im_mini

        minimug = minimug.resize(resize_minimug, Image.BICUBIC)


        
        im_por_temp = Image.open("portrait template.png")

        im_mask = Image.open("small portrait template.png")#.convert('L')

        im5 = Image.new("RGBA", im_por_temp.size)
        portrait_border = Image.open("portrait border.png")
        minimug_border = Image.open("minimug border.png")

        if enable_portrait_bg:
            im5.paste(im_mask, portrait_border_offset, im_mask)# This gives each portrait a white BG 


        im5.paste(mug, portrait_offset, mug)

        if enable_portrait_border:
            im5.paste(portrait_border, portrait_border_offset, portrait_border)
        
        #output = im5


        im5.paste(minimug, minimug_offset, minimug)#.quantize(16)
        if enable_minimug_border:
            im5.paste(minimug_border, minimug_border_offset, minimug_border)


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
        if (palette_data[0] == 255):
            if palette_data[1] == 255:
                if palette_data[2] == 255:
                    break
        else:
            palette_data[0] = 0
            palette_data[1] = 255
            palette_data[2] = 0

        out_img.putpalette(palette_data)
        
        


        im5 = out_img#.quantize(16)

        im5.save(f"Png/{entry.name}", quality=100, optimize=True)






