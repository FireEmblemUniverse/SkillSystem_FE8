
#include "gbafe.h"

u8 CheckPromoItem(u16 item);
void DrawPromoPreview(u16 item);


struct PromoItemsListEntry
{
	u32 itemID;
	struct PromoItemClassListEntry* promoList;
};

struct PromoItemClassListEntry
{
	u8 baseClass;
	u8 promoClass;
};

extern struct PromoItemsListEntry PromoItemsList;

