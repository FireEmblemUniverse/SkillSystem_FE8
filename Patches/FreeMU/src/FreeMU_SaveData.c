#include "FreeMU.h"

void MsuSave_FMUbit(void* dest, unsigned size){
	WriteAndVerifySramFast( (const u8*)FreeMoveFlag, dest, size);
	return;
}


void MsuLoad_FMUbit(const void* src, unsigned size){
	(*ReadSramFast)(src, FreeMoveFlag, size);
	return;
}
