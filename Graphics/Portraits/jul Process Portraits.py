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

        transparent_col = (90,90,90) #(25,219,61)
        transparent_col = ("#800080")
        #im.bgcolor("#800080")

        resize_value = (64,72)
        resize2 = (64,72)
        offset = (0,0)
        offset2 = (16,4)
        minimug_offset = (96,16)
        resize_minimug = (32,32) 

        mug = im
        #mug = ImageEnhance.Contrast(im).enhance(0.6).convert('RGBA')
        #mug = ImageEnhance.Brightness(mug).enhance(1.2)

        #mug = Image.composite(mug, Image.new('RGB', mug.size, transparent_col), mug) #white bg 
        
        mug = mug.resize(resize_value, Image.BICUBIC)#.quantize(16)
        

        #minimug = ImageEnhance.Contrast(im).enhance(0.6).convert('RGBA')
        #minimug = ImageEnhance.Brightness(minimug).enhance(1.2)
        minimug = im 
        #minimug = Image.composite(minimug, Image.new('RGB', minimug.size, transparent_col), minimug) #white bg 
        
        minimug = minimug.resize(resize_minimug, Image.BICUBIC)#.quantize(16)


        
        im_por_temp = Image.open("portrait template.png")

        im_mask = Image.open("small portrait template.png").convert('L')

        im5 = Image.new("RGBA", im_por_temp.size)

        im5.paste(mug, offset2)


        im5.paste(minimug, minimug_offset)#.quantize(16)

        img = im5

        attr = liq.Attr()



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
            #palette_data.append(color.a)
        out_img.putpalette(palette_data)


        im5 = out_img#.quantize(16)

        im5.save(f"Png/{entry.name}", quality=100, optimize=True)






