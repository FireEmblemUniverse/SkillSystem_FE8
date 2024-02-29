#include "ModularSave.h"

// This contains Save functions suitables for MS save chunks
// In case there's no vanilla function that fit the bill
// If a Suspend chunk function is also used in a Save chunk, it will be here

void MSa_SaveChapterState(void* target, unsigned size) {
	gPlaySt.time_saved = GetGameClock();
	WriteAndVerifySramFast(&gPlaySt, target, size);
}

void MSa_LoadChapterState(void* source, unsigned size) {
	ReadSramFast(source, &gPlaySt, size);
	SetGameTime(gPlaySt.time_saved);
}

void MSa_SaveUnits(void* target, unsigned size) {
	struct GlobalSaveInfo sgm;
	ReadGlobalSaveInfo(&sgm);

	for (unsigned i = 0; i < 51; ++i) {
		struct Unit* unit = GetUnit(i+1);

		// Save unit
		WriteGameSavePackedUnit(unit, target + (0x24*i));

		// Register it to be known
		if (unit->pCharacterData)
			SGM_SetCharacterKnown(unit->pCharacterData->number, &sgm);
	}

	WriteGlobalSaveInfo(&sgm);
}

void MSa_LoadUnits(void* source, unsigned size) {
	for (unsigned i = 0; i < 51; ++i)
		LoadSavedUnit(source + (0x24*i), GetUnit(i+1));
}

void MSa_SaveBonusClaim(void* target, unsigned size) {
	WriteAndVerifySramFast((void*)(0x0203EDB4), target, size);
}

void MSa_LoadBonusClaim(void* source, unsigned size) {
	ReadSramFast(source, (void*)(0x0203EDB4), size);
}

void MSa_SaveWMStuff(void* target, unsigned size) {
	WriteWorldMapStuff(target, &gGMData);
}

void MSa_LoadWMStuff(void* source, unsigned size) {
	ReadWorldMapStuff(source, &gGMData);
}

void MSa_SaveDungeonState(void* target, unsigned size) {
	WriteAndVerifySramFast((void*)(0x30017AC), target, size);
}

void MSa_LoadDungeonState(void* source, unsigned size) {
	ReadSramFast(source, (void*)(0x30017AC), size);
}
