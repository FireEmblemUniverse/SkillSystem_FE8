
//{{BLOCK(minimap)

//======================================================================
//
//	minimap, 64x64@4, 
//	+ palette 16 entries, not compressed
//	+ 64 tiles lz77 compressed
//	Total size: 32 + 1000 = 1032
//
//	Time-stamp: 2023-08-31, 17:29:46
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.6
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_MINIMAP_H
#define GRIT_MINIMAP_H

#define minimapTilesLen 1000
extern const unsigned short minimapTiles[500];

#define minimapPalLen 32
extern const unsigned short minimapPal[16];

#endif // GRIT_MINIMAP_H

//}}BLOCK(minimap)
