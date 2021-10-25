## NarrowFont

This adds an additional narrow font (as well as some images using the text palette  
to your usual FE serif and menu font), which allows you to fit larger names and  
descriptions in less space.  

### Usage with TextProcess (Copied from Original post: https://feuniverse.us/t/blys-asm/2217/7)

* is used for the narrow serif font and ^ is used for the narrow menu font.  
In order from lowest priority to highest priority:  

Write text as *{text} or ^{text} to use the narrow font only for what’s inside the curly brackets. These brackets must be on the same line.  
Put a * or a ^ at the end of the first line for a text entry to use the narrow font for the whole text ID.  
Put a {* or a {^ instead to begin using the narrow font for this whole text ID and every text ID after.  
Put a } instead to stop using the narrow font. (Note that it will still use the narrow font for the whole text ID you put the } on.)  

### Usage without TextProcess (Copied from Information.txt)

To use it, you need to insert the values given in the two image file tables  
to get the desired character to show in text.  
