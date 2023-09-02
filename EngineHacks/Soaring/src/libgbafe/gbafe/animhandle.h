#ifndef GBAFE_ANIMHANDLE_H
#define GBAFE_ANIMHANDLE_H

// ap.c

#include <stdint.h>

#include "common.h"
#include "proc.h"

// I call those "TCS" in my doc -Stan

typedef struct _AnimHandle APHandle;
typedef struct _AnimHandle AnimHandle;
typedef struct _AnimHandle TCStruct;

struct _AnimHandle {
	const void* pDefinition;      // 00 | word  | Pointer to Definition "ROMTCS"
	const void* pFrameData;       // 04 | word  | Pointer to Frame Data Ref (from ROMTCS)
	const void* pAnimDataStart;   // 08 | word  | Pointer to Current Anim Data (Start, where you go back on loop)
	const void* pAnimDataCurrent; // 0C | word  | Pointer to Current Anim Data (Cursor)
	const void* pCurrentFrameOAM; // 10 | word  | Pointer to Current Frame/OAM Data
	const void* pCurrentRotScale; // 14 | word  | Pointer to Current Rot/Scale Data
	uint16_t cycleClock;          // 18 | short | Cycle Timer
	uint16_t cycleTimeStep;	      // 1A | short | Cycle Time Step (0x100 is one frame)
	uint16_t cycleOffset;         // 1C | short | Sub frame time offset or something
	uint16_t objectDepth;         // 1E | short | OAM Index?
	uint8_t gfxNeedsUpdate;       // 20 | byte  | bool defining whether gfx needs update
	uint8_t rotScaleIndex;        // 21 | byte  | Rotation/Scale OAM Index
	uint16_t OAMBase;             // 22 | short | OAM Extra Data (Tile Index Root & OAM2 Stuff)
	const void *pGraphics;        // 24 | word  | Gfx Pointer
};

extern APHandle gAPArray[];

#pragma long_calls

APHandle* AP_Create(const void *definition, int depth);           //! FE8U = (0x0800927C+1)
void      AP_Delete(APHandle* ap);                                //! FE8U = (0x080092A4+1)
void      AP_Update(APHandle* ap, uint16_t x, uint16_t y);        //! FE8U = (0x080092BC+1)
void      AP_SwitchAnimation(APHandle* ap, int index);            //! FE8U = (0x08009518+1)
void      AP_SetDefinition(APHandle* ap, const void* definition); //! FE8U = (0x08009548+1)

ProcState* APProc_Create(const void* definition, uint16_t x, uint16_t y, uint16_t tileBase, int animIndex, int depth); //! FE8U = (0x08009718+1)
void       APProc_SetParameters(ProcState* apProc, uint16_t x, uint16_t y, uint16_t tileBase); //! FE8U = (0x08009798+1)
void       APProc_Delete(ProcState*); //! FE8U = (0x080097B4+1)
void       APProc_DeleteAll();        //! FE8U = (0x080097C0+1)

#pragma long_calls_off

#endif // GBAFE_ANIMHANDLE_H
