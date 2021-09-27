#ifndef GBAFE_ACTION_H
#define GBAFE_ACTION_H

#include "common.h"

typedef struct ActionData ActionData;

struct ActionData {
	// unknown stuff (sometimes RNs are pushed here) (maybe an union?)
	/* 00 */ u16 _u00[3];
	/* 06 */ u16 unk6;

	/* 08 */ u16 unk08[2];

	/* 0C */ u8 subjectIndex;
	/* 0D */ u8 targetIndex;

	/* 0E */ u8 xMove;
	/* 0F */ u8 yMove;

	/* 10 */ u8 moveCount;

	/* 11 */ u8 unitActionType;

	// maybe from this onwards it's an union?

	/* 12 */ u8 itemSlotIndex;
	/* 13 */ u8 xOther;
	/* 14 */ u8 yOther;
	/* 15 */ u8 trapType;

	/* 16 */ u8 suspendPointType;
};

enum {
	// 0x00?
	UNIT_ACTION_WAIT = 0x01,
	UNIT_ACTION_COMBAT = 0x02,
	UNIT_ACTION_STAFF = 0x03,
	UNIT_ACTION_DANCE = 0x04,
	// 0x05?
	UNIT_ACTION_STEAL = 0x06,
	UNIT_ACTION_SUMMON = 0x07,
	UNIT_ACTION_SUMMON_DK = 0x08,
	UNIT_ACTION_RESCUE = 0x09,
	UNIT_ACTION_DROP = 0x0A,
	UNIT_ACTION_TAKE = 0x0B,
	UNIT_ACTION_GIVE = 0x0C,
	// 0x0D?
	UNIT_ACTION_TALK = 0x0E,
	UNIT_ACTION_SUPPORT = 0x0F,
	UNIT_ACTION_VISIT = 0x10,
	UNIT_ACTION_SEIZE = 0x11,
	UNIT_ACTION_DOOR = 0x12,
	// 0x13?
	UNIT_ACTION_CHEST = 0x14,
	UNIT_ACTION_PICK = 0x15,
	// 0x16?
	UNIT_ACTION_SHOPPED = 0x17,
	// 0x18?
	UNIT_ACTION_ARENA = 0x19,
	UNIT_ACTION_USE_ITEM = 0x1A,
	// 0x1B?
	// 0x1C?
	UNIT_ACTION_TRADED = 0x1D,
	// 0x1E?
	// 0x1F?
	// 0x20?
	UNIT_ACTION_RIDE_BALLISTA = 0x21,
	UNIT_ACTION_EXIT_BALLISTA = 0x22,
};

enum {
	SUSPEND_POINT_PLAYERIDLE = 0,
	SUSPEND_POINT_DURINGACTION = 1,
	SUSPEND_POINT_CPPHASE = 2,
	SUSPEND_POINT_BSKPHASE = 3,
	SUSPEND_POINT_DURINGARENA = 4,
	SUSPEND_POINT_5 = 5,
	SUSPEND_POINT_6 = 6,
	SUSPEND_POINT_7 = 7,
	SUSPEND_POINT_8 = 8,
	SUSPEND_POINT_PHASECHANGE = 9
};

extern struct ActionData gActionData; //! FE8U = (0x0203A958)

#endif // GBAFE_ACTION_H
