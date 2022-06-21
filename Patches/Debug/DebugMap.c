#include "gbafe.h"
// F42C Event2A_MoveToChapter
// gets chapter ID (sometimes from mem slot 2) 
// stores this to gChapterData + 0x4A as chapter to go to 
// passes 1, 2, or 3 to 0x08009F50   //SetNextGameActionId
// in procs_gamectrl 0x85916D4 it calls SetupChapter 0x8030E05 at $5918DC in label 7 
// gChapterData + 0x04 looks like chapter clock time at start of the chapter 
// +0x48 looks like Total Support Points at start of the chapter
// I dunno what +0x4A and +0x4B are but I think there's some bitpacking going on and 
// +0x4A seems to be set depending on what MNC version you do
// InitChapterMap at 194BC calls LoadChapterMap at 198AC which decompresses map 
// [0x80198B8]







void DebugMap_ASMC(u16 dst[]); // ASMC 
// SET_DATA MyMapBuffer, 0x203A000 in definitions.s 
extern const u8 DebugMapLabel[];
extern u8 MyMapBuffer[];
extern u8 MyMapBuffer2[];


void DebugMap_ASMC(u16 dst[]) // ASMC 
{
	//memset(gGenericBuffer, 0, 1600);
	//memcpy(gGenericBuffer, DebugMapLabel, 660); // dst, src, size 
	//
	//memset(gGenericBuffer+1600, 0, 1600);
	//Decompress(gGenericBuffer,(void*)gGenericBuffer+1600);
	//gGenericBuffer[2] = 0; 
	//memcpy(dst, gGenericBuffer+1600, 1298); // dst, src, size 
	
	// 2 bytes are the map's XX / YY 
	// then it's just SHORTs of the different tileset IDs in a row 
	asm("mov r11, r11");
	// uncompressed size is 0x512 / #1298 
	u8 x = (dst[0] & 0xFF); 
	u8 y = ((dst[0] & 0xFF00) >>8); // no -1 since compare as less than 
	
	for (int iy = 0; iy<y; iy++) {
		for (int ix = 0; ix < x; ix++) {
			if (ix | iy) {  // if they are both 0, then it will overwrite coordinates 
				u16 value = 0;
				while (value == 0) { // never be 0 
					value = NextRN_N(31) <<6 | NextRN_N(31);
				}
				dst[iy*x+ix] = value; 
			} 
		}
	}
	asm("mov r11, r11");

}





