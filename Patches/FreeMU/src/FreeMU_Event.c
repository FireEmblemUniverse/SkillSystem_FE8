#include "FreeMU.h"
static bool RunMapDoorEventTemplate(s8, s8);
static bool RunTalkEventTemplate(u8, s8, s8);


void pFMU_RunMiscBasedEvents(struct FMUProc* proc){
	RunMiscBasedEvents(proc->xCur, proc->yCur);
	return;
}
// ORG $271F8 SHORT $46C0 // make units not in the unit map still appear 
// maybe hook around here and check for FMU running 
void TryUnhideSteppedOnUnit(struct FMUProc* proc, int x, int y) { 
	struct Unit* unit; 
	for (int i = 1; i<0xC0; i++) { 
		unit = GetUnit(i); 
		if (!UNIT_IS_VALID(unit)) { 
		continue; }
		if ((unit->xPos != x) || (unit->yPos != y)) {
		continue; }
		if (unit == gActiveUnit) { 
		continue; } 
		if (proc->commandID != 0xFF) { 
		continue; } 
		//asm("mov r11, r11"); 
		//gMapUnit[y][x] = unit->index; 
		
		//RefreshUnitsOnBmMap();
		//SMS_UpdateFromGameData();
		//unit->state &= ~US_HIDDEN; 
		proc->countdown = 10; 
		proc->yield = true; 
		
		//proc->commandID = 0;
		//proc->command[0] = 0xFF; 
		
		proc->updateSMS = true; 

	} 
} 

int pFMU_RunLocBasedAsmcAuto(struct FMUProc* proc){
	//int x = proc->xCur; 
	//int y = proc->yCur; 
	proc->xCur = proc->xTo; 
	proc->yCur = proc->yTo; 
	gActiveUnit->xPos = proc->xCur; 
	gActiveUnit->yPos = proc->yCur; 
	//TryUnhideSteppedOnUnit(proc, x, y); 
	
	
	if( FMU_RunTrapASMC_Auto(proc) )
	{
		return yield;
	}
	if( RunMiscBasedEvents(proc->xCur, proc->yCur) )
	{
		return yield;
	}
	return no_yield;
	
}


bool FMUmisc_RunMapEvents(struct FMUProc* proc){
	s8 x = gActiveUnit->xPos;
	s8 y = gActiveUnit->yPos;
	u8 cLocEventID = GetLocationEventCommandAt(x,y);
	u8 iMapID=gMapTerrain[y][x];
	
	if( (x<0) & (x>gMapSize.x) & (y<0) & (y>gMapSize.y) )
		return 0;
	
	struct LocEventDef* LocEventType = &HookListFMU_LocationBasedEvent[0];
	while( 0 < LocEventType->LocID )
	{
		if( LocEventType->LocID == cLocEventID )
			if( (0==LocEventType->TrapID) |(LocEventType->TrapID==iMapID) )
			{
				RunLocationEvents(x,y);
				return 1;
			}
		LocEventType++;
	}
	
	  if (proc->smsFacing==0)      x--;
	  else if (proc->smsFacing==1) x++;
	  else if (proc->smsFacing==2) y++;
	  else                         y--;

	if(RunMapDoorEventTemplate(x,y)) return 1;
	return 0;
}

static bool RunMapDoorEventTemplate(s8 x, s8 y){
	u8 cLocEventID = GetLocationEventCommandAt(x,y);
	u8 iMapID=gMapTerrain[y][x];
	if( (x<0) & (x>gMapSize.x) & (y<0) & (y>gMapSize.y) )
		return 0;
	
	struct LocEventDef* LocEventType = &HookListFMU_LocationBasedEventDoor[0];
	while( 0 < LocEventType->LocID )
	{
		if( LocEventType->LocID == cLocEventID )
			if( (0==LocEventType->TrapID) |(LocEventType->TrapID==iMapID) )
			{
				RunLocationEvents(x,y);
				return 1;
			}
		LocEventType++;
	}

	return 0;
}

bool FMU_RunTrapASMC(FMUProc* proc){
	struct FMUTrapDef* trap = &HookListFMU_TrapTable_PressA_Auto[0];
	int x = gActiveUnit->xPos;
	int y = gActiveUnit->yPos;
	
	int result = FMU_RunTrap(proc, trap, x, y); 
	if (!result) {
		if (proc->smsFacing==0)      { x--; }
		else if (proc->smsFacing==1) { x++; }
		else if (proc->smsFacing==2) { y++; }
		else                         { y--; }
		trap = &HookListFMU_TrapTable_PressA_Adjacent[0];
		result = FMU_RunTrap(proc, trap, x, y); 
	}
	return result; 
}
	
	
bool FMU_RunTrapASMC_Auto(FMUProc* proc){
	struct FMUTrapDef* trapEff = &HookListFMU_TrapTable_Auto_On[0];
	int x = gActiveUnit->xPos;
	int y = gActiveUnit->yPos;
	
	int result = FMU_RunTrap(proc, trapEff, x, y); 
	if (!result) {
		if (proc->smsFacing==0)      { x--; }
		else if (proc->smsFacing==1) { x++; }
		else if (proc->smsFacing==2) { y++; }
		else                         { y--; }
		trapEff = &HookListFMU_TrapTable_Auto_Adjacent[0];
		result = FMU_RunTrap(proc, trapEff, x, y); 
	}
	return result; 
}
	
bool FMU_RunTrap(FMUProc* proc, struct FMUTrapDef* trapEff, int x, int y) {

	struct Trap* trap = GetTrapAt(x,y); 
	if (trap) { 
		if (trapEff[trap->type].Usab) { 
			if ((trapEff[trap->type].Usab)(proc) != 3) { // returns 3 if false 
				(trapEff[trap->type].Func)(proc);
				return true; 
			}
		}
	}
	return false; 
} 
		
	
	
	/*
	while( 0 < trapEff->trapEffID )
	{
		if(0!=trapEff->Func) { 
			
			int xPos = x; 
			int yPos = y; 
			if (trapEff->adjacencyBool) { 

			} 
		
			if(
			{
				if ((trapEff->Usab)(proc) == 1) { 
					(trapEff->Func)(proc);
					return 1;
				} 
			}
		}
		trapEff++;
	}
	return 0;
}
*/ 




bool FMUmisc_RunTalkEvents(struct FMUProc* proc){
	u8 x = gActiveUnit->xPos;
	u8 y = gActiveUnit->yPos;
	u8 SubjectCharID = proc->FMUnit->pCharacterData->number;
	
	
 if (proc->smsFacing==0)      x--;
  else if (proc->smsFacing==1) x++;
  else if (proc->smsFacing==2) y++;
  else                         y--;
	u8 targetDeployID = gMapUnit[y][x];
	if (targetDeployID) 
		gActionData.targetIndex = targetDeployID; 


  if(RunTalkEventTemplate(SubjectCharID,x,y)) return 1;
	
	return 0;
}

void ChangeTargetFacing(struct Unit* UnitTowards) { 
	int activeX = gActiveUnit->xPos; 
	int activeY = gActiveUnit->yPos; 
	int targetX = UnitTowards->xPos; 
	int targetY = UnitTowards->yPos; 

	int dirX = activeX - targetX; 
	int dirY = activeY - targetY; 
	if (dirX > 0) { // 
	SetUnitFacingAndUpdateGfx(UnitTowards, MU_FACING_RIGHT); }
	if (dirX < 0) { // 
	SetUnitFacingAndUpdateGfx(UnitTowards, MU_FACING_LEFT); }
	if (dirY > 0) { // 
	SetUnitFacingAndUpdateGfx(UnitTowards, MU_FACING_DOWN); }
	if (dirY < 0) { // 
	SetUnitFacingAndUpdateGfx(UnitTowards, MU_FACING_UP); }

} 

static bool RunTalkEventTemplate(u8 SubjectCharID, s8 x, s8 y){
	if( (x<0) & (x>gMapSize.x) & (y<0) & (y>gMapSize.y) )
		return 0;
	if( 0 == gMapUnit[y][x] )
		return 0;
	
	Unit* UnitTowards = GetUnit(gMapUnit[y][x]);
	u8 TargetCharID  = UnitTowards->pCharacterData->number;
	if(CheckForCharacterEvents(SubjectCharID,TargetCharID)){
		ChangeTargetFacing(UnitTowards); 

		if (!GetUnitEquippedWeapon(UnitTowards)) { 
			RunCharacterEvents(SubjectCharID,TargetCharID);
			return 1;
		} // can't talk to someone with a weapon 
		else { 
		//FMU_EnableDR(); 
		struct FMUProc* proc = (struct FMUProc*)ProcFind(FreeMovementControlProc);
		proc->end_after_movement = true; 
		return 1; 
		} 
	}
	return 0;
}
