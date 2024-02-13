
#include "gbafe.h"




extern struct Anim* sFirstAnim;

extern struct MsgBuffer sMsgString;


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

char * StrInsertTact(void)
{
    u8 * r5 = sMsgString.buffer4;
    u8 * r4 = sMsgString.buffer5;
    u8 r1;
    u32 r0;

    CopyString(r5, sMsgString.buffer1);

    while ((r0 = *r5))
    {
        r1 = r0;
        while (0) ;
        if (r1 < 0x20)
        {
            *r4 = r0;
            ++r5;
            ++r4;
        }
        else if (r1 != 0x80)
        {
            *r4 = r0;
            ++r5;
            ++r4;
        }
        else
        {
            /* "\xxx\x80" */
            r5++;
            if (*r5 != 0x20)
            {
                *r4++ = r1;
				if (*r5 == 0x0) break; // added for UTF8 compatibility 
                *r4++ = *r5++;
				
            }
            else
            {
                /* [Tact]: "\x20\x80" */
                CopyString(r4, GetTacticianName());
                while (*r4 != 0)
                    r4++;
                r5++;
            }
        }
    }
    *r4 = 0;
    return sMsgString.buffer5;
}

