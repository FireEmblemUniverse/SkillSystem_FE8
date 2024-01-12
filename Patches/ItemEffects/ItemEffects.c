
#include "ItemEffects.h" 


int FlyMenuCommandUsability(void) { // fly menu doesn't appear in FMU mode 
	if (HpBarIsFMUActive()) { return 3; } 
	return FlyCommandUsability(); 


} 


inline int IsDigInitialized(void) { 
	if (*DigChapterRam_Link == 0) { return false; } 
	return true; 
} 

inline int IsTeleportInitialized(void) { 
	if (*TeleportChapter_Link == 0) { return false; } 
	return true; 
} 

int DigFieldMoveUsability(void) { 
	if (EscapeRopeChapterTable[gPlaySt.chapterIndex] != 1) { return 3; } // unusable 
	// search party for dig 
	if (!IsDigInitialized()) { return 3; } 
	if (DoesPartyKnowMove(Dig_Link)) { return 1; } 
	return 3; 
} 
int DigFieldMoveEffect(void) { 
	CallEvent(DigEvent, 1); 
	return MENU_ACT_DOOM|MENU_ACT_CLEAR|MENU_ACT_SND6A; // 0x94 
} 

int EscapeRopeUsability(void) { // ch menu entry 
	if (EscapeRopeChapterTable[gPlaySt.chapterIndex] != 1) { return 3; } // unusable 
	if (DigFieldMoveUsability() == 1) { return 3; } // dig can be used instead 
	if (!IsDigInitialized()) { return 3; } 
	// search items for escape rope 
	if (DoesPartyHaveItem(WarpCrystal_Link)) { 
		return 1; 
	} 
	if (GetConvoyItemSlot(WarpCrystal_Link) != (-1)) { 
		return 1; 
	} 
	
	return 1; 

} 

int EscapeRopeItemUsability(void) { // usable held item 
	if (EscapeRopeChapterTable[gPlaySt.chapterIndex] != 1) { return 3; } // unusable 
	if (!IsDigInitialized()) { return 3; } 
	return 3; 
} 



int EscapeRopeMenuEffect(void) { 
	// take 1 use from wherever 
	if (!DepleteItemFromParty(EscapeRope_Link)) { 
		// nobody in party had it, so remove 1 use from convoy 
		int slot = GetConvoyItemSlot(EscapeRope_Link); 
		if (slot != (-1)) { // just in case 
			u16* convoy = GetConvoyItemArray(); 
			int item = convoy[slot]; 
			item = GetItemAfterUse(item); 
			if (item) { convoy[slot] = item; } 
			else { RemoveItemFromConvoy(slot); } // no uses left, so delete item 
		} 
	} 

	CallEvent(DigEvent, 1); 
	return MENU_ACT_DOOM|MENU_ACT_CLEAR|MENU_ACT_SND6A; // 0x94 
} 



int TeleportFieldMoveUsability(void) { 
	if (!IsTeleportInitialized()) { return 3; } 
	// if any psychic types on your team, you can teleport. 
	if (IsAnyPartyMemberThisType(PsychicType_Link)) { return 1; }  
	//if (DoesPartyKnowMove(Teleport_Link)) { return 1; } 
	return 3; 
} 
int TeleportFieldMoveEffect(void) { 
	CallEvent(TeleportEvent, 1); 
	return MENU_ACT_DOOM|MENU_ACT_CLEAR|MENU_ACT_SND6A; // 0x94 
} 


int WarpCrystalUsability(void) { 
	if (!IsTeleportInitialized()) { return 3; } 
	if (TeleportFieldMoveUsability() == 1) { return 3; } // can use teleport instead 

	if (DoesPartyHaveItem(WarpCrystal_Link)) { 
		return 1; 
	} 
	if (GetConvoyItemSlot(WarpCrystal_Link) != (-1)) { 
		return 1; 
	} 
	
	
	// check all items for crystal 
	return 3; 
} 

int WarpCrystalMenuEffect(void) { 
	// take 1 use from wherever 
	if (!DepleteItemFromParty(WarpCrystal_Link)) { 
		// nobody in party had it, so remove 1 use from convoy 
		int slot = GetConvoyItemSlot(WarpCrystal_Link); 
		if (slot != (-1)) { // just in case 
			u16* convoy = GetConvoyItemArray(); 
			int item = convoy[slot]; 
			item = GetItemAfterUse(item); 
			if (item) { convoy[slot] = item; } 
			else { RemoveItemFromConvoy(slot); } // no uses left, so delete item 
		} 
	} 
	
	CallEvent(TeleportEvent, 1); 
	return MENU_ACT_DOOM|MENU_ACT_CLEAR|MENU_ACT_SND6A; // 0x94 
} 



int TravelCommandUsability(void) { 
	if ((FlyCommandUsability() == 1) || (EscapeRopeUsability() == 1) || (DigFieldMoveUsability() == 1) || (WarpCrystalUsability() == 1) || (TeleportFieldMoveUsability() == 1)) { return 1; } 
	return 3; // does not show up 

} 



int TravelCommandEffect(struct MenuProc* menu) { 
	//struct MenuProc* StartOrphanMenuAdjusted(const struct MenuDef* def, int xSubject, int xTileLeft, int xTileRight);
	int diff = gBmSt.cursorTarget.x - gBmSt.camera.x; 
	if (diff < 120) { diff = 120; } // opposite side that ch menu opens on 
	else { diff = 0; } 
	
	//StartMenu(&travelSubMenuDef, parent);
	StartOrphanMenuAdjusted(&travelSubMenuDef,  diff, 1, 0x15); // 0x17 default 
	return MENU_ACT_DOOM|MENU_ACT_CLEAR|MENU_ACT_SND6A; // 0x94 
	//return MENU_ACT_SND6A; // 0x94 
	
	
	/*
	// trying to get it to work as a submenu 
	struct MenuRect rect;
	
	if (diff > 120) { rect.x = 1; } 
	//if (menu->rect.x > 14) { rect.x = 1; } 
	//else { menu->rect.x = 0x15; } 
	else { menu->rect.x = 0x15; } 
    rect.y = menu->rect.y + 1;
    rect.w = 9;
    rect.h = 0;

    //sub_80234AC(rect.x, rect.y);

    StartMenuAt(&travelSubMenuDef, rect, (struct Proc*)menu);

    return MENU_ACT_SND6A;
	*/
	
} 


u8 TravelCancelSelect(struct MenuProc* menu, struct MenuItemProc* item)
{
    return MENU_ACT_SKIPCURSOR | MENU_ACT_CLEAR | MENU_ACT_END | MENU_ACT_SND6B;
    //return MENU_ACT_END | MENU_ACT_SND6B;
}

/*
https://github.com/FireEmblemUniverse/fireemblem8u/blob/51af2f561d98f133d2285d77c448c7e0452fe09c/src/bmmenu.c#L943
*/
int IsAnyPartyMemberThisType(int id) { 
	int i = 0; 
	struct Unit* unit; 
	for (i = 0x101; i < 0x108; i++) { 
		unit = GetUnit(i); 
		if (!UNIT_IS_VALID(unit)) { 
			continue; 
		} 
		if ((int)unit->pClassData->_pU50 & id) { 
			return true; 
		} 
		
	} 
	return false; 


} 


int DoesPartyHaveItem(int id) { 
	int i = 0; int c = 0;  
	int item; 
	struct Unit* unit; 
	for (i = 0x101; i < 0x108; i++) { 
		unit = GetUnit(i); 
		if (!UNIT_IS_VALID(unit)) { 
			continue; 
		} 
		for (c = 0; c < 5; c++) { 
			item = unit->items[c] & 0xFF; 
			if (!item) { break; } 
			if (item == id) { return true; } 
		} 
	} 
	return false; 
} 

int DoesPartyKnowMove(int id) { 
	int i = 0; int c = 0;  
	int move; 
	struct Unit* unit; 
	for (i = 0x101; i < 0x108; i++) { 
		unit = GetUnit(i); 
		if (!UNIT_IS_VALID(unit)) { 
			continue; 
		} 
		for (c = 0; c < 5; c++) { 
			move = unit->ranks[c] & 0xFF; 
			if (!move) { break; } 
			if (move == id) { return true; } 
		} 
	} 
	return false; 
} 

int DepleteItemFromParty(int id) { 
	int i = 0; int c = 0;  
	int item; 
	struct Unit* unit; 
	for (i = 0x101; i < 0x108; i++) { 
		unit = GetUnit(i); 
		if (!UNIT_IS_VALID(unit)) { 
			continue; 
		} 
		for (c = 0; c < 5; c++) { 
			item = unit->items[c] & 0xFF; 
			if (!item) { break; } 
			if (item == id) { 
				unit->items[c] = GetItemAfterUse(unit->items[c]);
				UnitRemoveInvalidItems(unit);
			
				return true; 
			} 
		} 
	} 
	return false; 
} 


