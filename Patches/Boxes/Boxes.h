

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
extern int BoxBufferCapacity; 

extern struct Unit PCBoxUnitsBuffer[]; //0x2026E30 size 0x2048 

//extern struct BoxUnit BoxUnitSaved[]; 


int GetFreeUnitID(void);
int GetFreeDeploymentID(void);
int IsBoxFull(int slot);
struct BoxUnit* GetFreeBoxSlot(int slot);
struct BoxUnit* GetTakenBoxSlot(int slot);
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
void DeploySelectedUnits(int count);
int CountUnitsInUnitStructRam(void);
void ClearPCBoxUnitsBuffer(void);

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
