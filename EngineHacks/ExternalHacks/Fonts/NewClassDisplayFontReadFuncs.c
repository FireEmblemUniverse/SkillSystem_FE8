#include "global.h"
#include "classchg.h"
#include "proc.h"
#include "hardware.h"
#include "scene.h"
#include "classdisplayfont.h"
#include "constants/video-global.h"
#include "constants/classes.h"
#include "bmlib.h"
#include "ctc.h"
#include "fontgrp.h"
#include "uiutils.h"
#include "ekrbattle.h"
#include "efxbattle.h"
#include "bmsave.h"
#include "bm.h"
#include "bmmind.h"
#include "bmio.h"
#include "bmmap.h"
#include "mu.h"
#include "bmudisp.h"
#include "bmitem.h"
#include "prepscreen.h"
#include "variables.h"

#define CLASS_NAME_BUFFER_SIZE 64

void LoadClassReelFontPalette(struct ProcPromoSel *proc, int class_id) {
    int i;
    s8 str[CLASS_NAME_BUFFER_SIZE];
    const struct ClassData *class;
    u8 _pad_[0xC];
    u16 jid = class_id;

    proc->u44 = 0;
    proc->u46 = 0;
    proc->u47 = 0x78;
    class = GetClassData(jid);
    GetStringFromIndexInBuffer(class->nameTextId, str);

    for (i = 0; i < CLASS_NAME_BUFFER_SIZE /* sizeof(str) */ && str[i] != '\0'; i++) {
        struct ClassDisplayFont *font = GetClassDisplayFontInfo(str[i]);
        if (font)
            proc->u46 += font->width - font->xBase;
        else
            proc->u46 += 4;
    }

    Decompress(&Img_ClassReel_ClassNameLetters, OBJ_VRAM0 + 0x1000);
    ApplyPalettes(Pal_ClassReel_ClassNameLetters, 0x14, 0x2);
}

void LoadClassNameInClassReelFont(struct ProcPromoSel *proc) {
    s8 str[CLASS_NAME_BUFFER_SIZE];
    s32 index;
    u8 idx = proc->main_select;
    u16 classNum = proc->jid[idx];
    u32 xOffs = 0x74;
    const struct ClassData *class = GetClassData(classNum);
    GetStringFromIndexInBuffer(class->nameTextId, str);
    for (index = 0; index < CLASS_NAME_BUFFER_SIZE && str[index] != '\0'; index++) {
        struct ClassDisplayFont *font = GetClassDisplayFontInfo(str[index]);
        if (font) {
            if (font->a) {
                PutSpriteExt(4, xOffs - font->xBase - 2, font->yBase + 6, font->a, 0x81 << 7);
                xOffs += font->width - font->xBase;
            }
        } else {
            xOffs += 4;
        }
    }

    if (proc->u44 < 0xff)
        proc->u44++;
}