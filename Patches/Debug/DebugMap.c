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
	for (int i = 1; i<300; i++)
	{
		dst[i] = 0x4; 
	}
	asm("mov r11, r11");

}





