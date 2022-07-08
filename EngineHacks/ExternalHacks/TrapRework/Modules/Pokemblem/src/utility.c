#include "utility.h"

static int sign(int value) { return (value>>31) - (-value>>31); }
static int abs(int value) { return value < 0 ? -value : value; }
static int sqr(int value) { return value * value; }

extern void MuCtr_StartMoveTowards(Unit* unit, int x, int y, int speed); 
extern void CenterCameraOntoPosition(Proc* proc, int x, int y); 
extern int EnsureCameraOntoPosition(Proc* proc, int x, int y); 

int MoveMoveUnitTowards(MoveUnitState* moveunit, int x, int y, int speed) {
	
	x = x << 8; 
	y = y << 8;

	int xSign = sign(x - moveunit->xSubPosition);
	int ySign = sign(y - moveunit->ySubPosition);

	moveunit->xSubPosition += xSign << speed;
	moveunit->ySubPosition += ySign << speed;
	
	EnsureCameraOntoPosition(moveunit, moveunit->xSubPosition>>8, moveunit->ySubPosition>>8); 
	//CenterCameraOntoPosition(moveunit, moveunit->xSubPosition>>8, moveunit->ySubPosition>>8); 
	
	/*
	int x2 = x >> 8; 
	int y2 = y >> 8; 
	x2 += xSign; 
	y2 += ySign; 
	
	MuCtr_StartMoveTowards(moveunit->pUnit, x2, y2, 5);
	*/
	
	//moveunit->pMUConfig->currentCommand = MU_COMMAND_MOVE_UP; // | MU_COMMAND_CAMERA_ON; 
	//moveunit->moveConfig = MU_STATE_MOVEMENT; 
	//MU_EnableAttractCamera(moveunit);
	
	//if ((xDistance < xSign) && (yDistance < ySign)) { return FALSE; } 
	if (!(xSign | ySign)) { 
		MU_End(moveunit); 
		moveunit->pUnit->state = moveunit->pUnit->state & 0xFFFFFFFE; // remove hide bitflag 
		RefreshUnitsOnBmMap();
		SMS_UpdateFromGameData();
		RenderBmMap();
	} 
	return (xSign | ySign);
}
extern int SVC_Sqrt(int); 

// needs testing
int MoveUnitUnitTowards2(MoveUnitProc* moveunit, int x, int y, int speed) {
	int xDistance = (0x100 * x) - moveunit->xSubPosition;
	int yDistance = (0x100 * y) - moveunit->ySubPosition;

	int distance = SVC_Sqrt(sqr(abs(xDistance)) + sqr(abs(yDistance)));
	//int distance = abs(xDistance) + abs(yDistance);


	int factor = Div(speed, distance);

	int xStep = (xDistance * factor) / 0x10;
	int yStep = (yDistance * factor) / 0x10;

	if (abs(xDistance) < abs(xStep) || abs(yDistance) < abs(yStep)) {
		moveunit->xSubPosition = x * 0x100;
		moveunit->ySubPosition = y * 0x100;

		return FALSE; // movement ended (destination reached)
	} else {
		moveunit->xSubPosition += xStep;
		moveunit->ySubPosition += yStep;

		return TRUE; // the adventure continues...
	}
}
