
#pragma once

#if defined(MODERN) && MODERN
#  ifdef NONMATCHING
#    undef NONMATCHING
#  endif // NONMATCHING
#  ifdef BUGFIX
#    undef BUGFIX
#  endif // BUGFIX
#  define NONMATCHING 1
#  define BUGFIX 1
#endif // MODERN

#include <stdlib.h>

//#include "gba/gba.h"

#define CONST_DATA __attribute__((section(".data")))

//#include "types.h"
//#include "variables.h"
//#include "functions.h"

// helper macros

#define ARRAY_COUNT(array) (sizeof(array) / sizeof((array)[0]))

#define ABS(aValue) ((aValue) >= 0 ? (aValue) : -(aValue))

#define RECT_DISTANCE(aXA, aYA, aXB, aYB) (ABS((aXA) - (aXB)) + ABS((aYA) - (aYB)))