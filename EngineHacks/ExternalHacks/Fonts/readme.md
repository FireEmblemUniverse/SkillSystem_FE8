

1. Create your font character(s) and name them `FontItem{}.png` or `FontText{}.png`  
2. Replace `{}` with the character you are mapping. Eg. `ނ` will show up ingame as narrowfont `.`
3. Paste the png image(s) into Fonts/FontData 
4. Double click CreateFont.bat (you will need python installed for this) 

After running CreateFont.Bat, edit the two short spaces mapped to ް to be width of 2 instead of 0/1. 

Text_00B0_.event & Item_00B0_.event
ALIGN 4
Fonts(0x0007, 2)
	#incbin "../FontData/FontItemް.fefont"



5. If desired, add the symbol to ParseDefinitions.txt, located in Root/Text. 
See chart below for what bytes to put for a character. 
https://www.charset.org/utf-8/2 ctrl+f `ނ` or `DE 82` 
[period] = [0xDE][0x82]
Note that ParseText.exe is slow the first use after ParseDefinitions.txt has been edited. 

How do I add character(s) to be automatically processed via text-process? 
- This is likely unnecessary for you, but add the character and its mapping to Root/Tools/text-process-classic.py
- NARROW_DICT and NARROW_MENU_DICT map each letter. 
- `"a":"[0xe1][0xb5][0x83]",` turns `a` into narrowfont `ᵃ` when using `^{text}` / `*{text}` 






