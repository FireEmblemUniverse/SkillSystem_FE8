Instructions
-


- Make your sprite sheet 16 colours with 0th as transparent (eg. use Usenti or FEB's Color Reduction Tool for this)
- Save as individual 64x64 images (eg. using Aseprite or GraphicsGale) 
- Create folder inside "png" folder with your images
- Run "Png2DmpImages.cmd" and "GenerateInstaller.cmd". 
	- - OPTIONAL:
	- - - Copy contents of "GeneratedInstaller.event" into the installer. 
	- - - Edit how many frames to display each image (default is 2 frames) 
	- - Alternatively, simply #include "GeneratedInstaller.event" if you want everything as 2 frames per image. 
- #incbin the palette. Eg.
```ALIGN 4 
FOLDERNAMEData_pal:
#incbin "Dmp/Fireball_0000_pal.dmp"```
- Add an entry to AnimTable. Eg.
```POIN FOLDERNAME_Anim FOLDERNAMEData_pal; SHORT 0 0```
