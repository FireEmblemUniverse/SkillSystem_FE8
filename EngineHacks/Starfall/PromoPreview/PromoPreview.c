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
		
	
}
