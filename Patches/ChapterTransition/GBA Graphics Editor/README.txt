GBA Graphics Editor

--------
History:
--------

V 1.0
-First public release.

V 1.1
-Fixed error with writing edited palette to ROM.
-Added more control with scrolling through ROM.

V 1.2
-Added 256 colour mode.
-Fixed tool window disappearing glitch.
-Removed the Write To ROM button from Colour Control.
 Changes to colours are automatically written to ROM.

V 1.3
-Added deep scan.
-Fixed random freezing that happens when picture box's 
 image gets assignied to.
-Fixed freezing when adding uncompressable offsets.

V 2.0
-Added TSA editing and viewing support
-Added support for GBA Bitmap graphics modes
-Rewrote most of the source, hopefully fixing all old bugs
-Added icon made by mystery.

V 2.1
-Fixed a bug relating to changing offset with +/- Block/Line/Screen.
-Fixed a bug that crashes the app when no compressed offsets are found.
-Made compressed options become unabled when data can't be decompressed.

V 2.2
-Added mas tile flipping and image rotation/flipping options.
-Made compressed palette offsets save properly to NLZ file.
-Disabled editing compressed palette's and TSA's in app.
-Fixed crash on trying to select color not in palette.
-Made app properly report errors on improperly sized bitmaps in tiled mode.
-Fixed bug with Screen+/- buttons

----
GUI:
----

Main form:
-File:
--Open ROM: Opens the ROM you wish to edit.
--Save: Saves the changes you have made into the ROM
--Save As: Saves the changes you have made into a new ROM.
--Exit: Exits without saving the changes.
--Load a .nlz file: Loads a file containing compressed graphics 
  offsets and palette offsets.
--Load a palette file: Load colours from a .pal file made by VBA.
--Rescan: Scans the ROM for LZ77 compressed graphics and overwrites
  current graphics and palette offsets.
--Deep scan: Scans the ROM for graphics with lower standards than
  normal scan, resulting more results.

-Windows: Controls which windows are visible or not.

-Image control: Controls where and how graphcis are loaded.
--Compressed graphics: Controls weather you are viewing compressed
  or raw graphics
--Offset: The offset of the graphics you are vieving.
-- +/- Block/Line/Screen: Changes graohics offset
--Save as bitmap: Saves currently viewed graphics as a image file.
  Supported image formats: PNG, GIF, BMP
--Raw dump: Saves raw, uncompressed graphics in GBA format.
--Import a bitmap: Imports graphics and/or palette to the ROM.
--Load Raw: Loads and writes raw GBA graphics data to the ROM.
--Compressed controls:
---Image: The index of the compressed graphics you are viewing.
---Amount of added blocks: Shows how many 8*8 or 1*1 pixel blocks were 
   added to the graphics until it became into a rectangle.
--Size:
---Widht: Widht of the viewed graphics in 8 pixels.
---Height: Height of the graphics in 8 pixels.

-Palette control: Controls where and how palette is loaded.
--Graphics mode: Controls the mode of graphics
--Palette Control:
---Gray scale: Shows graphics in Gray scale palette
---Use palette from PAL file: Uses PAL file palette for viewing 
   graphics. Can only be used after you load a PAL file.
---Compressed ROMpalette: Controls weather ROMpalette is decompressed
   or not. Can only be used if palette offset can be decompressed
---ROM palette(s) offset: Controls the palette wherre ROM palette is 
   loaded from.
---Palette index: Controls the starting point of the palette used for 
   viewing the graphics. Only used for 4bit tile graphics.

-Color Control: Can be used to view and edit palette.
--Colours: Click the change the colour you want to edit.
--Color to Edit: The index of the colour you wish to edit.
--Red, Green, Blue: The color values of the colour.
--Save palette as bitmap: saves the screen with colours as a bitmap.

-Tile Control:
--Vertically flip all tiles: Exatly what you'd think.
--Horizontally flip all tiles: Same.
--TSA:
---Use TSA: Use TSA to manipulate how graphics are displayed.
---Compressed: Controls weather TSA is LZ77 compressed
---Offset: Offset of the TSA.
---Amount of bytes etc.: As it say in the name.
--Tile:
---Tile index: Index of the tile in TSA data.
---Graphics: Graphics block that tile uses.
---Palette: Palette used by the tile.
---Flip: 
----Vertical: Checked if tile flipped vertically.
----Horizontical: Checked if tile flipped horizontally.

--------
Credits:
--------

-Nintenlord: For making this utility.
-Mystery: For making the Icon this program uses.
-Members of FEU: Suggestions, bug reports and testing.
-You: For having the brains to read the Readme. You're awesome!

------------
Legal stuff:
------------

This program and everything it comes with, referred 
as product from now on, is delivered as is and 
has no warranty what so ever.
You can modify, add and distribute the product as
you wish, but the origin of the product must not be 
misinterpretted by anyone and this README.txt file must
remain included and unmodified.