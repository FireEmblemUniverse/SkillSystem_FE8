#include "PromoPreview.h"

u8 CheckPromoItem(u16 item) {

	//given an item halfword, test for being a promo item
	//referencing the SplitPromoItems data
	
	item = (item & 0xFF); //just item ID
	struct PromoItemsListEntry* promoList = &PromoItemsList;
	while (promoList->itemID != 0) {
	
		if (item == promoList->itemID) break;
		promoList ++;
		
	}
	if (promoList->itemID == 0) return false;
	return promoList->itemID;
}

void DrawPromoPreview(u16 item) {

	//need to get the class we would promote into with the promo item, if any
	item = (item & 0xFF); //just item ID
	struct PromoItemsListEntry* promoList = &PromoItemsList;
	while (promoList->itemID != 0) {
	
		if (item == promoList->itemID) break;
		promoList ++;
		
	}
	if (promoList->itemID == 0) return;
	
	struct Unit activeUnit = *gActiveUnit;
	
	struct PromoItemClassListEntry* promoClassList = promoList->promoList;
	while (promoClassList->baseClass != 0) {
		
		if (activeUnit.pClassData->number == promoClassList->baseClass) break;
		promoClassList ++;
	}
	if (promoClassList->baseClass == 0) return;
	u8 promotedClass = promoClassList->promoClass;
	ClassData promotedClassEntry = gClassData[promotedClass];
	
	//draw fixed (externalized) text ID @ ~(136,96)
	const char* textID = GetStringFromIndex(PromotesToTextIDLink);
	TextHandle handle = {
			.tileIndexOffset = gpCurrentFont->tileNext,
			.tileWidth = 7
	};
	Text_Clear(&handle);
	Text_DrawString(&handle, textID);
	Text_Display(&handle, &gBG0MapBuffer[12][16]);
	
	//draw class name @ ~(14,16)
	const char* classTextID = GetStringFromIndex(promotedClassEntry.nameTextId);
	
	TextHandle classHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+7,
		.tileWidth = 12
	};
	Text_Clear(&classHandle);
	Text_DrawString(&classHandle,classTextID);
	Text_Display(&classHandle, &gBG0MapBuffer[14][16]);
	

	LoadIconPalette(1, 0xD);
	LoadIconPalette(0, 0xE);

	//draw class type icon @ ~(26,14)
	int classIcon = 0xFF;
	int attributes = promotedClassEntry.attributes;
	if ((attributes & CA_MOUNTED) != 0) classIcon = 0;
		if ((attributes & CA_PEGASUS) != 0) classIcon = 1;
		
		if ((attributes & CA_WYVERN) != 0) classIcon = 2;
	
	if (classIcon != 0xFF) {
		DrawIcon(&gBG0MapBuffer[14][26],classIcon|0x300,0xD000);
	}

	//draw class skill icon @ ~(26,16)
	if (ClassSkillTable[promotedClass] != 0) {
		DrawIcon(&gBG0MapBuffer[16][26],ClassSkillTable[promotedClass]|0x100,0xE000);
	}

	//draw icons for weapons w/o 0 base rank  
	//on promoted class @ ~(16,16), padded 
	//not padded actually because lol we have room for like 3 if we pad
	int wtIconOffset = 16;
	int wtIconIndex = 0;
	while (wtIconIndex < 8) {
		if (promotedClassEntry.baseRanks[wtIconIndex] != 0) {
			DrawIcon(&gBG0MapBuffer[16][wtIconOffset],wtIconIndex|0x400,0xD000);
			wtIconOffset += 2;
		}
		wtIconIndex ++;
	}
}
