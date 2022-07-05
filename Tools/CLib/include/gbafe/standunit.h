#ifndef GBAFE_STANDUNIT_H
#define GBAFE_STANDUNIT_H

struct SMSHandle
{
	/* 00 */ struct SMSHandle* pNext;

	/* 04 */ short xDisplay;
	/* 06 */ short yDisplay;

	/* 08 */ u16 oam2Base;

	/* 0A */ u8 unk0A;
	/* 0B */ s8 config;
};

struct SMSData
{
	/* 00 */ u16 unk00;
	/* 02 */ u16 size;
	/* 04 */ const u8* pGraphics;
};

extern const struct SMSData gStandingMapSpriteData[];

#define SMS_SIZE(aId) (gStandingMapSpriteData[(aId)].size)

unsigned SMS_RegisterUsage(unsigned id); //!< FE8U:080267FD

void SMS_SyncIndirect(void); //!< FE8U:08026F95

unsigned GetUnitBattleMapSpritePaletteIndex(struct Unit*); //!< FE8U:0802713D
unsigned GetUnitMapSpritePaletteIndex(struct Unit*); //!< FE8U:08027169

void SMS_UpdateFromGameData(void); //!< FE8U:080271A1
struct SMSHandle* SMS_GetNewInfoStruct(int y); //!< FE8U:0802736D
void SMS_DisplayAllFromInfoStructs(void); //!< FE8U:080273A5

void HideUnitSMS(struct Unit* unit); //!< FE8U:0802810D
void ShowUnitSMS(struct Unit* unit); //!< FE8U:08028131

#endif // GBAFE_STANDUNIT_H
