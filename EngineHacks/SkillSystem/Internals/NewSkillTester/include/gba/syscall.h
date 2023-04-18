#ifndef GUARD_GBA_SYSCALL_H
#define GUARD_GBA_SYSCALL_H

#include "types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

void Halt(void);
void Stop(void);

noreturn void SoftReset(void);
void RegisterRamReset(unsigned flags);

void IntrWait(bool waitNew, unsigned interruptFlags);
void VBlankIntrWait(void);

unsigned GetBiosChecksum(void);

int Div(int a, int b);
int Mod(int a, int b);
int DivArm(int b, int a);
int Sqrt(int n);
int ArcTan(int n);
int ArcTan2(int x, int y);

void BitUnPack(const void* src, void* dst, const struct BitUnPackInfo* info);
void LZ77UnComp8bit(const void* src, void* dst);
void LZ77UnComp16bit(const void* src, void* dst);
void HuffUnComp(const void* src, void* dst);
void RLUnComp8bit(const void* src, void* dst);
void RLUnComp16bit(const void* src, void* dst);
void Diff8bitUnFilter8bit(const void* src, void* dst);
void Diff8bitUnFilter16bit(const void* src, void* dst);
void Diff16bitUnFilter(const void* src, void* dst);

void CpuSet(const void* src, void* dst, unsigned config);
void CpuFastSet(const void* src, void* dst, unsigned config);

#ifdef __cplusplus
}
#endif // __cplusplus

#define RESET_EWRAM      0x01
#define RESET_IWRAM      0x02
#define RESET_PALETTE    0x04
#define RESET_VRAM       0x08
#define RESET_OAM        0x10
#define RESET_SIO_REGS   0x20
#define RESET_SOUND_REGS 0x40
#define RESET_REGS       0x80
#define RESET_ALL        0xFF

#define CPU_SET_SRC_FIXED 0x01000000
#define CPU_SET_16BIT     0x00000000
#define CPU_SET_32BIT     0x04000000

#define CPU_FAST_SET_SRC_FIXED 0x01000000

#endif // GUARD_GBA_SYSCALL_H
