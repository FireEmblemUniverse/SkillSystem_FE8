
//#define POKEMBLEM_VERSION


extern struct ClassData NewClassTable[]; 
void* MS_GetSaveAddressBySlot(unsigned slot);

#ifdef POKEMBLEM_VERSION 
//struct __attribute__((packed)) BoxUnit { 
struct __attribute__((packed)) BoxUnit { 
	u8 classID : 8; 
	u8 moves[5];
	u32 hp : 7; 
	u32 lvl : 7; 
	u32 exp : 7; 
	u32 mag : 6; 
	u32 str : 6; 
	u32 skl : 6; 
	u32 spd : 6; 
	u32 def : 6; 
	u32 res : 6; 
	u32 luk : 6; 
};
#endif 
#ifndef POKEMBLEM_VERSION 
struct __attribute__((packed)) BoxUnit { 
	u8 unitID; 
	u8 classID; 
	u8 supportBits; 
	u32 metis : 1; 
	u8 wexp[4];
	u8 supports[2]; 
	u32 support5 : 4; 
	u32 unitLeader : 4; 
	
	u32 conBonus : 4; 
	u32 movBonus : 4; 
	u32 hp : 7; 
	u32 lvl : 7; 
	u32 exp : 7; 
	u32 mag : 6; 
	u32 str : 6; 
	u32 skl : 6; 
	u32 spd : 6; 
	u32 def : 6; 
	u32 res : 6; 
	u32 luk : 6; // 152 or 19 / #0x13 bytes per unit to be saved = 102 units 
};
#endif 

extern int BoxCapacity; 
extern int BoxBufferCapacity; 
extern int ProtagID_Link; 

extern struct Unit PCBoxUnitsBuffer[]; //0x2026E30 size 0x2048 

//extern struct BoxUnit BoxUnitSaved[]; 


int GetFreeUnitID(void);
int GetFreeDeploymentID(void);
int IsBoxFull(int slot);
struct BoxUnit* GetFreeBoxSlot(int slot);
struct BoxUnit* GetTakenBoxSlot(int slot, int index);
struct BoxUnit* ClearBoxUnit(struct BoxUnit*);
void PackUnitIntoBox_ASMC(void);
void UnpackUnitFromBox_ASMC(void);
struct BoxUnit* PackUnitIntoBox(struct BoxUnit* boxRam, struct Unit* unit);
struct Unit* UnpackUnitFromBox(struct BoxUnit* boxRam, struct Unit* unit);
struct Unit* GetFreeTempUnitAddr(void);
struct Unit* GetTakenTempUnitAddr(void);
void* PC_GetSaveAddressBySlot(unsigned slot); 
int UnpackUnitsFromBox(int slot);
void PackUnitsIntoBox(int slot);
int CountTempUnits(void); 
void DeploySelectedUnits(void);
int CountUnitsInUnitStructRam(void);
void ClearPCBoxUnitsBuffer(void);
void RelocateUnitsPast50(int startingOffset);
void ClearAllBoxUnits(int slot);
void ClearAllBoxUnitsASMC(void);


struct SaveBlockDecl {
	/* 00 */ u16 offset;
	/* 02 */ u16 type;
};
extern const u16 PCBoxSizeLookup[];
extern const struct SaveBlockDecl PCBoxSaveBlockDecl[];

// Vanilla: 
extern struct Unit* GetUnitStructFromEventParameter(int id); 
extern int AddItemToConvoy(int); 
extern void ReorderPlayerUnitsBasedOnDeployment(void); 

inline struct Unit* GetTempUnit(int i) { 
	return &PCBoxUnitsBuffer[i]; 
} 
