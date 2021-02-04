#ifndef GBAFE_TRAPS_H
#define GBAFE_TRAPS_H

// bmtrap.c?

#include <stdint.h>

#include "common.h"

typedef struct EventTrapData EventTrapData;

typedef struct Trap Trap;
typedef struct Trap ActorTile; // because speedruns are neat

struct EventTrapData {
	/* 00 */ u8 type;
	/* 01 */ u8 data[5];
} __attribute__((packed));

struct Trap {
	/* 00 */ u8 xPosition;
	/* 01 */ u8 yPosition;
	
	/* 02 */ u8 type;
	
	/* 03 */ u8 data[5];
};

enum {
	TRAP_NONE       = 0,
	TRAP_BALLISTA   = 1,
	TRAP_OBSTACLE   = 2, // walls & snags
	TRAP_MAPCHANGE  = 3,
	TRAP_FIRETILE   = 4,
	TRAP_GAS        = 5,
	TRAP_MAPCHANGE2 = 6, // TODO: figure out
	TRAP_LIGHTARROW = 7,
	TRAP_8          = 8,
	TRAP_9          = 9,
	TRAP_TORCHLIGHT = 10,
	TRAP_MINE       = 11,
	TRAP_GORGON_EGG = 12, // TODO: figure out
	TRAP_LIGHT_RUNE = 13,
};

enum {
	// Ballista extdata definitions
	TRAP_EXTDATA_BLST_ITEMID   = 0, // ballista item id
	TRAP_EXTDATA_BLST_RIDDEN   = 2, // "is ridden" boolean
	TRAP_EXTDATA_BLST_ITEMUSES = 3, // ballista item uses

	// Obstacle (Snags and Walls) extdata definitions
	TRAP_EXTDATA_OBSTACLE_HP = 0, // hp left

	// Map Change extdata definitions
	TRAP_EXTDATA_MAPCHANGE_ID = 0, // map change id

	// Trap (Fire/Gas/Arrow) extdata definitions
	TRAP_EXTDATA_TRAP_TURNFIRST = 1, // start turn countdown
	TRAP_EXTDATA_TRAP_TURNNEXT  = 2, // repeat turn countdown
	TRAP_EXTDATA_TRAP_COUNTER   = 3, // turn counter
	TRAP_EXTDATA_TRAP_DAMAGE    = 4, // trap damage (needs confirmation)

	// Torchlight extdata definitions
	TRAP_EXTDATA_LIGHT_TURNSLEFT = 0, // turns left before wearing out

	// Light Rune extdata definitions
	TRAP_EXTDATA_RUNE_REPLACINGTERRAIN = 0, // terrain id of the replaced tile
	TRAP_EXTDATA_RUNE_TURNSLEFT        = 3, // turns left beofre wearing out
};

extern struct Trap gTrapArray[]; //! FE8U = (0x0203A614)

struct Trap* GetTrapAt(int x, int y); //! FE8U = (0x0802E1F0+1)
struct Trap* GetSpecificTrapAt(int x, int y, int type); //! FE8U = (0x0802E24C+1)

struct Trap* AddTrap(int x, int y, int type, int ext); //! FE8U = (0x0802E2B8+1)
struct Trap* AddTrapExt(int x, int y, int type, int ext1, int ext24, int ext3, int ext5); //! FE8U = (0x0802E2E0+1)
void RemoveTrap(struct Trap* trap); //! FE8U = (0x0802E2FC+1)
void AddFireTrap(int x, int y, int startCountDown, int resetCountDown); //! FE8U = (0x0802E314+1)
void AddGasTrap(int x, int y, int direction, int startCountDown, int resetCountDown); //! FE8U = (0x0802E330+1)
void AddArrowTrap(int x, int startCountDown, int resetCountDown); //! FE8U = (0x0802E350+1)
void AddTrap8(int x, int y); //! FE8U = (0x0802E388+1)
void AddTrap9(int x, int y, int ext); //! FE8U = (0x0802E398+1)

// map changes -> map.h?
void ApplyTrapMapChanges(void); //! FE8U = (0x0802E430+1)

void ApplyMapChangesById(int id); //! FE8U = (0x0802E58C+1)
void AddMapChange(int id); //! FE8U = (0x0802E5F8+1)
void RemoveMapChange(int id); //! FE8U = (0x0802E60C+1)
int AreMapChangeTriggered(int id); //! FE8U = 0x802E639

void HideIfUnderRoof(struct Unit*); //! FE8U = (0x0802E660+1)
void UpdateUnitsUnderRoof(void); //! FE8U = (0x0802E690+1)

// other file?
void AddGorgonEggTrap(int a, int b, int c, int d, int e); //! FE8U = (0x08037928+1)
struct Trap* AddBallista(int x, int y, int itemIndex); //! FE8U = (0x08037A04+1)

#endif // GBAFE_TRAPS_H
