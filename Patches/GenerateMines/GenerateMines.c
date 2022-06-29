#include "gbafe.h"

extern u8 FREQUENCY_OF_MINES; 
extern struct Vec2u gMapSize; 
extern struct Trap gTrapArray[];
extern MapData gMapHidden;
extern const u8 DefaultMovementCost[]; 
extern struct Unit* GetUnitStructFromEventParameter(int ID); 

void ClearMines(void) {
	u8 trapType = TRAP_MINE; //TRAP_MINE; 
	for (u8 trapEntry = 0; (trapEntry < 50); trapEntry++) {
		if (gTrapArray[trapEntry].type == trapType) {
			u8 x = gTrapArray[trapEntry].xPosition; 
			u8 y = gTrapArray[trapEntry].yPosition; 
			
			gMapHidden[y][x] = gMapHidden[y][x] & (!HIDDEN_BIT_TRAP); // remove traps from gMapHidden  
			gTrapArray[trapEntry].xPosition = 0; 
			gTrapArray[trapEntry].yPosition = 0; 
			gTrapArray[trapEntry].type = 0; 
			for (u8 i = 0; i<5; i++) { 
				gTrapArray[trapEntry].data[i] = 0; // zero out the rest of the data 
			}
		}
	}
} 

void RandomlyPlaceMines(void) {
	//asm("mov r11, r11");
	u8 freq = FREQUENCY_OF_MINES; 
	u8 trapType = TRAP_MINE; //TRAP_MINE; 
	u8 maxXSize = gMapSize.x; 
	u8 maxYSize = gMapSize.y; 
	struct Unit* unit = GetUnitStructFromEventParameter(0); // party leader for their coords as a valid coordinate 
	
	memcpy(gGenericBuffer, &gMapMovement[0][0], ((maxYSize-1)*(maxXSize-1))); // dst, src, size 
	//memset(gGenericBuffer, 0, 1600);
	MapMovementFillMovementFromPosition(unit->xPos, unit->yPos, &DefaultMovementCost[0]);
	
	memset(&gMapHidden[0][0], 0, ((maxYSize-1)*(maxXSize-1)));
	// no more than 30 mines, assuming there are 30 available traps 
	u8 maxMines = (((maxXSize*maxYSize*freq)/100) < 30 ? ((maxXSize*maxYSize*freq)/100) : 30); 
	u8 count = 0; 
	for (u8 trapEntry = 0; ((trapEntry < 50) && (count<=maxMines)); trapEntry++) {
		//struct Trap t[] = gTrapArray[trapEntry];
		if (((gTrapArray[trapEntry].xPosition == 0) && (gTrapArray[trapEntry].yPosition == 0) && (gTrapArray[trapEntry].type == 0)) || (gTrapArray[trapEntry].type == trapType)) { // only overwrite if the first 3 bytes are 00 already 
			count++; 
			for (u8 attempts = 0; attempts < 5; attempts++) { 
				u8 x = NextRN_N(maxXSize);
				u8 y = NextRN_N(maxYSize); 
				//asm("mov r11, r11"); 
				u8 traversable = gMapMovement[y][x]; 
				if (traversable != 0xFF) { 
					attempts = 10; 
					gTrapArray[trapEntry].xPosition = x; 
					gTrapArray[trapEntry].yPosition = y; 
					//gMapHidden[y][x] = gMapHidden[y][x] | HIDDEN_BIT_TRAP; 
					gTrapArray[trapEntry].type = trapType; 
					for (u8 i = 0; i<5; i++) { 
						gTrapArray[trapEntry].data[i] = 0; // zero out the rest of the data 
					}
				} 
			} 
		} 
	for (u8 t = 0; t < 49; t++) { // ensure there are no gaps 
		if (gTrapArray[t].type == 0) { 
			memcpy(&gTrapArray[t], &gTrapArray[t+1], 8);
		} 
	}
// 202FE10 as 02 blocking me at 12x 12y with max 23x 26y 
// 202fccc as 0y0x 
		
	}
	memcpy(&gMapMovement[0][0], gGenericBuffer, ((maxYSize-1)*(maxXSize-1))); // dst, src, size 
	//asm("mov r11, r11");
	RefreshMinesOnBmMap();

} 
