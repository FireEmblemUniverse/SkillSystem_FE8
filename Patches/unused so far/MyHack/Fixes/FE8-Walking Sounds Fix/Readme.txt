FE8 Walking Sounds Fix patch
By Tequila

This hack allows you to select what kind of walking sounds a class uses. Included with this file are 2 .dmp files. "walking_sounds_class_dict.dmp" is simply an array where the index is the class ID and the byte at that index is a number corresponding to the appropriate pointer in "walking_sounds_pointer_table.dmp".
Here are the entries of the latter:
0x0	Walking
0x1 Mounts (horses)
0x2 Wyverns
0x3 Pegasi
0x4 Armored units/Dragons
0x5 Fleet
0x6 F!Mamkute
0x7 Zombies
0x8 Skeletons
0x9 Spiders
0xA Dogs
0xB Mogalls
0xC Gorgon
If you want to change the Eirika lord class to use pegasus noises, for example, simply go to the [class ID-th] index of the first .dmp (in this case, 0x2), and change the value there to the sounds you want according to the second .dmp (in this case, 0x3).
The first table has 0xFF entries, so there's no need to expand it (the default option is 0x0). You can repoint it in the definitions if you want to. The second table can be expanded if you want to make custom walking noises, although you'll need to experiment a bit to find out how those work.