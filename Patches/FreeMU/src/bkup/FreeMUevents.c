#include "FreeMU.h"
static bool RunMapDoorEventTemplate(s8, s8);
static bool RunTalkEventTemplate(u8, s8, s8);

void pFMU_RunMiscBasedEvents(struct FMUProc* proc){
	RunMiscBasedEvents(gActiveUnit->xPos, gActiveUnit->yPos);
	return;
}


void FMUmisc_RunMapEvents(struct FMUProc* proc){
	u8 x = gActiveUnit->xPos;
	u8 y = gActiveUnit->yPos;
	u8 cLocEventID = GetLocationEventCommandAt(x,y);
	u8 iMapID=gMapTerrain[y][x];
	
	if( (x<0) & (x>gMapSize.x) & (y<0) & (y>gMapSize.y) )
		return;
	
	if( 0x14==cLocEventID )
		//chest
		if(0x21==iMapID)
			RunLocationEvents(x,y);
	
	if(0x10==cLocEventID)
		//Visit
		if( (0x3==iMapID)|(0x37==iMapID)|(0x38==iMapID) )
			RunLocationEvents(x,y);
	
	if(0x11==cLocEventID)
		//Size
		RunLocationEvents(x,y);
		
	if( (0x16==cLocEventID)|(0x17==cLocEventID)|(0x18==cLocEventID) )
		// Armory & Vendor & Scecret
		RunLocationEvents(x,y);	
	
	if(RunMapDoorEventTemplate(x-1,y)) return;
	else if(RunMapDoorEventTemplate(x+1,y)) return;
	else if(RunMapDoorEventTemplate(x,y-1)) return;
	RunMapDoorEventTemplate(x,y+1);
	return;
}

static bool RunMapDoorEventTemplate(s8 x, s8 y){
	u8 cLocEventID = GetLocationEventCommandAt(x,y);
	u8 iMapID=gMapTerrain[y][x];
	if( (x<0) & (x>gMapSize.x) & (y<0) & (y>gMapSize.y) )
		return 0;
	if(0x12==cLocEventID)
		//Door
		if(0x1E==iMapID){
			RunLocationEvents(x,y);
			return 1;
		}
	return 0;
}











void FMUmisc_RunTalkEvents(struct FMUProc* proc){
	u8 x = gActiveUnit->xPos;
	u8 y = gActiveUnit->yPos;
	u8 SubjectCharID = proc->FMUnit->pCharacterData->number;
	
	if(RunTalkEventTemplate(SubjectCharID,x-1,y)) return;
	else if(RunTalkEventTemplate(SubjectCharID,x+1,y)) return;
	else if(RunTalkEventTemplate(SubjectCharID,x,y-1)) return;
	RunTalkEventTemplate(SubjectCharID,x,y+1);
	
	return;
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
