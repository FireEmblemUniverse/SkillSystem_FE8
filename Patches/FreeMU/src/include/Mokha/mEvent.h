#ifndef HEARDERMOKHA_EVENT
#define HEARDERMOKHA_EVENT

u8 GetBattleMapType(void); // 0x80BD069

struct ROMChapterData* GetChapterEventDataPointer(u8);
//u32** GetChapterEventDataPointer(u8);	// 0x80346B1
u8 GetLocationEventCommandAt(s8 x, s8 y); // 0x8084079
u8 CheckEventDefinition(u32*);

void RunLocationEvents(s8 x, s8 y); // 0x80840C5
void CallMapEventEngine(u32,u8); // 0x800D07D
void CallEventDefinition(u32*,u8); // 0x8082E81

void ClearActiveEventRegistry(u32*); // 0x80845A5


#endif	//HEARDERMOKHA_EVENT