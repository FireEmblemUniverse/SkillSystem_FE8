#ifndef GBAFE_AP_H
#define GBAFE_AP_H

#include "common.h"
#include "proc.h"

// I used to call those "TCS" in my doc -Stan

typedef struct APHandle APHandle;
typedef struct APHandle AnimHandle;
typedef struct APHandle TCStruct;

struct APHandle {
	/* 00 */ const u16* pDefinition;      // Pointer to Definition Root
	/* 04 */ const u16* pFrameData;       // Pointer to Frame Data Array
	/* 08 */ const u16* pAnimDataStart;   // Pointer to Current Anim Data (Start, where we go back on loop)
	/* 0C */ const u16* pAnimDataCurrent; // Pointer to Current Anim Data (Cursor, where we are now)
	/* 10 */ const u16* pCurrentObjData;  // Pointer to Current Obj Data
	/* 14 */ const u16* pCurrentRotScale; // Pointer to Current Rot/Scale Data
	/* 18 */ s16 frameTimer;              // Cycle Timer
	/* 1A */ u16 frameInterval;           // Cycle Time Step (0x100 is one frame)
	/* 1C */ u16 subframeTimer;           // Sub frame time offset or something
	/* 1E */ u16 objLayer;                // HiObj layer
	/* 20 */ u8  gfxNeedsUpdate;          // bool defining whether gfx needs update
	/* 21 */ u8  rotScaleIndex;           // Rotation/Scale OAM Index
	/* 22 */ u16 tileBase;                // OAM Extra Data (Tile Index Root & OAM2 Stuff)
	/* 24 */ const void* pGraphics;       // Pointer to graphics (if any)
};

extern struct APHandle gApPool[];

struct APHandle* AP_Create(const void *definition, int depth); //! FE8U = (0x0800927C+1)
void AP_Delete(struct APHandle* ap); //! FE8U = (0x080092A4+1)
void AP_Update(struct APHandle* ap, u16 x, u16 y); //! FE8U = (0x080092BC+1)
void AP_SetAnimation(struct APHandle* ap, int index); //! FE8U = (0x08009518+1)
void AP_SetDefinition(struct APHandle* ap, const void* definition); //! FE8U = (0x08009548+1)

struct Proc* APProc_Create(const void* definition, u16 x, u16 y, u16 tileBase, int animIndex, int depth); //! FE8U = (0x08009718+1)
void APProc_SetParameters(struct Proc* apProc, u16 x, u16 y, u16 tileBase); //! FE8U = (0x08009798+1)
void APProc_Delete(struct Proc*); //! FE8U = (0x080097B4+1)
void APProc_DeleteAll(void); //! FE8U = (0x080097C0+1)
int APProc_Exists(void); //! FE8U = (0x080097D1)

#endif // GBAFE_AP_H
