#include "Dismount.h"

Unit* GetUnitStructFromEventParameter(unsigned eventSlot);
extern u8 MountDismountAllTable[];

void DismountRoutine(Proc* procState){
	Unit* unit = gActiveUnit;
	UnitChangeClass(unit, GetDismountedClass(unit));
	gActionData.unitActionType = UNIT_ACTION_TAKE;
	ProcGoto(procState, 1);
}

void MountRoutine(Proc* procState){
	Unit* unit = gActiveUnit;
	UnitChangeClass(unit, GetMountedClass(unit));
	gActionData.unitActionType = UNIT_ACTION_TAKE;
	ProcGoto(procState, 1);
}

int DismountUsability(){
	Unit* unit = gActiveUnit;
	if (unit->state & US_CANTOING){
	return USABILITY_FALSE;
	}
	if (GetDismountedClass(unit) && GetDismountedClass(unit)->pMovCostTable[0][gMapTerrain[unit->yPos][unit->xPos]] > 0){
		return USABILITY_TRUE;
	}
	return USABILITY_FALSE;
}

int MountUsability(){
	Unit* unit = gActiveUnit;
	if (unit->state & US_CANTOING){
	return USABILITY_FALSE;
	}
	if (GetMountedClass(unit) && GetMountedClass(unit)->pMovCostTable[0][gMapTerrain[unit->yPos][unit->xPos]] > 0){
		return USABILITY_TRUE;
	}
	return USABILITY_FALSE;
}

const ClassData* GetDismountedClass(Unit* unit){
	int mountedNumber = unit->pClassData->number;
	int cnt = 0;

	while(true){
		if (MountedClassTable[cnt].mountedNumber == mountedNumber){
			return GetClassData(MountedClassTable[cnt].dismountedNumber);
		}
		else if (MountedClassTable[cnt].mountedNumber == 0){
			return 0;
		}
		cnt++;
	}
}

const ClassData* GetMountedClass(Unit* unit){
	int dismountedNumber = unit->pClassData->number;
	int cnt = 0;

	while(true){
		if (MountedClassTable[cnt].dismountedNumber == dismountedNumber){
			return GetClassData(MountedClassTable[cnt].mountedNumber);
		}
		else if (MountedClassTable[cnt].mountedNumber == 0){
			return 0;
		}
		cnt++;
	}
}

void UnitChangeClass(Unit* unit, const ClassData* newClass){
	//const ClassData* oldClass = unit->pClassData;
	
	/*unit->maxHP += (newClass->baseHP - oldClass->baseHP);
	unit->curHP += (newClass->baseHP - oldClass->baseHP);
	unit->pow += (newClass->basePow - oldClass->basePow);
	unit->mag += (MagClassTable[newClass->number].baseMag - MagClassTable[oldClass->number].baseMag);
	unit->skl += (newClass->baseSkl - oldClass->baseSkl);
	unit->spd += (newClass->baseSpd - oldClass->baseSpd);
	unit->def += (newClass->baseDef - oldClass->baseDef);
	unit->res += (newClass->baseRes - oldClass->baseRes);*/

	unit->pClassData = newClass;

	HideUnitSMS(unit);
	MU_EndAll();
	MU_Create(unit);
}

void DismountUnitASMC(){
	Unit* unit = GetUnitStructFromEventParameter(gEventSlot[1]);
	if(unit->state & (US_DEAD | US_BIT16))
	{
		return;
	} 
	const ClassData* dismountedClass = GetDismountedClass(unit);
	if (dismountedClass != 0){
		UnitChangeClass(unit, dismountedClass);
	}
}

void MountUnitASMC(){
	Unit* unit = GetUnitStructFromEventParameter(gEventSlot[1]);
	if(unit->state & (US_DEAD | US_BIT16))
	{
		return;
	} 
	const ClassData* mountedClass = GetMountedClass(unit);
	if (mountedClass != 0){
		UnitChangeClass(unit, mountedClass);
	}
}

void MountAllASMC(){
	int currentUnitIndex;
	for( int i = 0; i <= 50; i++){
		currentUnitIndex = MountDismountAllTable[i];
		if(currentUnitIndex == 0xFF){
			break;
		}
		gEventSlot[1] = currentUnitIndex;
		MountUnitASMC();
		i++;
	}
}

void DismountAllASMC(){
	int currentUnitIndex = 0;
	for( int i = 0; i <= 50; i++){
		currentUnitIndex = MountDismountAllTable[i];
		if(currentUnitIndex == 0xFF){
			break;
		}
		gEventSlot[1] = currentUnitIndex;
		DismountUnitASMC();
		i++;
	}
}

/*
bool DismountTester(Unit* unit, int dismountType){
	const ClassData* mountedClassData = GetMountedClass(unit);
	if ((mountedClassData != 0 ) && (dismountType == 1) && (mountedClassData->attributes & CA_MOUNTED )){ // checks if mounted class is a horse
		return true;
	}
	if ((mountedClassData != 0) && (dismountType == 2)){ // checks if mounted class is a pegasus OR Loewe's prf classes
		if (mountedClassData->attributes & CA_PEGASUS){
			return true;
		}
		if ((mountedClassData->number == 0x1D) || (mountedClassData->number == 0x1F)){
			return true;
		}
	}
	if ((mountedClassData != 0) && (dismountType == 3) && (mountedClassData->attributes & CA_WYVERN)){ // checks if mounted class is a dragon AND not Loewe's prf classe
		if ((mountedClassData->number == 0x1D) || (mountedClassData->number == 0x1F)){
			return false;
		}
		return true;
	}
	return false;
}
*/
