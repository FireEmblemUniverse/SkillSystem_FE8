#ifndef GBAFE_CHARACTER_H
#define GBAFE_CHARACTER_H

#include <stdint.h>

#include "common.h"

typedef struct _CharacterData CharacterData;

struct _CharacterData {
	uint16_t nameTextId;
	uint16_t descTextId;
	uint8_t  number;
	uint8_t  defaultClass;
	uint16_t portraitId;
	uint8_t  miniPortrait;
	uint8_t  affinity;
	uint8_t  u0A;
	
	uint8_t  baseLevel;
	uint8_t  baseHP;
	uint8_t  basePow;
	uint8_t  baseSkl;
	uint8_t  baseSpd;
	uint8_t  baseDef;
	uint8_t  baseRes;
	uint8_t  baseLck;
	uint8_t  baseCon;
	
	uint8_t  ranks[8];
	
	uint8_t  growthHP;
	uint8_t  growthPow;
	uint8_t  growthSkl;
	uint8_t  growthSpd;
	uint8_t  growthDef;
	uint8_t  growthRes;
	uint8_t  growthLck;
	
	uint8_t  u23;
	uint8_t  u24;
	uint8_t  u25;
	uint8_t  u26;
	uint8_t  u27;
	
	uint32_t attributes;
	
	void*    pSupportData;
	void*    pU30;
};

extern const CharacterData gCharacterData[];

#endif // GBAFE_CHARACTER_H
