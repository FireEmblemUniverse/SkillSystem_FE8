#ifndef GBAFE_STANDUNIT_H
#define GBAFE_STANDUNIT_H

struct SMSHandle {
	/* 00 */ struct SMSHandle* pNext;

	/* 04 */ short xDisplay;
	/* 06 */ short yDisplay;

	/* 08 */ u16 oam2Base;

	/* 0A */ u8 unk0A;
	/* 0B */ s8 config;
};

unsigned GetUnitBattleMapSpritePaletteIndex(const struct Unit*); //! FE8U = 0x802713D
unsigned GetUnitMapSpritePaletteIndex(const struct Unit*); //! FE8U = 0x8027169

void SMS_UpdateFromGameData(void); //! FE8U = (0x80271A1)
void SMS_DisplayAllFromInfoStructs(void); //! FE8U = 0x80273A5

void HideUnitSMS(struct Unit* unit); //! FE8U = (0x0802810C+1)
void ShowUnitSMS(struct Unit* unit); //! FE8U = (0x08028130+1)

#endif // GBAFE_STANDUNIT_H
