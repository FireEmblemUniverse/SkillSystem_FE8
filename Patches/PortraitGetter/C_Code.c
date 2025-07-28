#include "C_Code.h"
int GetUnitPortraitId(struct Unit *unit) {
  int portraitId = unit->pCharacterData->portraitId;

  if (!portraitId) {
    portraitId = unit->pClassData->defaultPortraitId;
  }
  if (portraitId && (unit->state & US_BIT23)) { // portraitId+1 bitflag
    portraitId += 1;
  }

  return portraitId;
}
