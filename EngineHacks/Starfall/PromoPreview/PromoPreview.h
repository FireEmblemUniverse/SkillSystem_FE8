
#include "gbafe.h"

u8 CheckPromoItem(u16 item);
void DrawPromoPreview(u16 item);

extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8. Ew why does FE-CLib-master not do it like this?
extern u16 gBG1MapBuffer[32][32]; // 0x020234A8.
extern u16 gBG2MapBuffer[32][32]; // 0x02023CA8.

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

extern int PromotesToTextIDLink;

extern u8 ClassSkillTable[256];
