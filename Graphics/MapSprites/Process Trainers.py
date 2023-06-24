import PIL
from PIL import Image, ImageDraw, ImageOps, ImageEnhance, ImageFilter
import sys 
from os import scandir
import os 
import png
import libimagequant as liq



directory = 'FRLGRawTrainers/'
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

frame_width = 16
frame_height = 32 

palettedata = [ 0, 0, 0, 255, 0, 0, 255, 255, 0, 0, 255, 0, 255, 255, 255,85,255,85, 255,85,85, 255,255,85] 

dir_entries = scandir(directory)
for entry in dir_entries:
    if entry.is_file():
        info = entry.stat()
        print(f'{entry.name}')

#step 1: open image
        
        trainer_filename = directory + (f"{entry.name}")

 

        
        blank_sms = Image.open("BlankSMS.png")
        blank_sms_facing = Image.open("BlankSMS_Facing.png")
        blank_mms = Image.open("BlankMMS.png")
        
        im = Image.open(trainer_filename)

        frame_1 = im.crop((0,0,frame_width,frame_height))
        # SMS 
        processed_sms = blank_sms
        processed_sms.paste(frame_1)
        processed_sms.paste(frame_1, (0,frame_height*1))
        processed_sms.paste(frame_1, (0,frame_height*2)) 
        processed_sms.save(f"Trainer_SMS/SMS_{entry.name}", quality=100, optimize=True)


        # SMS_Facing
        frame_2 = im.crop((frame_width*1, 0, frame_width*2, frame_height))
        frame_3 = im.crop((frame_width*2, 0, frame_width*3, frame_height))
        frame_3_flip = frame_3.transpose(Image.Transpose.FLIP_LEFT_RIGHT)
        #.Transpose.FLIP_LEFT_RIGHT
        
        processed_sms = blank_sms_facing
        processed_sms.paste(frame_3) # left 
        processed_sms.paste(frame_3, (0,frame_height*1))
        processed_sms.paste(frame_3, (0,frame_height*2))
        processed_sms.paste(frame_3_flip, (0,frame_height*3)) # right 
        processed_sms.paste(frame_3_flip, (0,frame_height*4))
        processed_sms.paste(frame_3_flip, (0,frame_height*5))
        processed_sms.paste(frame_2, (0,frame_height*6)) # up 
        processed_sms.paste(frame_2, (0,frame_height*7))
        processed_sms.paste(frame_2, (0,frame_height*8))
        
        processed_sms.save(f"Trainer_SMS_Facing/SMS_facing_{entry.name}", quality=100, optimize=True)


        # MMS
        # down 
        frame_4 = im.crop((frame_width*3, 0, frame_width*4, frame_height))
        frame_5 = im.crop((frame_width*4, 0, frame_width*5, frame_height))

        # up 
        frame_6 = im.crop((frame_width*5, 0, frame_width*6, frame_height))
        frame_7 = im.crop((frame_width*6, 0, frame_width*7, frame_height))

        # Sideways 
        frame_8 = im.crop((frame_width*7, 0, frame_width*8, frame_height))
        frame_9 = im.crop((frame_width*8, 0, frame_width*9, frame_height))

        # sideways 
        processed_mms = blank_mms
        processed_mms.paste(frame_8, (8,0))
        processed_mms.paste(frame_9, (8, frame_height*1))
        processed_mms.paste(frame_8, (8, frame_height*2))
        processed_mms.paste(frame_9, (8, frame_height*3))
        
        # down 
        processed_mms.paste(frame_4, (8, frame_height*4))
        processed_mms.paste(frame_5, (8, frame_height*5))
        processed_mms.paste(frame_4, (8, frame_height*6))
        processed_mms.paste(frame_5, (8, frame_height*7))
        
        # up 
        processed_mms.paste(frame_6, (8, frame_height*8))
        processed_mms.paste(frame_7, (8, frame_height*9))
        processed_mms.paste(frame_6, (8, frame_height*10))
        processed_mms.paste(frame_7, (8, frame_height*11))
        
        # hover
        processed_mms.paste(frame_4, (8, frame_height*12))
        processed_mms.paste(frame_4, (8, frame_height*13))
        processed_mms.paste(frame_5, (8, frame_height*14))
        processed_mms.save(f"Trainer_MMS/MMS_{entry.name}", quality=100, optimize=True)
        



        
        blank_sms.close()
        im.close()




        ##


        
##
##        mug = im
##        mug = ImageEnhance.Contrast(im).enhance(mug_contrast)#.convert('RGBA')
##        #mug = ImageEnhance.Brightness(mug).enhance(1.2)
##
##
##        mug = mug.resize(resize_portrait, Image.LANCZOS) # NEAREST, BILINEAR, BICUBIC, LANCZOS 
##        
##
##        #minimug = ImageEnhance.Contrast(im).enhance(0.6).convert('RGBA')
##        #minimug = ImageEnhance.Brightness(minimug).enhance(1.2)
##        minimug = im_mini
##
##        minimug = minimug.resize(resize_minimug, Image.BICUBIC)
##
##
##        
##        im_por_temp = Image.open("portrait template.png")
##
##        im_mask = Image.open("small portrait template.png")#.convert('L')
##
##        im5 = Image.new("RGBA", im_por_temp.size)
##        portrait_border = Image.open("portrait border.png")
##        minimug_border = Image.open("minimug border.png")
##
##        if enable_portrait_bg:
##            im5.paste(im_mask, portrait_border_offset, im_mask)# This gives each portrait a white BG 
##
##
##        im5.paste(mug, portrait_offset, mug)
##
##        if enable_portrait_border:
##            im5.paste(portrait_border, portrait_border_offset, portrait_border)
##        
##        #output = im5
##
##
##        im5.paste(minimug, minimug_offset, minimug)#.quantize(16)
##        if enable_minimug_border:
##            im5.paste(minimug_border, minimug_border_offset, minimug_border)
##
##
##        img = im5
##
##        attr = liq.Attr()
##
##
##
##        img2 = png.Reader(portrait_filename)
##        width, height, data, info = img2.read_flat()
##
##        input_image = attr.create_rgba(img.tobytes(), img.width, img.height, info.get('gamma', 0))
##
##        attr = liq.Attr()
##        attr.max_colors = 16
##
##        result = input_image.quantize(attr)
##        out_pixels = result.remap_image(input_image)
##        out_palette = result.get_palette()
##        out_img = Image.frombytes('P', (img.width, img.height), out_pixels)
##        palette_data = []
##        for color in out_palette:
##            palette_data.append(color.r)
##            palette_data.append(color.g)
##            palette_data.append(color.b)
##            #palette_data.append(color.a)
##        # If index 0/1/2 is all white, then we don't adjust it
##        # Usually index 0/1/2 is the transparent bg colour 
##        if (palette_data[0] == 255):
##            if palette_data[1] == 255:
##                if palette_data[2] == 255:
##                    break
##        else:
##            palette_data[0] = 0
##            palette_data[1] = 255
##            palette_data[2] = 0
##
##        out_img.putpalette(palette_data)
##        
##        
##
##
##        im5 = out_img#.quantize(16)
##
##        im5.save(f"Png/{entry.name}", quality=100, optimize=True)






