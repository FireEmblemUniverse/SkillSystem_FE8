#include "global.h"

#include "statscreen.h"
#include "bmunit.h"

extern u16 StatusDescTable[];
extern int gStatusMaxCount;

void StatusDescGetter(struct HelpBoxProc * proc) {

    if (gStatScreen.unit->statusIndex >= gStatusMaxCount) {
        proc->mid = 0x552; // default
    }

    proc->mid = StatusDescTable[gStatScreen.unit->statusIndex];

    return;
}
