#ifndef GBAFE_CLASS_H
#define GBAFE_CLASS_H

#include <stdint.h>

#include "common.h"

typedef struct _ClassData ClassData;

struct _ClassData {
	uint16_t nameTextId;//0
	uint16_t descTextId;
	uint8_t  number;//4
	uint8_t  promotion;
	uint8_t  SMSId;
	uint8_t  slowWalking;
	uint16_t defaultPortraitId;//8
	uint8_t  u0A;
	
	uint8_t  baseHP;
	uint8_t  basePow;//c
	uint8_t  baseSkl;
	uint8_t  baseSpd;
	uint8_t  baseDef;
	uint8_t  baseRes;//10
	// uint8_t  baseLck;
	uint8_t  baseCon;
	uint8_t  baseMov;
	
	uint8_t  maxHP;
	uint8_t  maxPow;//14
	uint8_t  maxSkl;
	uint8_t  maxSpd;
	uint8_t  maxDef;
	uint8_t  maxRes;//18
	// uint8_t  maxLck;
	uint8_t  maxCon;
	
	uint8_t  classRelativePower;
	
	uint8_t  growthHP;
	uint8_t  growthPow;//1c
	uint8_t  growthSkl;
	uint8_t  growthSpd;
	uint8_t  growthDef;
	uint8_t  growthRes;//20
	uint8_t  growthLck;
	
	uint8_t  promotionHP;
	uint8_t  promotionPow;
	uint8_t  promotionSkl;//24
	uint8_t  promotionSpd;
	uint8_t  promotionDef;
	uint8_t  promotionRes;
	
	uint32_t attributes;//28
	
	uint8_t  ranks[8];//2c
	
	const void* pBattleAnimDef;
	const void* pMovCostTable[3]; // standard, rain, snow
	const void* pTerrainBonusTables[3]; // def, avo, res
	
	const void* _pU50;
};

extern const ClassData gClassData[];

#endif // GBAFE_CLASS_H
