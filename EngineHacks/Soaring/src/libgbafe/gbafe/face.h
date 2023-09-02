#ifndef GBAFE_FACE_H
#define GBAFE_FACE_H

#include "proc.h"
#include "hiobj.h"

typedef struct PortraitData PortraitData;
typedef struct FaceProc FaceProc;
typedef struct FaceGfxDefinition FaceGfxDefinition;

struct PortraitData
{
	/* 00 */ const void* pPortraitGraphics;
	/* 04 */ const void* pMiniPortraitGraphics;
	/* 08 */ const u16* pPortraitPalette;
	/* 0C */ const void* unk0C;
	/* 10 */ const void* unk10;
	/* 14 */ const void* unk14;
	/* 18 */ u8 blinkBehaviorKind;
	/* More */
};

struct FaceProc
{
	/* 00 */ PROC_HEADER;

	/* 2C */ const PortraitData* pPortraitData;
	/* 30 */ u32 displayBits;
	/* 34 */ short xPosition;
	/* 36 */ short yPosition;
	/* 38 */ const ObjData* pObjData;
	/* 3C */ u16 tileData;
	/* 3E */ u16 portraitIndex;
	/* 40 */ u8 faceSlotIndex;
	/* 41 */ u8 objectDepth;

	/* 44 */ struct Proc* _pu44Proc;
	/* 48 */ struct Proc* pEyeWinkProc;
};

struct FaceBlinkProc
{
	/* 00 */ PROC_HEADER;

	/* 2C */ u32 unk2C;
	/* 30 */ u16 blinkControl;
	/* 32 */ u16 unk32;
	/* 34 */ u32 blinkInnerClock;
	/* 38 */ u32 blinkIntervalClock;
	/* 3C */ u16* output;
	/* 40 */ u16 tileId;
	/* 42 */ u16 paletteId;
	/* 44 */ u16 portraitId;
};

struct FaceGfxDefinition
{
	const void* pTileRoot;
	u16 paletteIndex;
};

const PortraitData* GetPortraitData(int portraitId); //! FE8U = 0x8005515
void Face_Init(void); //! FE8U = 0x8005529
void SetFaceGfxConfig(const FaceGfxDefinition[4]); //! FE8U = 0x8005545
struct FaceProc* StartFace(int faceId, int portraitId, int x, int y, int idk); //! FE8U = 0x800563D
void EndFace(struct FaceProc*); //! FE8U = 0x8005739
void EndFaceById(int index); //! FE8U = 0x8005759
int ShouldPortraitBeSmol(int portraitId); //! FE8U = 0x8005C25

#endif // GBAFE_FACE_H
