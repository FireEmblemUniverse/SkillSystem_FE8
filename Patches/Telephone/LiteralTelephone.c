#include "LiteralTelephone.h"

//we're going to hook one of the beginning-of-phase functions for this
//and if player phase and random check we do our thing
//which is start a proc that's blocking the main game logic one
//that subsequently calls an event,
//in which we do pokemon GSC phonecall gfx using ASMCs

void LiteralTelephone(struct Proc* parentProc) {
	
	//if not player phase, end
	if (gChapterData.currentPhase != UA_BLUE) return;
	
	//externalized % chance of happening
	if (NextRN_100() > (TelephoneChance-1)) return;
	
	//call an event
	CallMapEventEngine(&TelephoneEvent, EV_RUN_CUTSCENE);
	
}

void DrawCallGfx1(struct Proc* parentProc) {
	
	memcpy(VRAM+0x2000,&callGfx1,0x1400);
	CopyToPaletteBuffer(&callPal, 0, 32);
	
	for (int i=0; i < 0x400; i++) {
		
		gBg0MapBuffer[i] = 0;
	
	}
	
	for (int i=0; i < 20; i++) {
	
		gBg0MapBuffer[0x20 + i] = (0x100 + i);
		gBg0MapBuffer[0x40 + i] = (0x114 + i);
		gBg0MapBuffer[0x60 + i] = (0x128 + i);		
		gBg0MapBuffer[0x80 + i] = (0x13C + i);

	}
	
//	gLCDIOBuffer.dispControl.enableBg0 = 1;
	EnableBgSyncByIndex(0);
}

void DrawCallGfx2(struct Proc* parentProc) {
	
	memcpy(VRAM+0x2000,&callGfx2,0x1400);
	CopyToPaletteBuffer(&callPal, 0, 32);
	
	for (int i=0; i < 0x400; i++) {
		
		gBg0MapBuffer[i] = 0;
	
	}
	
	for (int i=0; i < 20; i++) {
	
		gBg0MapBuffer[0x20 + i] = (0x100 + i);
		gBg0MapBuffer[0x40 + i] = (0x114 + i);
		gBg0MapBuffer[0x60 + i] = (0x128 + i);		
		gBg0MapBuffer[0x80 + i] = (0x13C + i);

	}
	
//	gLCDIOBuffer.dispControl.enableBg0 = 1;
	EnableBgSyncByIndex(0);
}
