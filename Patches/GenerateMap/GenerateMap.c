#include "gbafe.h"
#include <string.h>
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




void CopyMapPiece(u16 dst[], u8 xx, u8 yy, u8 map_size_x, u8 map_size_y, u16 defaultTile);

extern int NumberOfMapPieces; 
extern int FrequencyOfObjects_Link; 
//extern int *GenerateMapRam_Link[]; 

struct GeneratedMapDimensions_Struct
{
	u8 min_x; 
	u8 min_y; 
	u8 max_x; 
	u8 max_y; 
};

extern struct GeneratedMapDimensions_Struct GeneratedMapDimensions;

struct MapPieces_Struct
{
	u8 x; 
	u8 y; 
	u16 data[0xff]; 
};
extern struct MapPieces_Struct* MapPiecesTable[0xFF];

struct Map_Struct
{
	u8 x; 
	u8 y; 
	u16 data[0xff]; 
};
void GenerateMap(struct Map_Struct* dst);


int hashCode(const char *str) {
    int hash = 0;

    for (int i = 0; i < strlen(str); i++) {
        hash = 31 * hash + str[i];
    }

    return hash;
}

// game time initialized -> chapter start events -> when map needs to be displayed, then it is loaded (so if you are faded in, events occur first) 

void GenerateMap(struct Map_Struct* dst)
{
	// 2 bytes are the map's XX / YY size
	// then it's just SHORTs of the different tileset IDs in a row as YY << 7 | XX << 2
	// uncompressed size is 0x512 / #1298
	extern struct ChapterState gChapterData; 

	// hooked InitChapterMap to update gChapterData._u04 right before LoadChapterMap instead of right after 
	
	
	// GmDataInit 0x80BC81C at BC884 calls SetRandState();
	// 300534D
	u16 saveRandState[3]; 
	//GetRandState(saveRandState);
	int clock = GetGameClock(); 
	int t_start = gChapterData._u04;
	//asm("mov r11, r11"); 
	if (t_start != clock) { 
		u16 var[3]; 
		var[0] = ((t_start-0xF0F0F0F0) & 0xFFFF); // clock at start of chapter 
		var[1] = (((t_start-0x0F0F0F0F) & 0xFFFF0000)>>16); 
		var[2] = hashCode(&gChapterData.playerName[0]);
		SetRandState(var); //! FE8U = (0x08000C4C+1)
	} 
	
	struct GeneratedMapDimensions_Struct dimensions = GeneratedMapDimensions;
	
	dst->x = (NextRN_N(dimensions.max_x-dimensions.min_x)+dimensions.min_x); 
	dst->y = (NextRN_N(dimensions.max_y-dimensions.min_y)+dimensions.min_y);
	u16 c = 0; 
	while (((dst->x * dst->y) > 1500) && (c<255)) { // redo if it will exceed max map size 
		dst->x = (NextRN_N(dimensions.max_x-dimensions.min_x)+dimensions.min_x); 
		dst->y = (NextRN_N(dimensions.max_y-dimensions.min_y)+dimensions.min_y);
		c++; 
	}
	if (c == 255) { dst->y = 10; }  // if we try 255 times and fail, make height the min of 10. 

	u8 map_size_x = dst->x;
	u8 map_size_y = dst->y; 
	//int FrequencyOfObjects_Link; 
	// creates a randomized map 
	for (int iy = 0; iy<map_size_y; iy++) {
		for (int ix = 0; ix < map_size_x; ix++) {
			//u16 value = 0;
			//while (!value) { // never be 0 
				//value = NextRN_N(32) <<7 | (NextRN_N(32)<<2); // I think NextRN_N is 0-indexed, so given 4 it will return max 3 
			//}
			//dst->data[iy*x+ix] = value;  // totally random tiles 
			
			if (FrequencyOfObjects_Link > NextRN_N(100)) { 
				
				CopyMapPiece(dst->data, ix, iy, map_size_x, map_size_y, dst->data[map_size_y*map_size_x+map_size_x]); // bottom right tile as default tile 
			}  
			//else { dst->data[iy * map_size_x + iy] = dst->data[map_size_y*map_size_x+map_size_x]; } 
		
		}
	}
	SetRandState(saveRandState); 
}



void CopyMapPiece(u16 dst[], u8 placement_x, u8 placement_y, u8 map_size_x, u8 map_size_y, u16 defaultTile)
{
	struct MapPieces_Struct* T = MapPiecesTable[NextRN_N(NumberOfMapPieces)];
	
	u8 piece_size_x = (T->x);
	u8 piece_size_y = (T->y);
	
	u8 exit = false; // default to false 

	u8 border_y = placement_y;
	u8 border_x = placement_x;
	if ((placement_y) && ((piece_size_y > 1)||(piece_size_x > 1))) { // border of 1 tile on left/above 
		border_y = placement_y - 1; 
	}
	if ((placement_x) && ((piece_size_y > 1)||(piece_size_x > 1))) { 
		border_x = placement_x - 1; 
	} 
	for (u8 y = 0; y <= piece_size_y+1; y++) {
		for (u8 x = 0; x <= piece_size_x+1; x++) { // if any tile is not the default, then immediately exit 
			if (dst[(border_y+y) * map_size_x + border_x+x] != defaultTile) { exit = true; } 
		}
	}
	
		// this is to stop it from drawing outside the map / from one side to another 
	if (!(((piece_size_x + placement_x) > map_size_x) || ((piece_size_y + placement_y) > map_size_y) || (exit)))  {
		for (u8 y = 0; y<piece_size_y; y++) {
			for (u8 x = 0; x < piece_size_x; x++) {
				//dst[((placement_y+y) * map_size_x) + placement_x+x] = T->data[y*piece_size_x+x]; 
				dst[((placement_y+y) * map_size_x) + placement_x+x] = T->data[y*piece_size_x+x]; 
			}
		}
	}

}

