
from PIL import Image
from os import scandir




directory = 'PMD/'

#frame_width = 24 #40 
#frame_height = 32 #48 
height_fe8 = 32
width_fe8 = 32
filename = "/Walk-Anim.png"
pkmn_id = 0

def quantizetopalette(silf, palette, dither=False):
    """Convert an RGB or L mode image to use a given P image's palette."""

    silf.load()

    # use palette from reference image made below
    palette.load()
    im = silf.im.convert("P", 0, palette.im)
    # the 0 above means turn OFF dithering making solid colors
    return silf._new(im)



dir_entries = scandir(directory)
for entry in dir_entries:
    if entry.is_dir():
        pkmn_id += 1
        info = entry.stat()
        new_filename = str(pkmn_id)+"_PMD"
        print(new_filename)

#step 1: open image
   
        sprite_filename = directory + (f"{entry.name}") + filename

 

        
        blank_sms = Image.open("BlankSMS.png")
        blank_mms = Image.open("BlankMMS.png")
        
        im = quantizetopalette(Image.open(sprite_filename), blank_sms, dither=False)

        column = 1
        row = 0
        
        frame_width = im.size[0]/4 # defaults
        frame_height = im.size[1]/8
        
        if im.size[0] == 240:
            frame_width = im.size[0]/6
        if im.size[0] == 280:
            frame_width = im.size[0]/7
        if im.size[0] == 120:
            frame_width = im.size[0]/5
        if im.size[0] == 336:
            frame_width = im.size[0]/7

        
        if pkmn_id == 5: #charmeleon 
            frame_width = im.size[0]/4
        if pkmn_id == 10: #caterpie
            frame_width = im.size[0]/3

        divide_10_list = [11, 93, 109] # metapod, haunter, koffing 
        if pkmn_id in divide_10_list:
            frame_width = im.size[0]/10
            
        if pkmn_id == 13: #weedle
            frame_width = im.size[0]/3

        divide_7_list = [86, 101, 129, 148] # seel, electrode, magikarp, dragonair 
        if pkmn_id in divide_7_list: 
            frame_width = im.size[0]/7

            
        divide_6_list = [88, 90, 91, 110, 114, 150]
        # grimer, shellder, cloyster, weezing, tangela, mewtwo 
        if pkmn_id in divide_6_list: 
            frame_width = im.size[0]/6
        divide_5_list = [14, 16, 21, 37, 39, 48, 60, 89, 147]
        # kakuna, pidgey, spearow, vulpix, jigglypuff, venonat, poliwag,
        # muk, dratini 
        if pkmn_id in divide_5_list:
            frame_width = im.size[0]/5
        

            
        frame_1 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))
        column = 2
        frame_2 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))
        column = 3
        frame_3 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))
        # SMS 
        processed_sms = blank_sms
        processed_sms.paste(frame_1)
        processed_sms.paste(frame_2, (0,height_fe8*1))
        processed_sms.paste(frame_3, (0,height_fe8*2)) 
        processed_sms.save("SMS/"+new_filename+".png", quality=100, optimize=True)

        
        # MMS
        # down 
        #frame_4 = im.crop((frame_width*3, 0, frame_width*4, frame_height))
        #frame_5 = im.crop((frame_width*4, 0, frame_width*5, frame_height))

        # up
        row = 4
        column = 0
        frame_4 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))
        column = 1
        frame_5 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))
        column = 2
        frame_6 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))
        column = 3
        frame_7 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))

        # Sideways
        row = 6
        column = 0
        frame_8 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))
        column = 1
        frame_9 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))
        column = 2
        frame_10 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))
        column = 3
        frame_11 = im.crop((column*frame_width,row*frame_height,(column+1)*frame_width,(row+1)*frame_height))

        # sideways 
        processed_mms = blank_mms
        processed_mms.paste(frame_8, (0, height_fe8*0))
        processed_mms.paste(frame_9, (0, height_fe8*1))
        processed_mms.paste(frame_10, (0, height_fe8*2))
        processed_mms.paste(frame_11, (0, height_fe8*3))
        
        # down 
        processed_mms.paste(frame_1, (0, height_fe8*4))
        processed_mms.paste(frame_2, (0, height_fe8*5))
        processed_mms.paste(frame_2, (0, height_fe8*6))
        processed_mms.paste(frame_3, (0, height_fe8*7))
        
        # up 
        processed_mms.paste(frame_4, (0, height_fe8*8))
        processed_mms.paste(frame_5, (0, height_fe8*9))
        processed_mms.paste(frame_6, (0, height_fe8*10))
        processed_mms.paste(frame_7, (0, height_fe8*11))
        
        # hover
        processed_mms.paste(frame_1, (0, height_fe8*12))
        processed_mms.paste(frame_2, (0, height_fe8*13))
        processed_mms.paste(frame_3, (0, height_fe8*14))
        processed_mms.save("MMS/r"+new_filename+".png", quality=100, optimize=True)
        



        
        blank_sms.close()
        im.close()

#input('Press Enter to exit')








