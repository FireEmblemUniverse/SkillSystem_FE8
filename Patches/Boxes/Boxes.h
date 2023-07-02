#include "gbafe.h"

extern struct ClassData NewClassTable[]; 
void* MS_GetSaveAddressBySlot(unsigned slot);

struct BoxUnit { 
	u8 classID : 8; 
	u8 hp : 7; 
	u8 mag : 6; 
	u8 str : 6; 
	u8 skl : 6; 
	u8 spd : 6; 
	u8 def : 6; 
	u8 res : 6; 
	u8 luk : 6; 
	u8 lvl : 7; 
	u8 exp : 7; 
	u8 moves[5]; 
};

extern int BoxCapacity; 

//extern struct BoxUnit BoxUnitSaved[]; 


int GetFreeUnitID(void);
int GetFreeDeploymentID(void);
int IsBoxFull(void);
struct BoxUnit GetFreeBoxSlot(void);
struct BoxUnit GetTakenBoxSlot(void);
struct BoxUnit ClearBoxUnit(struct BoxUnit);
void PackUnitIntoBox_ASMC(void);
void UnpackUnitFromBox_ASMC(void);
struct BoxUnit PackUnitIntoBox(struct BoxUnit boxRam, struct Unit* unit);
struct Unit* UnpackUnitFromBox(struct Unit* unit, struct BoxUnit boxRam);




// Vanilla: 
extern struct Unit* GetUnitStructFromEventParameter(int id); 





