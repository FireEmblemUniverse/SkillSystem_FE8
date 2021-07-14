from PIL import Image, ImageDraw, ImageOps, ImageEnhance, ImageFilter
from os import scandir
import libimagequant as liq
import png 

dir_entries = scandir('raw/')
for entry in dir_entries:
    if entry.is_file():
        info = entry.stat()
        print(f'{entry.name}')

#step 1: open & resize image
        im = Image.open(f"raw/{entry.name}")

#brightness must occur after any 'Image.composite()'
        #im = ImageEnhance.Brightness(im).enhance(0.5)
        #im = im.convert("RGBA")
#version with white background
        transparent_col = (90,90,90) #(25,219,61)
        transparent_col = ("#800080")
        #im.bgcolor("#800080")
        im_contrast = ImageEnhance.Contrast(im).enhance(0.35) #0.5
        im_brightness = ImageEnhance.Brightness(im_contrast).enhance(1.5) #1.2
        
        im_greenbg = Image.composite(im_brightness, Image.new('RGB', im.size, transparent_col), im_contrast) #white bg 
        im_whitebg = im_greenbg.quantize(15)
        #im_whitebg = Image.alpha_composite(im, im).quantize(15) #white bg 
        
        
        resize_value = (64,72)
        resize2 = (64,72)
        offset = (0,0)
        offset2 = (16,4)
        minimug_offset = (96,16)
        resize_minimug = (32,32) 

        im_a_test = Image.composite(im_brightness, Image.new('RGB', im.size, transparent_col), im)#.quantize(15)
        im_a_test = im_a_test.resize(resize_value, Image.BICUBIC).quantize(15)

        mug = ImageEnhance.Contrast(im).enhance(0.6).convert('RGBA')
        mug = ImageEnhance.Brightness(mug).enhance(1.2)

        #mug = Image.composite(mug, Image.new('RGB', mug.size, transparent_col), mug) #white bg 
        
        mug = mug.resize(resize_value, Image.BICUBIC)#.quantize(16)
        

        minimug = ImageEnhance.Contrast(im).enhance(0.6).convert('RGBA')
        minimug = ImageEnhance.Brightness(minimug).enhance(1.2)

        #minimug = Image.composite(minimug, Image.new('RGB', minimug.size, transparent_col), minimug) #white bg 
        
        minimug = minimug.resize(resize_minimug, Image.BICUBIC)#.quantize(16)

        im = im_whitebg
        im = im.resize(resize_value, Image.BICUBIC).quantize(15)
        im = im.convert('RGBA')
        
        # .filter(ImageFilter.BLUR)
        im_whitebg = Image.new("RGBA", resize2, 0)
        im_whitebg.paste(im, offset)
        im_white = ImageEnhance.Brightness(im).enhance(0.5)
        im_gray = im_whitebg.convert('L')
        
        im_por_temp = Image.open("portrait template.png")
        #im_por_temp = Image.new('RGB', im_por_temp.size, transparent_col)
        im_mask = Image.open("small portrait template.png").convert('L')
        #im5 = Image.new("RGBA", im_por_temp.size, transparent_col)
        im5 = Image.new("RGBA", im_por_temp.size)


        
        #im5.paste(im_por_temp, (0,0))
        #im4.paste(im_mask, offset2)
        im5.paste(mug, offset2)


        im5.paste(minimug, minimug_offset)#.quantize(16)
        img = im5

        attr = liq.Attr()
        attr.max_colors = 16


        img2 = png.Reader(f"raw/{entry.name}")
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
        out_img.putpalette(palette_data)
        im5 = out_img.quantize(16)
        #out_img.save('output.png')


        
        im_test = im
        im_gray = im.convert('L')
        #im_gray = ImageEnhance.Brightness(im_gray).enhance(0.1)
        im_gray = ImageOps.invert(im_gray) # this stuff 
        im_blank = Image.new('RGB', resize_value, transparent_col).convert('L') #this stuff

        # im = Image.open(f"cq_test_batch/{entry.name}").resize((63, 63), Image.ANTIALIAS)

        im_to_paste = Image.new("RGBA", resize_value, transparent_col)
        
        


        #im = im_gray

        im5.save(f"Png/{entry.name}", quality=100, optimize=True)






