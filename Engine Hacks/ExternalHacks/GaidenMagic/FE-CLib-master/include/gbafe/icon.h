#ifndef GBAFE_ICON_H
#define GBAFE_ICON_H

#include "common.h"

void _ResetIconGraphics(void); //! FE8U = 0x8003579
void ClearIcons(void); //! FE8U = 0x8003585
void LoadIconPalettes(unsigned rootBank); //! FE8U = 0x80035BD
void LoadIconPalette(unsigned which, unsigned bank); //! FE8U = 0x80035D5
u16 GetIconGfxTileIndex(unsigned tileId); //! FE8U = 0x8003611
int GetIconGfxIndex(int); //! FE8U = 0x8003625
u16 GetIconTileIndex(int); //! FE8U = 0x8003651
void DrawIcon(u16* bgOut, int iconId, int oam2Base); //! FE8U = 0x80036BD
void ClearIcon(unsigned iconId); //! FE8U = 0x800370D
void LoadIconObjectGraphics(int iconId, int rootTile); //! FE8U = 0x800372D

#endif // GBAFE_ICON_H
