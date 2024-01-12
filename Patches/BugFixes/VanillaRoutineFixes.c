#include "include/global.h"
#include "include/hardware.h"

#include "include/unit_icon_data.h"
#include "include/bmunit.h"
#include "include/bmmap.h"
#include "include/bmtrick.h"
#include "include/chapterdata.h"
#include "include/ctc.h"
#include "include/mu.h"
#include "include/bmudisp.h"
#include "include/bmlib.h"
#include "include/terrains.h"
#include "include/proc.h"
#include "include/rng.h"
#include "include/bm.h"
#include "include/bmlib.h"
#include "include/prepscreen.h"
#include "include/constants/faces.h"
#include "include/face.h"
#include "include/anime.h"

struct FaceBlinkProc {
    /* 00 */ PROC_HEADER;

    /* 2C */ struct FaceProc* pFaceProc;

    /* 30 */ s16 blinkControl;
    /* 32 */ s16 unk_32;
    /* 34 */ s16 unk_34;

    /* 38 */ int unk_38;
    /* 3C */ u16* unk_3c;

    /* 40 */ u16 tileId;
    /* 42 */ u16 palId;
    /* 44 */ u16 faceId;
};


extern struct Anim* sFirstAnim;


struct DeleteFaceProc {
    /* 00 */ PROC_HEADER;

    /* 29 */ u8 pad[0x54-0x29];

    /* 54 */ struct FaceProc* target;
};

struct UnkFaceProc {
    /* 00 */ PROC_HEADER;

    /* 2C */ struct FaceProc* pFaceProc;
    /* 30 */ const struct FaceData* pFaceInfo;
    /* 34 */ int faceId;
};


//! FE8U = 0x08005738
void EndFace(struct FaceProc* proc) {
	if (proc) {
    gFaces[proc->faceSlot] = NULL;
    Proc_End(proc);
	} 

    return;
}

//! FE8U = 0x08005758
void EndFaceById(int slot) {
	if (gFaces[slot]) { 
    EndFace(gFaces[slot]);
	} 
    return;
}

//! FE8U = 0x080057A4
int GetFaceDisplayBits(struct FaceProc* proc) {
	if (proc) return proc->displayBits;
	return 0; 
}

void AnimDelete(struct Anim* anim)
{
	if (anim) { 
    if (anim->pPrev == NULL)
    {
        sFirstAnim = anim->pNext;
        anim->pNext->pPrev = NULL;
    }
    else
    {
        anim->pPrev->pNext = anim->pNext;
        anim->pNext->pPrev = anim->pPrev;
    }

    anim->state = 0;
    anim->pPrev = NULL;
    anim->pNext = NULL;
	} 
}

extern struct ProcCmd CONST_DATA ProcScr_LightRuneAnim[];

void StartLightRuneAnim(ProcPtr parent, int x, int y)
{
	if (parent) { 
    Proc_StartBlocking(ProcScr_LightRuneAnim, parent);
	} 
	else {
		Proc_Start(ProcScr_LightRuneAnim, (ProcPtr)3);
	}

    x = x * 0x10 - gBmSt.camera.x - 0x18;
    y = y * 0x10 - gBmSt.camera.y - 0x28;

    BG_SetPosition(0, -x, -y);
}



