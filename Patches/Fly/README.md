# ChapterJump

## Credits:
Many thanks to Huichelaar and Vesly for making the chapter menu setup that I piggybacked off of.  
Special thanks espcially to Stan for making the skill debug menu that I used as reference for my own menu.

## Instructions:
Include `ChapterJump.event` somewhere in your buildfile.  
The DebugEventTable can be used to start a specified event right before the jump (Very useful for setting flags or loading units).

Once installed, start your ROM and start the chapter menu (The one that pops up when you press A when the cursor is over a tile with no unit on it).  
You should see the `ChJump` command. Once selected, use the left and right dpad buttons to select a chapter, and press A to jump to the chapter.

## Afterword:
This hack uses MNC2, so without the proper setup there will be a few oddities like `Ex chapter` being displayed in the preps menu of chapters that have skirmish data.  
(I likely will not be making a non-MNC2 version since I do not use the world map or skirmishes).

This hack only goes up to the vanilla amount of chapters (I might expand that later).  
If a chapter doesn't have a title TextID assigned to it, a single digit will display instead of the chapter name. I intend on fixing this eventually.
