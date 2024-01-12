#include "gbafe.h"

struct Anim {
    enum state {
        ANIM_BIT_ENABLED = (1 << 0),
        ANIM_BIT_HIDDEN  = (1 << 1),
        ANIM_BIT_2       = (1 << 2),
        ANIM_BIT_FROZEN  = (1 << 3),
    };

    /* 00 */ u16 state;
    /* 02 */ short xPosition;
    /* 04 */ short yPosition;
    /* 06 */ short timer;
    /* 08 */ u16 oam2Base;
    /* 0A */ u16 drawLayerPriority;
    /* 0C */ u16 state2;
    /* 0E */ u16 nextRoundId;
    /* 10 */ u16 state3;
    /* 12 */ u8 currentRoundType;
    /* 13 */ u8 unk13;

    /* 14 */ u8 commandQueueSize;
    /* 15 */ u8 commandQueue[7];

    /* 1C */ u32 oamBase;

    /* 20 */ const u32* pScrCurrent;
    /* 24 */ const u32* pScrStart;
    /* 28 */ const void* pImgSheet;
    /* 2C */ const void* pUnk2C;
    /* 30 */ const void* pSpriteDataPool; // aka "OAM data"

    /* 34 */ struct Anim* pPrev;
    /* 38 */ struct Anim* pNext;

    /* 3C */ const void* pSpriteData;
    /* 40 */ const void* pUnk40;
    /* 44 */ const void* pUnk44;
};

struct ProcPromoSel
{
    PROC_HEADER;
    s8 _u29;
    s8 _u2a;
    s8 _u2b;
    u16 u2c[3];
    u16 u32[3];
    s16 msg_desc[3];
    u16 _u3e;
    u8 u40;
    u8 menu_index;
    u16 pid;
    u16 u44;
    u8 u46;
    u8 u47;
    u16 u48;
    u8 u4a[3];
    u8 _u4d[3];
    u32 u50;
    Proc* menu_proc;
    /* ... more maybe */
};


struct Unknown_030053A0 {
    /* 00 */ u8 u00;
    /* 01 */ u8 u01;
    /* 02 */ u16 u02;
    /* 04 */ u16 u04;
    /* 06 */ u16 u06;
    /* 08 */ u16 u08;
    /* 0A */ u16 u0a;
    /* 0C */ u16 u0c;
    /* 0E */ u16 u0e;
    /* 10 */ u16 u10;
    /* 14 */ struct Anim *anim1;
    /* 18 */ struct Anim *anim2;
    /* 1C */ u8 *u1c;
    /* 20 */ u8 *u20;
    /* 24 */ u8 *u24;
    /* 28 */ u8 *u28;
    /* 2C */ u8 *_u2c;
    /* 30 */ struct Unknown_030053E0 * u30;
};

extern struct Unknown_030053A0 gUnknown_030053A0;

struct Unknown_0201FADC {
    /* 00 */ u16 things[8];
    /* 10 */ u16 _pad_10;
    /* 14 */ Proc* p1;
    /* 18 */ Proc* p2;
    /* 1c */ u32 u1c;
    /* 20 */ u8 *u20;
    /* 24 */ u32 _pad_24;
};

extern struct Unknown_0201FADC gUnknown_0201FADC;
extern int GetBattleAnimationId(struct Unit *unit, const void *anim, u16 wpn, u32 *out);
extern void sub_805A9E0(void); 
extern void sub_805AA28(struct Unknown_030053A0 *a);
extern u8 gUnknown_0895E0A4[];
extern u8 gUnknown_0895EEA4[];
extern void sub_80CD47C(int, int, int, int, int);
extern void sub_805AE14(void*);
extern void sub_80CD408(u32, s16, s16);
extern u8 sub_805A96C(struct Unknown_030053A0 *);
extern void sub_805A990(struct Unknown_030053A0 *);
extern void LoadClassNameInClassReelFont(struct ProcPromoSel *proc);
extern u8 gCharacterSelectorPlatformHeight;



void NewLoadBattleSpritesForBranchScreen(struct ProcPromoSel *proc) {
    u32 a;
    u8 b;
    struct ProcPromoSel *p2;
    struct ProcPromoSel *c2;
    struct Anim *anim1;
    struct Anim *anim2;
    struct Unit copied_unit;
    struct Unknown_030053A0 *tmp;
    struct Unknown_030053A0 *tmp2;
    u16 sp58;
    anim1 = gUnknown_030053A0.anim1;
    anim2 = gUnknown_030053A0.anim2;

    p2 = gUnknown_0201FADC.p1;
    c2 = gUnknown_0201FADC.p2;

    a = proc->u40;
    tmp = &gUnknown_030053A0;

    if (a == 1) {
        u16 r4, r6;
        s16 i;
        struct Unit *unit;
        const void * battle_anim_ptr;
        u32 battle_anim_id;
        u16 ret;
        if ((s16) p2->u32[0] <= 0x117) {
            p2->u32[0] += 12;
            c2->u32[0] += 12;
            anim1->xPosition += 12;
            anim2->xPosition = anim1->xPosition;
        } else {
            proc->u40 = 2;
        }
        if (proc->u40 == 2) {
            sub_805A9E0();
            sub_805AA28(&gUnknown_030053A0);
            r4 = proc->pid - 1;
            r6 = proc->u2c[proc->menu_index];
            sp58 = 0xffff;
            unit = GetUnitByCharId(proc->pid);
            copied_unit = *unit;
            copied_unit.pClassData = GetClassData(proc->u2c[proc->menu_index]);
            battle_anim_ptr = copied_unit.pClassData->pBattleAnimDef;
            ret = GetBattleAnimationId(
                &copied_unit,
                battle_anim_ptr,
                (u16) GetUnitEquippedWeapon(&copied_unit),
                &battle_anim_id);
            for (i = 0; i <= 6; i++) {
                if (gUnknown_0895E0A4[i + (s16) r4 * 7] == (s16) r6) {
                    sp58 = gUnknown_0895EEA4[i + (s16) r4 * 7] - 1;
                    break;
                }
            }
            sub_80CD47C((s16) ret, (s16) sp58, (s16) (p2->u32[0] + 0x28), gCharacterSelectorPlatformHeight, 6);
            sub_805AE14(&gUnknown_0201FADC);
            sub_80CD408(proc->u50, p2->u32[0], p2->msg_desc[1]);
        } else {
            goto D1AC;
        }
    }
    ++proc; --proc;
    b = proc->u40;
    tmp = &gUnknown_030053A0;
    if (b == 2) {
        if ((s16) p2->u32[0] > 0x82) {
#ifdef NONMATCHING
            u16 off = 12;
#else
            register u16 off asm("r1") = 12;
#endif // NONMATCHING
            p2->u32[0] -= off;
            c2->u32[0] -= off;
            anim1->xPosition -= off;
            anim2->xPosition = anim1->xPosition;
        } else {
            proc->u40 = 0;
        }
    }
D1AC:
    if ((u8) sub_805A96C(tmp)) {
        sub_805A990(tmp);
    }
    //LoadClassNameInClassReelFont(proc);
    return;
}






