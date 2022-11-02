#include "gbafe.h"

static char* const TacticianName = (char* const) (0x202bd10); //8 bytes long

u8 HashByte_N(u8 number, u8 noise, int max){
  if (max==0) return 0;
  u32 hash = 5381;
  hash = ((hash << 5) + hash) ^ gChapterData.chapterIndex;
  hash = ((hash << 5) + hash) ^ noise;
  hash = ((hash << 5) + hash) ^ number;
  for (int i = 0; i < 9; ++i){
    if (TacticianName[i]==0) break;
    hash = ((hash << 5) + hash) ^ TacticianName[i];
  };
  
  return Mod((u16)hash, max);
};










