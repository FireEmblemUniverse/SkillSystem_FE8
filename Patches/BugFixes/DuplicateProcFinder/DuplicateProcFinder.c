#include "include/global.h"
#include "include/hardware.h"

#include "include/proc.h"
// displayed range includes non existent 1-2 range moves for players ? ? 
#define MAX_PROC_COUNT 64
extern struct Proc sProcArray[MAX_PROC_COUNT]; 

struct ProcCmd* Proc_FindDuplicate(void)
{
    int i; int c;
    struct Proc* proc = &sProcArray[MAX_PROC_COUNT];
	int music_dupes_amount = 0; 

    for (i = MAX_PROC_COUNT; i > 0; i--)
    {
		proc = &sProcArray[i];
		if (!proc->proc_script) { continue; } 
		if ((int)proc->proc_script == 0x89A2C48) { continue; } // gProcScr_MoveUnit (only immediately after being knocked back) 
		if ((int)proc->proc_script == 0x859168C) { continue; } // ProcScr_ApProc - multiple are ran when leveling up 
		if ((int)proc->proc_script == 0x8758A30) { continue; } // ProcScr_ekrsubAnimeEmulator - multiple are ran when promoting 
		
		
		if ((int)proc->proc_script == 0x8587970) { // sMusicProc2Script - duplicates are killed when selecting a unit 
			music_dupes_amount++; 
			if (music_dupes_amount < 4) { 
				continue; 
			} 
		} 
	
	
		for (c = i - 1; c >= 0; c--) { 
			if (proc->proc_script == sProcArray[c].proc_script) { 
			asm("mov r11, r11"); 
			return proc->proc_script; }
		}
    }

    return NULL;
}


