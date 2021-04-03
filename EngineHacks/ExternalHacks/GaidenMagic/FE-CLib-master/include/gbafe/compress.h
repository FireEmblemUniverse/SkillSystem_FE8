#ifndef GBAFE_COMPRESS_H
#define GBAFE_COMPRESS_H

#include "common.h"

extern u8 gGenericBuffer[0x2000]; //! FE8U = 0x2020188

void String_CopyTo(char* target, const char* source); //! FE8U = 0x8012EC1
void CopyNoCompData(const void* source, void* target); //! FE8U = 0x8012EDD
void Decompress(const void* source, void* target); //! FE8U = 0x8012F51
unsigned GetNoCompDataSize(const void*); //! FE8U = 0x8012F91

#endif // GBAFE_COMPRESS_H
