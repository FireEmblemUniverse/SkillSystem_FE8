#include "gbafe.h"

extern u16 AffinityDescTable[];

void AffinityDescLooper(struct HelpBoxProc* proc) {
	if (gStatScreen.unit->pCharacterData->affinity == 0) {
		TryRelocateHbLeft(proc);
	}
}

void AffinityDescGetter(struct HelpBoxProc* proc) {
	proc->mid = AffinityDescTable[gStatScreen.unit->pCharacterData->affinity];		
}
