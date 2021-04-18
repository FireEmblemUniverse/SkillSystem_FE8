#ifndef GBAFE_VRAMTRANSFER_H
#define GBAFE_VRAMTRANSFER_H

#include "common.h"

typedef struct ObjData ObjData;

struct ObjData {
	u16 count;
	u16 data[]; // NOTE: C99+ only
};

// "Standard" single-object datas
extern const struct ObjData gObj_8x8;
extern const struct ObjData gObj_16x16;
extern const struct ObjData gObj_32x32;
extern const struct ObjData gObj_16x32;

void ClearTileRegistry(void); //! FE8U = 0x8001FE1
void RegisterTileGraphics(const void* source, void* target, unsigned size); //! FE8U = 0x8002015
void RegisterFillTile(u32 value, void* target, unsigned size); //! FE8U = 0x8002055
void SyncRegisteredTiles(void); //! FE8U = 0x8002089

void InitOAMSplice(int loOAMSize); //! FE8U = 0x80020FD

void SyncHiOAM(void); //! FE8U = 0x8002139
void SyncLoOAM(void); //! FE8U = 0x800217D

void WriteOAMRotScaleData(unsigned index, int pa, int pb, int pc, int pd); //! FE8U = 0x80021B1

unsigned GetLoOAMSize(void); //! FE8U = 0x800224D

// ARM
void PushToHiOAM(u16 xBase, u16 yBase, const struct ObjData* data, u16 tileBase); //! FE8U = 0x8002BB9
void PushToLoOAM(u16 xBase, u16 yBase, const struct ObjData* data, u16 tileBase); //! FE8U = 0x8002BCD

void ClearOAMBuffer(u16* buffer, unsigned size); //! FE8U = 0x80D7499

// decomp compat
#define CallARM_PushToSecondaryOAM PushToHiOAM
#define CallARM_PushToPrimaryOAM PushToLoOAM

#endif // GBAFE_VRAMTRANSFER_H
