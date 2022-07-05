#ifndef GBAFE_H
#define GBAFE_H

#ifdef __cplusplus
extern "C" {
#endif

// #include "global.h"

#include "gba/gba.h"

#include "constants/characters.h"
#include "constants/classes.h"
#include "constants/items.h"
#include "constants/terrains.h"

#include "agb_sram.h"
#include "anime.h"
#include "ap.h"
// #include "banim_data.h"
// #include "banim_pointer.h"
#include "bmdebug.h"
#include "bmidoten.h"
#include "bmio.h"
#include "bmitem.h"
#include "bmitemuse.h"
#include "bmmap.h"
#include "bmmenu.h"
#include "bmreliance.h"
#include "bmtrick.h"
#include "bmunit.h"
#include "bmbattle.h"
#include "chap_title.h"
#include "chap_title_pointer.h"
#include "chapterdata.h"
#include "convoymenu.h"
#include "cp_common.h"
#include "ctc.h"
#include "event.h"
#include "fontgrp.h"
#include "hardware.h"
#include "icon.h"
#include "m4a.h"
#include "mapselect.h"
#include "mu.h"
#include "packed_data_block.h"
#include "portrait_pointer.h"
#include "proc.h"
#include "raw_text_jp.h"
#include "rng.h"
#include "soundwrapper.h"
#include "statscreen.h"
#include "uimenu.h"
#include "uiutils.h"
#include "unit_icon_data.h"
#include "unit_icon_pointer.h"

#define CONST_DATA __attribute__((section(".data")))

#include "types.h"
#include "variables.h"
#include "functions.h"

// helper macros

#define ARRAY_COUNT(array) (sizeof(array) / sizeof((array)[0]))

#define RED_VALUE(color) ((color) & 0x1F)
#define GREEN_VALUE(color) (((color) >> 5) & 0x1F)
#define BLUE_VALUE(color) (((color) >> 10) & 0x1F)

#define ABS(aValue) ((aValue) >= 0 ? (aValue) : -(aValue))

#define SIN(aAngle) (gSinLookup[(aAngle&0xFF)])
#define COS(aAngle) (gSinLookup[0x40 + (aAngle&0xFF)])

#define RECT_DISTANCE(aXA, aYA, aXB, aYB) (ABS((aXA) - (aXB)) + ABS((aYA) - (aYB)))



#ifdef __cplusplus
} // extern "C"
#endif

#endif // GBAFE_H
