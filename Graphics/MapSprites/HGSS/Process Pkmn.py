import PIL
from PIL import Image, ImageDraw, ImageOps, ImageEnhance, ImageFilter
import sys 
from os import scandir
import os 
import png
import libimagequant as liq



directory = 'Raw/'

frame_width = 33
frame_height = 42
#border_x = 1 # extra pixels between each frame
#border_y = 10 # extra pixels below each frame
height_fe8 = 32
width_fe8 = 32

palettedata = [ 0, 0, 0, 255, 0, 0, 255, 255, 0, 0, 255, 0, 255, 255, 255,85,255,85, 255,85,85, 255,255,85] 

dir_entries = scandir(directory)
for entry in dir_entries:
    if entry.is_file():
        info = entry.stat()

        for pkmn_id in range(151):
            #new_filename = "%03d" % (pkmn_id+1,)
            new_filename = str(pkmn_id+1)
            print(new_filename)

    #step 1: open image
       
            trainer_filename = directory + (f"{entry.name}")

     

            
            blank_sms = Image.open("BlankSMS.png")
            blank_mms = Image.open("BlankMMS.png")
            
            im = Image.open(trainer_filename)

            frame_index = 0
            

            frame_1 = im.crop((frame_index*frame_width,pkmn_id*frame_height,(frame_index+1)*frame_width,(pkmn_id+1)*frame_height))
            frame_index = 1
            frame_2 = im.crop((frame_index*frame_width,pkmn_id*frame_height,(frame_index+1)*frame_width,(pkmn_id+1)*frame_height))
            # SMS 
            processed_sms = blank_sms
            processed_sms.paste(frame_1)
            processed_sms.paste(frame_1, (0,height_fe8*1))
            processed_sms.paste(frame_2, (0,height_fe8*2)) 
            processed_sms.save("SMS/"+new_filename+".png", quality=100, optimize=True)

            
            # MMS
            # down 
            #frame_4 = im.crop((frame_width*3, 0, frame_width*4, frame_height))
            #frame_5 = im.crop((frame_width*4, 0, frame_width*5, frame_height))

            # up
            frame_index = 2
            frame_6 = im.crop((frame_index*frame_width,pkmn_id*frame_height,(frame_index+1)*frame_width,(pkmn_id+1)*frame_height))
            frame_index = 3
            frame_7 = im.crop((frame_index*frame_width,pkmn_id*frame_height,(frame_index+1)*frame_width,(pkmn_id+1)*frame_height))

            # Sideways
            frame_index = 4
            frame_8 = im.crop((frame_index*frame_width,pkmn_id*frame_height,(frame_index+1)*frame_width,(pkmn_id+1)*frame_height))
            frame_index = 5
            frame_9 = im.crop((frame_index*frame_width,pkmn_id*frame_height,(frame_index+1)*frame_width,(pkmn_id+1)*frame_height))

            # sideways 
            processed_mms = blank_mms
            processed_mms.paste(frame_8, (0, height_fe8*0))
            processed_mms.paste(frame_9, (0, height_fe8*1))
            processed_mms.paste(frame_8, (0, height_fe8*2))
            processed_mms.paste(frame_9, (0, height_fe8*3))
            
            # down 
            processed_mms.paste(frame_1, (0, height_fe8*4))
            processed_mms.paste(frame_2, (0, height_fe8*5))
            processed_mms.paste(frame_1, (0, height_fe8*6))
            processed_mms.paste(frame_2, (0, height_fe8*7))
            
            # up 
            processed_mms.paste(frame_6, (0, height_fe8*8))
            processed_mms.paste(frame_7, (0, height_fe8*9))
            processed_mms.paste(frame_6, (0, height_fe8*10))
            processed_mms.paste(frame_7, (0, height_fe8*11))
            
            # hover
            processed_mms.paste(frame_1, (0, height_fe8*12))
            processed_mms.paste(frame_1, (0, height_fe8*13))
            processed_mms.paste(frame_2, (0, height_fe8*14))
            processed_mms.save("MMS/r"+new_filename+".png", quality=100, optimize=True)
            



            
            blank_sms.close()
            im.close()








