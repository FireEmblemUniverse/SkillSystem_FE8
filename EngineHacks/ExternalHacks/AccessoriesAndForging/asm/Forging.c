#include "Forging.h"
#include "FE-CLib/include/gbafe.h"

#define ITEM_INDEX(aItem) ((aItem) & 0xFF)
#define ITEM_USES(aItem) (((aItem) >> 8) & 0x3F)
#define ITEM_FORGED(aItem) (((aItem) >> 14) & 0x1)
#define ITEM_EQUIPPED(aItem) ((aItem) >> 15)
// Didn't work 
//#define ITEM_EQUIPPED(aItem) (((aItem) >> 15) & (GetItemAttributes(aItem) & IA_ACCESSORY))

/*
const ItemForgeBonuses *GetItemForgeBonuses(int itemIndex) {
	for(int i = 0; gForgeBonusLookupTable[i].itemId != 0; i++) {
		if(gForgeBonusLookupTable[i].itemId == ITEM_INDEX(itemIndex)) return gForgeBonusLookupTable + i;
	}
	return 0;
}
*/

/*
const ItemData* GetItemData(u8 itemIndex) {
    return gItemData + itemIndex;
}
*/

int GetItemUses(int item) {
    if (GetItemAttributes(item) & IA_UNBREAKABLE)
        return 0xFF;
    else
        return ITEM_USES(item);
}

/*
int GetItemMight(int item) {
	int mightBonus = 0;
	if(ITEM_FORGED(item)) {
		if (GetItemForgeBonuses(item) != 0) mightBonus = GetItemForgeBonuses(item)->mightBonus;
		else mightBonus = 1;
	}
	return GetItemData(ITEM_INDEX(item))->might;
}

int GetItemHit(int item) {
	int hitBonus = 0;
	if(ITEM_FORGED(item)) {
		if (GetItemForgeBonuses(item) != 0) hitBonus = GetItemForgeBonuses(item)->hitBonus;
		else hitBonus = 5;
	}
	return GetItemData(ITEM_INDEX(item))->hit;
}

int GetItemCrit(int item) {
	int critBonus = 0;
	if(ITEM_FORGED(item)) {
		if (GetItemForgeBonuses(item) != 0) critBonus = GetItemForgeBonuses(item)->critBonus;
		else critBonus = 5;
	}
	return GetItemData(ITEM_INDEX(item))->crit;
	//int GetItemCrit(int item);
}
*/



void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	
	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	int textColor = TEXT_COLOR_NORMAL;
	
		
	if (isItemAnAccessory) { // Vesly added 
		//Set the text color to white, then if the item is unusable set it to gray, else if the item is forged set it to blue
		if(!isUsable && !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
		//else if(ITEM_FORGED(item)) textColor = TEXT_COLOR_BLUE;
		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
		
	}
	Text_SetParameters(text, 0, textColor);
	
	//If the Item is Forged, add a + to the item name
	Text_DrawString(text, GetItemName(item));
	//if(ITEM_FORGED(item)) Text_DrawString(text, "+"); // removed it 

	Text_Display(text, mapOut + 2);
	
	
	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));

	
	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));

	DrawIcon(mapOut, GetItemIconId(item), 0x4000);

}

void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	
	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
		//Set the text color to white, then if the item is unusable set it to gray, else if the item is forged set it to blue
	int textColor = TEXT_COLOR_NORMAL;
		
	if (isItemAnAccessory) { // Vesly added 
		if(!isUsable) textColor = TEXT_COLOR_GRAY;
		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	}
	Text_SetParameters(text, 0, textColor);
	
	Text_DrawString(text, GetItemName(item));
	//if(ITEM_FORGED(item)) Text_DrawString(text, "+");

	Text_Display(text, mapOut + 2);

	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	//if (isItemAnAccessory) { // Vesly added 
		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	}


	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	}
	

		
    DrawIcon(mapOut, GetItemIconId(item), 0x4000);
}

void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
    Text_SetXCursor(text, 0);
    Text_DrawString(text, GetItemName(item));
	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
    Text_Display(text, mapOut + 2);

	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), GetItemUses(item));
	}
	
    DrawIcon(mapOut, GetItemIconId(item), 0x4000);
}

void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
    int color;
	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	
    Text_Clear(text);

    color = nameColor;
	
	if (isItemAnAccessory) { // Vesly 
		//if(ITEM_FORGED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_BLUE;
		if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	}
    Text_SetColorId(text, color);

    Text_DrawString(text, GetItemName(item));
	//if(ITEM_FORGED(item)) Text_DrawString(text, "+");

	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
		DrawSpecialUiChar(mapOut + 12, color, 0x16);

		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	}
	
	

	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
		DrawSpecialUiChar(mapOut + 12, color, 0x16);

		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	}
    Text_Display(text, mapOut + 2);

    DrawIcon(mapOut, GetItemIconId(item), 0x4000);
}

u16 GetItemAfterUse(int item) {
    if (GetItemAttributes(item) & IA_UNBREAKABLE)
        return item; // unbreakable items don't loose uses!

    item -= (1 << 8); // lose one use

    if (ITEM_USES(item) < 1)
        return 0; // return no item if uses < 0

    return item; // return used item
}
// commented out ?
// No forging, so no need 
/*
int DrawItemDescBoxInfo(u16 item) {
	struct TextHandle* text = (struct TextHandle*)0x203E7AC;
	Text_InsertString(text, 0, 8, GetWeaponTypeDisplayString(GetItemType(item)));
	
}

int DrawItemDescBoxStats(u16 item) {
	struct TextHandle* text = (struct TextHandle*)0x203E7AC;
	
	// Weapon Rank
	Text_InsertString(text, 32, 7, GetItemDisplayRankString(item));
	
	// Range
	Text_InsertString(text, 0x43, 7, GetItemDisplayRangeString2(item));
	
	// Weight
	Text_InsertNumberOr2Dashes(text, 0x81, 7, GetItemWeight(item));
	
	text = (struct TextHandle*)(0x203E7AC + 8);


	// Might
	Text_InsertNumberOr2Dashes(text, 0x20, 7, GetItemMight(item));

	// Hit
	Text_InsertNumberOr2Dashes(text, 0x51, 7, GetItemHit(item));

	// Crit
	Text_InsertNumberOr2Dashes(text, 0x81, 7, GetItemCrit(item));

}
*/
/*
void ForgeActiveUnitEquippedWeaponASMC() {
	int item = GetUnitEquippedWeapon(gActiveUnit);
	if(item) {
		gActiveUnit->items[GetUnitEquippedWeaponSlot(gActiveUnit)] = (item | 0x4000);
	}
}
*/
/*
int CanUnitSeize(Unit *unit) {
	if(unit->pCharacterData->attributes & CA_LORD != 0 || unit->pClassData->attributes & CA_LORD != 0) return 1;
	return 0;
}
*/
