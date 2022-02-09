#include "gbafe.h"

void DismountRoutine(Proc* procState);
void MountRoutine(Proc* procState);
int DismountUsability();
int MountUsability();
const ClassData* GetDismountedClass(Unit* unit);
const ClassData* GetMountedClass(Unit* unit);
void UnitChangeClass(Unit* unit, const ClassData* newClass);
void DismountAllASMC();
void MountAllASMC();

typedef struct DismountEntry DismountEntry;

struct DismountEntry{
	/* 00 */ u8 mountedNumber;
	/* 01 */ u8 dismountedNumber;
};

extern struct DismountEntry MountedClassTable[];

#define USABILITY_TRUE 1
#define USABILITY_GRAY 2
#define USABILITY_FALSE 3
