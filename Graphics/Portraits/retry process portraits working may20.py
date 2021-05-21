from PIL import Image, ImageDraw, ImageOps, ImageEnhance, ImageFilter
from os import scandir

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
        transparent_col = (15,15,15) #(25,219,61)
        im_greenbg = Image.composite(im, Image.new('RGB', im.size, transparent_col), im).quantize(15) #white bg 
        im_whitebg = im_greenbg
        #im_whitebg = Image.alpha_composite(im, im).quantize(15) #white bg 
        
        
        resize_value = (64,64)
        resize2 = (64,64)
        offset = (0,0)
        offset2 = (16,8)
        minimug_offset = (96,16)
        resize_minimug = (32,32) 

        im_a_test = Image.composite(im, Image.new('RGB', im.size, transparent_col), im)#.quantize(15)
        im_a_test = im_a_test.resize(resize_value, Image.BICUBIC).quantize(15)
        
        im = im_whitebg
        im = im.resize(resize_value, Image.BICUBIC).quantize(15)
        im = im.convert('RGBA')
        minimug = im_greenbg.resize(resize_minimug, Image.BICUBIC).quantize(15)
        
        
        im_whitebg = Image.new("RGBA", resize2, 0)
        im_whitebg.paste(im, offset)
        im_white = ImageEnhance.Brightness(im).enhance(0.5)
        im_gray = im_whitebg.convert('L')
        
        im_por_temp = Image.open("portrait template.png")
        im_por_temp = Image.new('RGB', im_por_temp.size, transparent_col)
        im_mask = Image.open("small portrait template.png").convert('L')
        im5 = Image.new("RGBA", im_por_temp.size, 0)
        # im5 = Image.new("L", im2.size, 0)

        #im5.paste(im2, (0,0), im_mask)
        im4 = im5
        im4.paste(im_por_temp, (0,0))
        im4.paste(im_mask, offset2)
        im4.paste(im_a_test, offset2)
        #im4.paste(im_whitebg, offset2)
        im4.paste(minimug, minimug_offset)
        im5 = im4.quantize(16)
        
        # im4.paste(im, (16,16), im)
        # ImageDraw.floodfill(im4, xy=(0,0), value=(25, 219, 61, 255))
        #im5 = im4.quantize(16)

        
        im_test = im
        im_gray = im.convert('L')
        #im_gray = ImageEnhance.Brightness(im_gray).enhance(0.1)
        im_gray = ImageOps.invert(im_gray) # this stuff 
        im_blank = Image.new('RGB', resize_value, transparent_col).convert('L') #this stuff

        # im = Image.open(f"cq_test_batch/{entry.name}").resize((63, 63), Image.ANTIALIAS)

        im_to_paste = Image.new("RGBA", resize_value, transparent_col)
        
        #im_to_paste.paste(im, (0,0), im_gray)#, im_gray)
        imX = im_to_paste.convert('RGBA')
        
#create a grayscaled mask
        # im_bright = ImageEnhance.Brightness(im).enhance(0.5)
        # im_grayscaled = im_bright.convert('L')

        # im_inverted_mask = ImageOps.invert(im_grayscaled)


        # ImageDraw.floodfill(im, xy=(0,0), value=transparent_col)
        # im = im_gray
        #im = im.quantize(16)
        
#paste image into this mask
        im = Image.composite(im, Image.new('RGBA', im.size, transparent_col), imX) #.quantize(15) #green bg
        
        # im_pasted = im.bgcolor("#800080")
        # im_pasted = Image.new("RGB", (64,64),0)
        # im_pasted.paste(im, (0,0), im_shadow)

        #im = im_gray

        im5.save(f"Png/{entry.name}", quality=100, optimize=True)






