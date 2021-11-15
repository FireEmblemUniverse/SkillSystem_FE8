Instructions
-


- Make your sprite sheet 16 colours with 0th as transparent (eg. use Usenti or FEB's Color Reduction Tool for this)
- Save as individual 64x64 images (eg. using Aseprite or GraphicsGale) 
- Create folder inside "png" folder with your images
- Run "Png2DmpImages.cmd" and "GenerateInstaller.cmd". 
	- - OPTIONAL:
	- - - Copy contents of "GeneratedInstaller.event" into the installer. 
	- - - Edit how many frames to display each image (default is 3 frames) 
	- - Alternatively, simply #include "GeneratedInstaller.event" if you want everything as 3 frames per image. 
- Add an entry to AnimTable.

