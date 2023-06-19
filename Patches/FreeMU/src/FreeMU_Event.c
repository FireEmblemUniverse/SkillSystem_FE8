#include "FreeMU.h"
static bool RunMapDoorEventTemplate(s8, s8);
static bool RunTalkEventTemplate(u8, s8, s8);


void pFMU_RunMiscBasedEvents(struct FMUProc* proc){
	RunMiscBasedEvents(proc->xCur, proc->yCur);
	return;
}

int pFMU_RunLocBasedAsmcAuto(struct FMUProc* proc){
	proc->xCur = proc->xTo; 
	proc->yCur = proc->yTo; 
	gActiveUnit->xPos = proc->xCur; 
	gActiveUnit->yPos = proc->yCur; 
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
	struct FMUTrapDef* trap = &HookListFMU_TrapList_OnPressA[0];
	s8 x = gActiveUnit->xPos;
	s8 y = gActiveUnit->yPos;
	
	while( 0 < trap->TrapID )
	{
		if(0!=trap->Func) { 
			
			int xPos = x; 
			int yPos = y; 
			if (trap->adjacencyBool) { 
			  if (proc->smsFacing==0)      xPos--;
			  else if (proc->smsFacing==1) xPos++;
			  else if (proc->smsFacing==2) yPos++;
			  else                         yPos--;
			} 
		
			if(GetTrapAt(xPos,yPos)->type==trap->TrapID) 
			{
				(trap->Func)(proc);
				return 1;
			}
		}
		trap++;
	}
	return 0;
}


bool FMU_RunTrapASMC_Auto(FMUProc* proc){
	struct FMUTrapDef* trap = &HookListFMU_TrapList_Auto[0];
	s8 x = gActiveUnit->xPos;
	s8 y = gActiveUnit->yPos;
	
	while( 0 < trap->TrapID )
	{
		if(0!=trap->Func)
			if(GetTrapAt(x,y)->type==trap->TrapID) 
			{
				(trap->Func)(proc);
				return 1;
			}
		trap++;
	}
	return 0;
}






bool FMUmisc_RunTalkEvents(struct FMUProc* proc){
	u8 x = gActiveUnit->xPos;
	u8 y = gActiveUnit->yPos;
	u8 SubjectCharID = proc->FMUnit->pCharacterData->number;
	
 if (proc->smsFacing==0)      x--;
  else if (proc->smsFacing==1) x++;
  else if (proc->smsFacing==2) y++;
  else                         y--;

  if(RunTalkEventTemplate(SubjectCharID,x,y)) return 1;
	
	return 0;
}
static bool RunTalkEventTemplate(u8 SubjectCharID, s8 x, s8 y){
	if( (x<0) & (x>gMapSize.x) & (y<0) & (y>gMapSize.y) )
		return 0;
	if( 0 == gMapUnit[y][x] )
		return 0;
	
	Unit* UnitTowards = GetUnit(gMapUnit[y][x]);
	u8 TargetCharID  = UnitTowards->pCharacterData->number;
	if(CheckForCharacterEvents(SubjectCharID,TargetCharID)){
		RunCharacterEvents(SubjectCharID,TargetCharID);
		return 1;
	}
	return 0;
}
