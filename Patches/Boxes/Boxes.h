
#define POKEMBLEM_VERSION


//extern struct ClassData NewClassTable[]; 
extern struct ClassData* classTablePoin[]; 

extern void InitUnits(void); 
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
	u32 support0 : 4; 
	u32 support1 : 4; 
	u32 support2 : 4; 
	u32 support3 : 4; 
	u32 support4 : 4; 
	u32 support5 : 4; 
	u32 unitLeader : 4; 
	
	u32 conBonus : 4; 
	u32 movBonus : 4; 
	u32 hp : 7; 
	u32 lvl : 6; 
	u32 escaped : 1; 
	u32 departed : 1; 
	u32 exp : 7; 
	u32 mag : 6; 
	u32 str : 6; 
	u32 skl : 6; 
	u32 spd : 6; 
	u32 def : 6; 
	u32 res : 6; 
	u32 luk : 6; // 156 or 19 / #0x14 bytes per unit to be saved = 97 units or 69 without approximating 
	// 60 bits are saved by approximating supports / wexp 
};
#endif 


extern struct Unit unit[62]; // gGenericBuffer 0x2020188
extern struct BoxUnit bunit[100]; 

extern int BoxCapacity; 
extern int BoxBufferCapacity; 
extern int PartySizeThreshold; 
extern int ProtagID_Link; 

extern struct Unit PCBoxUnitsBuffer[]; //0x2026E30 size 0x2048 

//extern struct BoxUnit BoxUnitSaved[]; 

void NewRegisterPrepUnitList(int index, struct Unit *unit);
int GetFreeUnitID(struct Unit buffer[]);
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
int CountAndUndeployTempUnits(void);
void DeploySelectedUnits(void);
int CountUnitsInUnitStructRam(void);
void ClearPCBoxUnitsBuffer(void);
void RelocateUnitsPastThreshold(int startingOffset);
void ClearAllBoxUnits(int slot);
void ClearAllBoxUnitsASMC(void);
void EnsureUnitInPartyASMC(void);
int EnsureUnitInParty(int slot, int charID);

int CountTotalUnitsInUnitStructRam(void); 
int CountUnusableUnitsUpToIndex(int index);
int CountUnusableStoredUnitsUpToIndex(int index);


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
inline struct Unit* GetGenericBufferUnit(int i) { 
	return &unit[i]; 
} 
