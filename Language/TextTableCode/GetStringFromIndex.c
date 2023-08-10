
#include "include/global.h"
struct MsgBuffer
{
    u8 buffer1[0x555];
    u8 buffer2[0x555];
    u8 buffer3[0x356];
    u8 buffer4[0x100];
    u8 buffer5[0x100];
};
extern const u8 *const TextTable[];
void CallARM_DecompText(const char *a, char *b);
void SomethingRelatedToText(s8 *a);
extern struct MsgBuffer sMsgString;
extern int sActiveMsg;
//s8 CheckFlag(int flag); 

extern u8* CurrentLanguage_Link; 

extern const u8 * const * const TextTables[];

char * GetStringFromIndexInBuffer(int index, char *buffer)
{
	int language = *CurrentLanguage_Link; 
	if (language > 1) language = 0; 
	const u8 * ptr = TextTables[language][index];
    CallARM_DecompText(ptr, buffer);
    SomethingRelatedToText((void*)buffer);
    return (void*)buffer;
}













