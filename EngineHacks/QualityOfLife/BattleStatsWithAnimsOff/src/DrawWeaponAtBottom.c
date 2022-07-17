#include "gbafe.h"

extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8.
static void PrepareText(TextHandle* handle, char* string);
void DrawWeaponAtBottom(BattleUnit* unit, u8 xx, u8 yy); 

void DrawWeaponAtBottom(BattleUnit* unit, u8 xx, u8 yy) { 
// Text_ResetTileAllocation(); 
	u8 y_offset = 7; 
	u8 x_offset = 1; 
	
	u8 iconY = (y_offset + yy); 
	asm("mov r11, r11"); 
	u8 iconX = (x_offset + xx); 
	asm("mov r11, r11"); 
	int textY = (iconY << 2); //+ iconY; 
	int textX = iconX; // << 2); //+ iconX; 

	DrawIcon(&gBG0MapBuffer[iconY][iconX],GetItemIconId((unit->weaponBefore)),TILEREF(0, 0xC));
	LoadIconPalettes(0xC);
	
	TextHandle handles[1];
	PrepareText(&handles[0], GetItemName(unit->weaponBefore)); // my function 
	Text_Display(&handles[0], &gBG0MapBuffer[textY][textX+2]); // vanilla function 
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

