1. Install anti-huffman and UTF-8 patches. 
2. Build your baserom. (MAKE_HACK_baserom.cmd)
3. Open baserom in FEBuilder -> Advanced Editors -> Font -> "Bulk Import" the item/serif/punctuation files 
4. Advanced Editors -> Export with EA -> Export Undo Buffer -> Save in Root/Fonts 
5. `#include` new font path in baserom.event 
6. Update your secondary free space location