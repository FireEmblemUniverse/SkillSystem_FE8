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
void CopyMapPiece(u16 dst[], u8 xx, u8 yy, u8 real_x_max_size, u8 real_y_max_size, u16 defaultTile);
// SET_DATA MyMapBuffer, 0x203A000 in definitions.s 
extern const u8 DebugMapLabel[];
extern u8 MyMapBuffer[];
extern u8 MyMapBuffer2[];
extern int NumberOfMapPieces; 

struct MapPieces_Struct
{
	u8 x; 
	u8 y; 
	u16 data[0xff]; 
};
extern struct MapPieces_Struct* MapPiecesTable[0xFF];


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
	//asm("mov r11, r11");
	// uncompressed size is 0x512 / #1298 
	dst[0] = (((NextRN_N(25)+10)<<8) | (NextRN_N(20)+15)); 
	u8 x = (dst[0] & 0xFF); 
	u8 y = ((dst[0] & 0xFF00) >>8); // no -1 since compare as less than 
	
	// creates a randomized map 
	for (int iy = 0; iy<y; iy++) {
		for (int ix = 0; ix < x; ix++) {
			//if ((ix | iy) & (dst[iy*x+ix] == 0x200)) {  // if they are both 0, then it will overwrite coordinates 
			if (ix | iy){  // if they are both 0, then it will overwrite coordinates 
				u16 value = 0;
				while (!value) { // never be 0 
					value = NextRN_N(32) <<7 | (NextRN_N(32)<<2); // I think NextRN_N is 0-indexed, so given 4 it will return max 3 
				}
				//dst[iy*x+ix] = 0x268 + NextRN_N(3); //value; 
				if (NextRN_N(5) == 0 ) { 
					//dst[iy*x+ix] = value; 
					//u8 dst2[0xFF] = &dst[iy*x+ix];
					CopyMapPiece(dst, ix, iy, x, y, dst[y*x+x]); // bottom right tile as default tile 
				} // + NextRN_N(3); 
			} 
		}
	}
}

void CopyMapPiece(u16 dst[], u8 xx, u8 yy, u8 real_x_max_size, u8 real_y_max_size, u16 defaultTile)
{
	struct MapPieces_Struct* T = MapPiecesTable[NextRN_N(NumberOfMapPieces)];
	u8 size_x = T->x;
	u8 size_y = T->y;
	u8 exit = false; // false 
	
	
	for (u8 y = 0; y<size_y; y++) {
		for (u8 x = 0; x < size_x; x++) { // if any tile is not the default, then immediately exit 
			if (!(dst[((yy+y) * real_x_max_size) + xx+x] == defaultTile)) { exit = true; } 
		}
	}
		
		// this is to stop it from drawing outside the map / from one side to another 
	if (!((size_x + xx >= real_x_max_size) | (size_y + yy >= real_y_max_size) | (exit)))  { 
		for (u8 y = 0; y<size_y; y++) {
			for (u8 x = 0; x < size_x; x++) {
				dst[((yy+y) * real_x_max_size) + xx+x] = T->data[y*size_x+x]; 
			}
		}
	}

}




