#include "gbafe.h"

extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8.
extern u16 gBG1MapBuffer[32][32]; // 0x020234A8.
static void PrepareText(TextHandle* handle, char* string);
void DrawWeaponAtBottom(BattleUnit* unit, u8 xx, u8 yy); 

extern const u16* gSmile;
extern const u16* Smile;
extern const u16* NewItemIcons; 



// PushToHiOAM(u16 xBase, u16 yBase, const struct ObjData* data, u16 tileBase);
// void RegisterTileGraphics(const void* source, void* target, unsigned size); //! FE8U = 0x8002015
// extern const struct ObjData gObj_16x16;

void DrawWeaponAtBottom(BattleUnit* unit, u8 xx, u8 yy) { 
// Text_ResetTileAllocation(); 
	u8 y_offset = 6; 
	u8 x_offset = 1; 
	
	struct BattleUnit* opponent; 
	if (&gBattleActor == unit) { opponent = &gBattleTarget; } 
	if (&gBattleTarget == unit) { opponent = &gBattleActor; } 
	
	u8 iconY = (y_offset + yy); 
	u8 iconX = (x_offset + xx); 
	if (unit->weaponBefore) { 
		DrawIcon(&gBG0MapBuffer[iconY][iconX],GetItemIconId((unit->weaponBefore)),TILEREF(0, 0xC));
		LoadIconPalettes(0xC);
		TextHandle handles[1];
		PrepareText(&handles[0], GetItemName(unit->weaponBefore)); // my function 
		Text_Display(&handles[0], &gBG0MapBuffer[yy+6][xx+4]); // vanilla function 
		// asm("mov r11, r11");
		//if (unit->battleAttack > opponent->battleAttack) { 
			//BgMapCopyRect(const u16* source, u16* target, int width, int height);
			//PushToHiOAM(u16 xBase, u16 yBase, const struct ObjData* data, u16 tileBase);
			//u16* source = (void*)0x6010980;
			
			u8 xDimension = 2; 
			u8 yDimension = 2; 
			
			int entries = 128; 
			u16 source[entries]; 
			for (u8 i = 0; i < entries; i++) { 
				source[i] = 0x5020; 
			} 
			for (u8 y = 0; y < yDimension; y++) { 
				for (u8 x = 0; x < xDimension; x++) { 
			
					gBG0MapBuffer[y][x] = 0x5020; 
				}
			} 
			//RegisterTileGraphics(Smile, (void*)0x6000, 4);
			RegisterFillTile(0xFFFF, (void*)0x6006000, 4);
			SyncRegisteredTiles();
			
			// Just tileIndex, no address for tileBase 
			//u16 tile = (0xC << 12) | 2; // Bits 12-15 as palette  
			//PushToHiOAM(0, 0, &gObj_16x16, tile); 
			//BgMapCopyRect(NewItemIcons, &gBG0MapBuffer[yy+6][xx+9], 2, 2); // happy 
			
			//RegisterTileGraphics(Smile, (void*)0x6006000, 128);
			//SyncRegisteredTiles();
			//BgMapCopyRect((void*)0x6006000, &gBG0MapBuffer[1][1], 2, 2); // happy 
			//BgMapCopyRect(&source[0], &gBG0MapBuffer[1][1], 2, 2); // happy 
		//} 
		if (unit->battleAttack < opponent->battleAttack) { 
			u16* source = (void*)0x60109C0;
			//BgMapCopyRect(NewItemIcons, &gBG0MapBuffer[yy+6][xx+9], 2, 2); // sad
			//BgMapCopyRect(NewItemIcons, &gBG0MapBuffer[4][4], 2, 2); // sad
		} 
		
	} 
} 


void PrepareText(TextHandle* handle, char* string)
{
	u32 width = (Text_GetStringTextWidth(string)+7)/8;
	Text_InitClear(handle, width); 
    handle->tileWidth = width;
	
	Text_SetColorId(handle,TEXT_COLOR_NORMAL);
	Text_DrawString(handle,string);
	//Text_Display(&handle,&gBG0MapBuffer[y][x]);
}

