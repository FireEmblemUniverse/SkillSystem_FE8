#include "gbafe.h"
void DebugMap_ASMC(Proc* proc);
// SET_DATA MyMapBuffer, 0x203A000 in definitions.s 
extern const u8 DebugMapLabel[];
extern u8 MyMapBuffer[];


void DebugMap_ASMC(Proc* proc) // ASMC 
{
	//gEventSlot[0xC] = 0x100; // Default unit id as 0x100 / no unit was selected 
	asm("mov r11, r11");
	memcpy(MyMapBuffer, DebugMapLabel, 660); // dst, src, size 
	//memcpy(gGenericBuffer, DebugMapLabel, 660); // dst, src, size 
	asm("mov r11, r11");
}





