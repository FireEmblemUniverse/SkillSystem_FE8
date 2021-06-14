QUICK NOTES
  This hack is made specifically with pokémblem in mind. There's also also a different version for 
  vanilla FE8 (will probably also be compatible with the SkillSystem, but this is as of yet, 30/10/2020 
  (EU), untested). If you want to use this, pokémblem, version for vanilla FE8, you'll have to swap the 
  value of gMovingMapSpriteData in Defs/Definitions.asm. I commented out the vanilla location of the 
  mapsprites.
  
  HAVING SAID THAT, please note that if, whether that's in pokémblem or vanilla fe8, you repoint the 
  moving map sprite data, which will most likely happen if you expand this table, you have to change 
  gMovingMapSpriteData's value to match!
  
  If you do change the definition of gMovingMapSpriteData you also have to put Init_MapSprites.asm and 
  Loop_MapSprites.asm through Lyn to re-obtain their .lyn.event counterparts. Alternatively, change every 
  occurance of gMovingMapSpriteData's previous value in Init_MapSprites.lyn.event and Loop_MapSprites to 
  match the new value.

  ChapterScreen assumes that ClassID fits in one byte, which should be the case in vanilla FE8U.
  IDK if people ever want to have over 255 classes but if they do, the moving map sprites in the chapter
  intro screen may be broken.


USAGE
  In FEBuilder: Advanced Editors -> Insert EA -> Open. Pick ChapterScreen.event and press Load Script. If 
  I'm not mistaken FEBuilder will just ignore the defined FreeSpace in ChapterScreen and use its own 
  generated value instead.

  Alternatively, if you're using buildfiles, #include ChapterScreen/ChapterScreen.event in your buildfile 
  and build.
  
  Lastly, if you only want to apply this hack to an otherwise clean FE8U ROM, open up Event Assembler, 
  throw in an FE8U ROM and ChapterScreen/ChapterScreen.event, and assemble for FE8.


IMPLEMENTATION DETAILS

  TABLES
    
    
  VSBGPaletteTables
    There's one table in Tables/VSBGPaletteTables, which is Example1.dmp. Feel free to modify this table 
    or create your own (in which case, update the reference in Tables/Tables.event accordingly).
    
    Anywho, this table holds single byte entries which indicate which palette to use for the Versus 
    Background, that flashy bar that scrolls on the screen. Each byte corresponds to a ChapterID; The 
    table is essentially indexed by chapters. If the 17th byte in the table is 0x6 for example, the 
    palette that the Versus Background will use for the chapter with ChapterID 17 (which is likely to be 
    chapter 16 if the prologue has ChapterID 0) will be palette number 6.
    
    There's only 64 palettes, and because each palette only represents different shades of the same hue, 
    palettes close to each other (e.g palette 23 & 24 which are close, unlike 23 & 34 which are further 
    apart) will resemble each other greatly. Make sure that no entry in the table will have a value 
    exceeding 0x3F (63 in decimal), or you'll load in things that aren't palettes.
    
    Finally, if you set an entry to 0, the Versus Background won't be drawn on the screen.
    
    
  AreaBG
    Tables/AreaBG/AreaBGTable.event holds two tables.
    
      - One table holds pointers to the Area Backgrounds. As they're pointers, each entry is four bytes.
      - The second table holds the corresponding palettes. As they're palettes, each entry is 32 bytes.
    
    Both tables are indexed by ChapterID, if you want AreaBG X to pop up for the chapter with
    ChapterID Y just put POIN X as entry number Y in table one, and #incbin or #incext the corresponding 
    palette in entry number Y in table two.
  
  
  SkipIntro
    Tables/SkipIntro/SkipIntroTable.dmp is a table indexed by chapter. If an entry is non-zero, the intro
    will be skipped during that chapter. If the SkipIntroFlag is set, the intro will be skipped as well, 
    regardless of the values in this table.
  

  GRAPHICS
  
  
  AreaBGs
    The Area Backgrounds are included in Graphics/AreaBG/AreaBG.event. The order in which they're included 
    is irrelevant.
    
    So, here's where things get kinda... different. Area Backgrounds are stored in 8bpp (8 bits per 
    pixel). 
    Most BGs and sprites are stored in 4bpp, but because AreaBGs are stored in 8bpp they have access to 
    ALL 16 background palettes. Now, we reserve the last two background palettes (for the Versus 
    Background and the Chapter Title), so AreaBGs only make use of the first 14 palettes, but that still 
    gives them access to 16x14 = 224 colours. Furthermore, the transparent colour WILL be visible 
    (methinks this is due to the background the AreaBGs are drawn on having the lowest priority/being 
    drawn first). Make sure that the image you wish to use as AreaBG makes use of no more than 224 colours!
    
    Now, because pixels are generally represented by 4 bits, to get Png2Dmp to compress an image in 8bpp, 
    every pixel in the image needs to be split in two pixels which represent 8 bits combined. Which is why 
    the example images included look like noisy 16-coloured stretched out versions of the image they 
    actually represent. For the life of me, I couldn't find an easy-to-use tool to generate these 
    noisystretch images, but I did find one tool that can pull it off, even if the method is a bit 
    tedious. That tool is FEBuilder. Here's how to get an 8bpp version and a palette from a 256x160 (or 
    240x160, considering how that's the screen size) image:
    
    - Open a clean FE8U ROM in FEBuilder. Go to Advanced Editors -> Patch and search for 'Light effect at 
    chapter start'. Select this patch and press the Graphics Editor button. This opens up a new window
    - In this window, increase the width to 32 (or 30 for 240x160 images) and the height to 20. Now press 
    Import Image and select the image you wish to prepare. If everything went right, no error message 
    appears.
    - Now if no image is shown, close the Graphics Editor, unselect 'Light effect at chapter start' 
    reselect 'Light effect at chapter start', and open up the Graphics Editor again. Hopefully you'll see 
    some (probably a bit jumbled) representation of the image you imported.
    - Set width and height to 32 (or 30) and 20 again and you should hopefully see the image you 
    originally imported again. Export this image. This image will be used to obtain the palette.
    - Now, set the width to 64 (or 60) and change 'Compression 256 Colors' to either 'Compressed Image' 
    or 'Split in Two'. You should now see the noisystretch image I mentioned before. Export this image. 
    This image will be used as the actual image for the Area Background.
    
	
	
	
    Now all you have to do is to include (by incext or incbin) the palette image and the noisystretch 
    image, and the AreaBG should hopefully appear properly. You don't have to save changes in the FE8U ROM.
  
  
  Mapsprites
    The mapsprites that are shown are taken from living units loaded in the UnitStruct (over at 
    0x0202BE4C). The more living units are loaded in here, the more mapsprites will appear during the 
    chapter intro and the longer it will take for the intro to finish. I made it this way in order to 
    show off all the units. Up to 52 units will be displayed. Of course the chapter intro can be skipped 
    at any time by the same means as the vanilla chapter intro screen can.


  MUSIC
  The song used during the chapter intro screen is ChapterIntro0.event. If you want to alter the song, 
  the original midi (created by moi, so I very much understand you'd wish to change them) can be found in 
  Music/songs. After saving the midi, just drag the .mid file over to MAKE SONG.cmd and it should 
  generate (The intermediate .s file and) the relevant .event file. The song uses up slot 0x318 in the 
  Song Table, but you can pick your own by changing the IntroSfx value in ChapterScreen.event


  DEBUGGING
  I've put curly brackets around ChapterScreen.event to avoid definitions clashing. This also means that 
  debugging in No$GBA can become harder as labels won't be generated into a .sym file. Just remove the 
  brackets to get the labels back.


CREDITS
Credits to:

  Agro/Brendor for the 16 Tracks/12 Sounds Fix.
  Alusq for the amazing music installer template they made.
  7743 for FEBuilder. Amazing multipurpose tool, great for documentation too!
  
  Game Freak for the VersusBG and DRAGOON for ripping it from Pokémon Platinum Version.
  Game Freak for the AreaBGs and Latias Tamer for ripping them from Pokémon HeartGold/SoulSilver Version.
  
  Huichelaar, that's me. Idk if it's rude putting yourself on a credit list, but I did make the thing.
  
Also a massive thank you to the people over at the FEU's discord #spell-academy channel who have:
  - helped me understand how thumb works.
  - made tutorials regarding inserting assembly, creating processes, using Lyn, reducing buildtime, etc.
  - referred me to great resources such as GBATek and tonc.
  

FINALLY
Already had a blurb here for the other version of this hack, but just wanted to add that getting the 
256-coloured BG thing working was very fun!