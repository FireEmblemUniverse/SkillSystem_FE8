#ifndef GBAFE_MOVEUNIT_H
#define GBAFE_MOVEUNIT_H

// mu.c

#include <stdint.h>

#include "proc.h"
#include "unit.h"
#include "animhandle.h"

typedef struct _MoveUnitProc MoveUnitProc;
typedef struct _MoveUnitProc MoveUnitState;

typedef struct _MoveUnitExtraData MoveUnitExtraData;

struct _MoveUnitExtraData {
	uint8_t index;
	
	uint8_t  objPaletteIndex;
	uint16_t objTileIndex;
	
	uint8_t commandCount;
	uint8_t commands[63];
	
	void* _u;
	MoveUnitState* pMoveunit;
};

struct _MoveUnitProc {
	ProcState header;
	
	// should be padded to 0x2C
	
	Unit* pUnit;
	AnimHandle* pAnimHandle;
	MoveUnitExtraData* pExtraData;
	void* pVRAM;
	
	uint8_t spriteFrameIndex;
	uint8_t _3D;
	uint8_t cameraFollow;
	uint8_t state;
	uint8_t _40;                 // 40 | byte  | Related to Movement Speed? (0 initially) (80797D4 sets this to 1) (80797DC sets this to 0)
	uint8_t classIndex;          // 41 | byte  | Class Index / Map Sprite Entry (The fact that it is used as class index too annoys me)
	uint8_t currentAnimIndex;    // 42 | byte  | Current Direction byte? (0xB initially) (Stored in routine at 08078694)
	uint8_t _43;                 // 43 | byte  | Something? (Initialized at 0xFE/-2 if another MOVEUNIT instance exists, 0 otherwise. Incremented in routine at 8078D6C)
	uint8_t _44;                 // 44 | byte  | Related to Movement Speed? (0 initially) (8079B10 sets this to 1)
	// uint8_t _45;              // should be padded to 0x46
	uint16_t objectPriorityBits; // 46 | short | OAM priority mask (0x800 initially)
	uint16_t _48;                // 48 | short | When Moving, Incremented by Movement Speed, added to positions and then finally cleared. State 3 (3F = 3) Decrements it and sets State to 2 when reaches 0
	uint16_t _4A;                // 4A | short | If bit 7 is set, it will not play any sound/create any 6C_89A2938 while moving the unit
	
	int16_t xPosition;           // 4C | short | x*256
	int16_t yPosition;           // 4E | short | y*256
	int16_t xOffset;             // 50 | short | added to x? (0 initially)
	int16_t yOffset;             // 52 | short | added to y? (0 initially)
	
	ProcState* pBlendTimerProc;  // 54 | word  | blend timer thing 6C pointer
};

#pragma long_calls

void ResetAllMoveUnitExtraData(void);                                          //! FE8U = (0x0807840C+1)
MoveUnitState* StartMoveUnitForUnitExt(Unit* unit, int mms, int palId);        //! FE8U = (0x08078428+1)
MoveUnitState* StartMoveUnitForUnit(Unit* unit);                               //! FE8U = (0x08078464+1)
void EnableMoveUnitCameraFollow(MoveUnitState*);                               //! FE8U = (0x080784E4+1)
void DisableMoveUnitCameraFollow(MoveUnitState*);                              //! FE8U = (0x080784EC+1)
MoveUnitState* StartMoveUnitForUI(Unit* unit);                                 //! FE8U = (0x080784F4+1)
MoveUnitState* StartMoveUnit(int x, int y, int mms, int objBase, int palId);   //! FE8U = (0x08078540+1)
void SetMoveUnitDirection(MoveUnitState* moveunit, int direction);             //! FE8U = (0x08078694+1)
void ResetMoveUnitDirection(MoveUnitState* moveunit);                          //! FE8U = (0x080786BC+1)
void ResetMoveUnitDirection_Unique();                                          //! FE8U = (0x080786E8+1)
void SetMoveUnitMoveManual_Unique(uint8_t* moveManual);                        //! FE8U = (0x08078700+1)
int DoesMoveUnitExist();                                                       //! FE8U = (0x08078720+1)
int DoesMovingMoveUnitExist();                                                 //! FE8U = (0x08078738+1)
void SetMoveUnitMoveManual(MoveUnitState* moveunit, uint8_t* moveManual);      //! FE8U = (0x08078790+1)
void EndAllMoveUnits();                                                        //! FE8U = (0x080790A4+1)
void EndMoveUnit(MoveUnitState* moveunit);                                     //! FE8U = (0x080790B4+1)
void SetMoveUnitDisplayPosition(MoveUnitState* moveunit, int x, int y);        //! FE8U = (0x080797E4+1)

#pragma long_calls_off

#endif // GBAFE_MOVEUNIT_H
