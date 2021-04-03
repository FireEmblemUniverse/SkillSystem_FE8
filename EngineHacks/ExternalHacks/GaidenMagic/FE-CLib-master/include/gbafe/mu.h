#ifndef GBAFE_MU_H
#define GBAFE_MU_H

// mu.c

#include <stdint.h>

#include "proc.h"
#include "unit.h"
#include "ap.h"

typedef struct MUProc MoveUnitProc;
typedef struct MUProc MoveUnitState;

typedef struct MUConfig MoveUnitExtraData;

enum {
	// MU Magic Constants

	// Maximum simultaneous MU count
	MU_MAX_COUNT = 4,

	// Maximum move command count
	MU_COMMAND_MAX_COUNT = 0x40,

	// Maximum size of uncompressed MU sprite sheet
	MU_GFX_MAX_SIZE = 0x2200,

	// Default base obj tile index for storing sprites in VRAM
	MU_BASE_OBJ_TILE = 0x380,

	// obj palette id used for MU fade effects
	MU_FADE_OBJ_PAL = 5,

	// Number of bits used to keep track of subpixels
	MU_SUBPIXEL_PRECISION = 4,
};

enum {
	// Possible MU States

	MU_STATE_NOSTATE,
	MU_STATE_NONACTIVE,
	MU_STATE_MOVEMENT,
	MU_STATE_WAITING,
	MU_STATE_UNK4,
	MU_STATE_BUMPING,
	MU_STATE_UI_DISPLAY,
	MU_STATE_DEATHFADE,
};

enum {
	// MU command identifiers

	MU_COMMAND_END = -1, // end

	MU_COMMAND_MOVE_BASE,

	MU_COMMAND_MOVE_LEFT  = MU_COMMAND_MOVE_BASE + 0,
	MU_COMMAND_MOVE_RIGHT = MU_COMMAND_MOVE_BASE + 1,
	MU_COMMAND_MOVE_DOWN  = MU_COMMAND_MOVE_BASE + 2,
	MU_COMMAND_MOVE_UP    = MU_COMMAND_MOVE_BASE + 3,

	MU_COMMAND_HALT,

	MU_COMMAND_FACE_BASE,

	MU_COMMAND_FACE_LEFT  = MU_COMMAND_FACE_BASE + 0,
	MU_COMMAND_FACE_RIGHT = MU_COMMAND_FACE_BASE + 1,
	MU_COMMAND_FACE_DOWN  = MU_COMMAND_FACE_BASE + 2,
	MU_COMMAND_FACE_UP    = MU_COMMAND_FACE_BASE + 3,

	MU_COMMAND_WAIT,
	MU_COMMAND_BUMP,
	MU_COMMAND_UNK11,
	MU_COMMAND_SET_SPEED,

	MU_COMMAND_CAMERA_ON,
	MU_COMMAND_CAMERA_OFF,
};

enum {
	// MU facing identifiers

	MU_FACING_LEFT,
	MU_FACING_RIGHT,
	MU_FACING_DOWN,
	MU_FACING_UP,

	MU_FACING_SELECTED,

	// TODO: Which is MU_FACING_DANCING?

	MU_FACING_UNK11    = 11, // The facing id at start
	MU_FACING_STANDING = 15,
};

enum {
	// MU flash identifiers

	MU_FLASH_0,
	MU_FLASH_1,
	MU_FLASH_2,
	MU_FLASH_3,
	MU_FLASH_4,
	MU_FLASH_5,
};

struct MUConfig;

struct MUProc {
	PROC_HEADER;

	/* 2C */ struct Unit* pUnit;
	/* 30 */ struct APHandle* pAPHandle;
	/* 34 */ struct MUConfig* pMUConfig;
	/* 38 */ void* pGfxVRAM;

	/* 3C */ u8 muIndex;
	/* 3D */ u8 _u3D;
	/* 3E */ u8 boolAttractCamera;
	/* 3F */ u8 stateId;
	/* 40 */ u8 boolIsHidden;
	/* 41 */ u8 displayedClassId;
	/* 42 */ s8 facingId;
	/* 43 */ u8 stepSoundTimer;
	/* 44 */ u8 boolForceMaxSpeed;
	/* 46 */ u16 objPriorityBits;
	/* 48 */ u16 moveTimer;
	/* 4A */ short moveConfig;

	// Coordinates are in 16th of pixel
	/* 4C */ short xSubPosition;
	/* 4E */ short ySubPosition;
	/* 50 */ short xSubOffset;
	/* 52 */ short ySubOffset;
};

struct MUConfig {
	/* 00 */ u8  muIndex;
	/* 01 */ u8  paletteIndex;
	/* 02 */ u16 objTileIndex;
	/* 04 */ u8  currentCommand;
	/* 05 */ s8  commands[MU_COMMAND_MAX_COUNT];
	/* 45 */ // 3 byte padding
	/* 48 */ struct MUProc* pMUProc;
};

void MU_Init(void); //! FE8U = (0x0807840C+1)
struct MUProc* MU_CreateExt(struct Unit* unit, int mms, int palId); //! FE8U = (0x08078428+1)
struct MUProc* MU_Create(struct Unit* unit); //! FE8U = (0x08078464+1)
void MU_EnableAttractCamera(struct MUProc*); //! FE8U = (0x080784E4+1)
void MU_DisableAttractCamera(struct MUProc*); //! FE8U = (0x080784EC+1)
struct MUProc* MU_CreateForUI(struct Unit* unit); //! FE8U = (0x080784F4+1)
struct MUProc* MU_CreateInternal(int x, int y, int mms, int objBase, int palId); //! FE8U = (0x08078540+1)
void MU_SetFacing(struct MUProc* moveunit, int direction); //! FE8U = (0x08078694+1)
void MU_SetDefaultFacing(struct MUProc* moveunit); //! FE8U = (0x080786BC+1)
void MU_SetDefaultFacing_Auto(); //! FE8U = (0x080786E8+1)
void MU_StartMoveScript_Auto(u8* moveManual); //! FE8U = (0x08078700+1)
int MU_Exists(); //! FE8U = (0x08078720+1)
int MU_IsAnyActive(); //! FE8U = (0x08078738+1)
void MU_StartMoveScript(struct MUProc* moveunit, u8* moveManual); //! FE8U = (0x08078790+1)
void MU_EndAll(); //! FE8U = (0x080790A4+1)
void MU_End(struct MUProc* moveunit); //! FE8U = (0x080790B4+1)
void MU_StartActionAnim(struct MUProc* moveunit); //! FE8U = 0x80798B1
void MU_Hide(struct MUProc* moveunit); //! FE8U = 0x80797D5
void MU_Show(struct MUProc* moveunit); //! FE8U = 0x80797DD
void MU_SetDisplayPosition(struct MUProc* moveunit, int x, int y); //! FE8U = (0x080797E4+1)

#endif // GBAFE_MU_H
