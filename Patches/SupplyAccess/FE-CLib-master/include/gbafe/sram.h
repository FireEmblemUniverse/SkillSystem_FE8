#ifndef GBAFE_SRAM_H
#define GBAFE_SRAM_H

void SramFastFuncInit(void);
void WriteSramFast(const void* src, void* dest, unsigned size);
extern void (*ReadSramFast)(const void* src, void* dest, unsigned size);
extern unsigned (*gpVerifySramFast)(const void* src, void* dest, unsigned size);
unsigned WriteAndVerifySramFast(const void* src, void* dest, unsigned size);

#endif // GBAFE_SRAM_H
