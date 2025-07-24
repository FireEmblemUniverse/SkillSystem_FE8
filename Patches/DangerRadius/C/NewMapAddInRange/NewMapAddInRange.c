#include "../RangeStuff.h"

// ballistas issue?
// ItemRangeFix.event "//Fix my ballista issues the lazy way (instead of not
// passing in bool via r12, just make range function not use r12)" edits the
// vanilla version of this function draw fog in this function if DR state is set

void PokemblemMapAddInRange(int x, int y, int range, int value) //
{
  int ix, iy, iRange;
  int setFog = (gBmSt.gameStateBits &
                BM_FLAG_3); // @ Check if we're called by DangerRadius

  // Handles rows [y, y+range]
  // For each row, decrement range
  for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y);
       --iRange, ++iy) {
    int xMin, xMax, xRange;

    xMin = x - iRange;
    xRange = 2 * iRange + 1;

    if (xMin < 0) {
      xRange += xMin;
      xMin = 0;
    }

    xMax = xMin + xRange;

    if (xMax > gBmMapSize.x) {
      xMax -= (xMax - gBmMapSize.x);
      xMax = gBmMapSize.x;
    }

    for (ix = xMin; ix < xMax; ++ix) {
      gWorkingBmMap[iy][ix] += value;
      if (setFog) {
        gBmMapFog[iy][ix] = 1;
      }
    }
  }

  // Handle rows [y-range, y-1], starting from the bottom most row
  // For each row, decrement range
  for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0);
       --iRange, --iy) {
    int xMin, xMax, xRange;

    xMin = x - iRange;
    xRange = 2 * iRange + 1;

    if (xMin < 0) {
      xRange += xMin;
      xMin = 0;
    }

    xMax = xMin + xRange;

    if (xMax > gBmMapSize.x) {
      xMax -= (xMax - gBmMapSize.x);
      xMax = gBmMapSize.x;
    }

    for (ix = xMin; ix < xMax; ++ix) {
      gWorkingBmMap[iy][ix] += value;
      if (setFog) {
        gBmMapFog[iy][ix] = 1;
      }
    }
  }
}
