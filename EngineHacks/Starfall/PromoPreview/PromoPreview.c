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
	
	//draw fixed (externalized) text ID @ ~(132,98)
	//draw class name @ ~(132,112)
	//draw icons for weapons w/o 0 base rank  
	//on promoted class @ ~(132,128), padded 
	//draw class type icon @ ~(208,104)
	//draw class skill icon @ ~(208,128)
	
}
