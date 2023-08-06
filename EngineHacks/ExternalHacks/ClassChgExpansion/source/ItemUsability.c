#include "global.h"
#include "bmunit.h"
#include "bmitem.h"
#include "bmitemuse.h"
#include "constants/items.h"
#include "constants/characters.h"

#include "ClassChgExpansion.h"

/* LynJump! */
bool CanUnitUsePromotionItemRework(struct Unit * unit, int item)
{
    u8 tmp_buf[0x10];

    if (GetClasschgList(unit, item, tmp_buf, UNIT_PROMOT_LIST_MAX) > 0)
        return true;

    return false;
}
