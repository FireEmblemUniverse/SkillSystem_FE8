#include "global.h"
#include "bmunit.h"
#include "bmitem.h"
#include "constants/items.h"

int GetClassBestWRankType(const struct ClassData *);

u16 GetClassAnimWeapon(u8 jid)
{
    const u8 weapons[] = {
        [ITYPE_SWORD] = ITEM_SWORD_IRON,
        [ITYPE_LANCE] = ITEM_LANCE_IRON,
        [ITYPE_AXE] = ITEM_AXE_IRON,
        [ITYPE_BOW] = ITEM_BOW_IRON,
        [ITYPE_STAFF] = ITEM_NONE,
        [ITYPE_ANIMA] = ITEM_ANIMA_FIRE,
        [ITYPE_LIGHT] = ITEM_LIGHT_LIGHTNING,
        [ITYPE_DARK] = ITEM_DARK_FLUX
    };

    return MakeNewItem(weapons[GetClassBestWRankType(GetClassData(jid))]);
}
