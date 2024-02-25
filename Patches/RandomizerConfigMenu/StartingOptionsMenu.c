
#include "StartingOptionsMenu.h"

// lovingly borrowed from circles' self-rando
static const ProcCode StartingOptionsProc[] = {
  PROC_SET_NAME("StartingOptions"),
  PROC_CALL_ROUTINE(LockGameLogic),
  PROC_END_ALL(0x8a20b1c),
  // PROC_END_ALL(0x8a206a8), //savemenu drawing

  PROC_CALL_ROUTINE(StartingOptionsSetup),
  // PROC_CALL_ROUTINE(0x80b1a09), //original config drawing

    PROC_CALL_ROUTINE_ARG(NewFadeIn, 8),
    PROC_WHILE_ROUTINE(FadeInExists),
    PROC_SLEEP(1),

  PROC_LOOP_ROUTINE(StartingOptionsLoop), //wait for B button
  
  PROC_CALL_ROUTINE_ARG(NewFadeOut, 0x10),
  PROC_WHILE_ROUTINE(FadeOutExists),
  PROC_SLEEP(10),

  PROC_END
};

static const ProcCode StartingOptionsSavedProc[] = {
  PROC_SET_NAME("StartingOptionsSaved"),
    PROC_SLEEP(1),
  PROC_LOOP_ROUTINE(SaveStartingOptionsLoop), 
  PROC_END
};

static const ProcCode SpinProc[] = {
  PROC_SET_NAME("SpinnyBoi"),
  PROC_SET_MARK(0xD),
  PROC_CALL_ROUTINE(&SpinRoutine1),
  PROC_LOOP_ROUTINE(&SpinRoutine2),
  PROC_END
};

static const ProcCode NewGameDifficultySelect[] = {
  PROC_SET_NAME("DifficultySelect"),

  PROC_SET_DESTRUCTOR(0x80ac078+1),
  PROC_CALL_ROUTINE(0x80ad5b4+1),
  PROC_YIELD,
  PROC_CALL_ROUTINE(0x80ac1a8+1),
  PROC_SLEEP(1),
  PROC_CALL_ROUTINE(EnableAllGfx),//EnableAllGfx
  PROC_CALL_ROUTINE_ARG(NewFadeIn, 8),
  PROC_WHILE_ROUTINE(FadeInExists),
  PROC_LABEL(0),
  PROC_LOOP_ROUTINE(0x80ac288+1),
  PROC_LABEL(1),
    PROC_CALL_ROUTINE_ARG(NewFadeOut, 8),
    PROC_WHILE_ROUTINE(FadeOutExists),
    PROC_SLEEP(10),
    
      PROC_NEW_CHILD(SpinProc), //one spinny boi

    PROC_NEW_CHILD_BLOCKING(StartingOptionsProc),

    // PROC_NEW_CHILD_BLOCKING(0x8a2ece0), //config proc
    PROC_SLEEP(10),

  PROC_LABEL(2),
  PROC_CALL_ROUTINE_ARG(NewFadeOut, 8),
  PROC_WHILE_ROUTINE(FadeOutExists),
  PROC_CALL_ROUTINE(nullsub_64),

  PROC_YIELD,

  PROC_CALL_ROUTINE(0x80a8c2c+1),
  PROC_YIELD,
  PROC_CALL_ROUTINE(0x80a8cd4+1),
  PROC_CALL_ROUTINE(0x80a8f04+1),
  PROC_YIELD,
  PROC_CALL_ROUTINE(UnlockGameLogic),
  PROC_END
};

extern int PAGE1MAXINDEX;
extern const u8 NumberOfOptionsPerEntryTable[]; 


static const LocationTable CursorLocationTable[] = {
  {10, 0x18},
  {10, 0x28},
  {10, 0x38},
  {10, 0x48},
  {10, 0x58},
  {10, 0x68},
  {10, 0x78}, //,
  {10, 0x88} //,
  // {10, 0x88} //leave room for a description?
};

//POIN to this at $a20164
void NewDifficultySelectFunc(ProcState* input){
  ProcStartBlocking(NewGameDifficultySelect, input);
};

void StartingOptionsSetup(OptionsProc* CurrentProc){
	//set up bg graphics
	ClearBG0BG1();
	EnableBgSyncByIndex(0);
	CpuSet((void*)0x859ED70, ((void*)0x020228A8 + 16 * 0x20), 0x20); //ui palette


	CpuSet((void*)0x8b1754c+0x20, ((void*)0x020228A8 + 8 * 0x20), 0x20); //bg palette

	VBlankIntrWait();
	LZ77UnCompVram((void*)0x8b12db4, (void*)0x6003000); //bg (changed from 0x6008000)
	GenerateBGTsa((u16*)BG1Buffer, 0x280, 8, 0x180); //was BG1Buffer
	//BG_Fill((void*)0x6007000, 0); //clear bg0 tilemap
	//BG_Fill((void*)0x6007800, 0); //clear bg1 tilemap
	VBlankIntrWait();
	*gColorSpecialEffectsSelectionBuffer = 0xA44; //blending set
	*gBg1ControlBuffer = 0xD03; //priority set

	//Load fonts
	// SetupDebugFontForBG(2, 0);
	// SetupDebugFontForOBJ(-1, 14);
	// SetupDebugFontForOBJ(0x6017800, 14);
	InitDefaultFont();
	// InitText(0, 0);

	//set up cursor
	CurrentProc->CursorIndex = 0;
	CurrentProc->Page = 1;
	CurrentProc->Option[0] = 0;
	CurrentProc->Option[1] = 0;
	CurrentProc->Option[2] = 0;
	CurrentProc->Option[3] = 0;
	CurrentProc->Option[4] = 0;
	CurrentProc->Option[5] = 0;
	CurrentProc->Option[6] = 0;
	CurrentProc->Option[7] = 0;

	
	OptionsSavedProc* proc = (void*)ProcStart(StartingOptionsSavedProc, (void*)3); 
	for (int i = 0; i<21; i++) { 
		proc->FlagOn[i] = 0; // init to 0 
	} 
	proc->timer = 0; // init game time as 0 

	updateOptionsPage(CurrentProc);
};

void GenerateBGTsa(u16 *MapOffset, u32 NumberOfTiles, u8 PaletteId, u16 baseTile) {
  for(u16 i = baseTile; i < (baseTile+NumberOfTiles/2)+1; i++) {
    MapOffset[i-baseTile] = (i | (PaletteId << 12));
    MapOffset[NumberOfTiles-(i-baseTile)] = (i | (PaletteId << 12) | (3<<10)); //v and h flipped
  }
}
extern char Title_Text; 
extern char OptionsCommand0_Text;
extern char OptionsCommand1_Text;
extern char OptionsCommand2_Text;
extern char OptionsCommand3_Text;
extern char OptionsCommand4_Text;
extern char OptionsCommand5_Text;
extern char OptionsCommand6_Text;
extern char OptionsCommand7_Text;

extern char Command0_Option0_Text; 
extern char Command0_Option1_Text; 
extern char Command0_Option2_Text; 
extern char Command0_Option3_Text; 
extern char Command0_Option4_Text; 
extern char Command0_Option5_Text; 
extern char Command0_Option6_Text; 
extern char Command0_Option7_Text; 

extern char Command1_Option0_Text; 
extern char Command1_Option1_Text; 
extern char Command1_Option2_Text; 
extern char Command1_Option3_Text; 
extern char Command1_Option4_Text; 
extern char Command1_Option5_Text; 
extern char Command1_Option6_Text; 
extern char Command1_Option7_Text; 

extern char Command2_Option0_Text; 
extern char Command2_Option1_Text; 
extern char Command2_Option2_Text; 
extern char Command2_Option3_Text; 
extern char Command2_Option4_Text; 
extern char Command2_Option5_Text; 
extern char Command2_Option6_Text; 
extern char Command2_Option7_Text; 

extern char Command3_Option0_Text; 
extern char Command3_Option1_Text; 
extern char Command3_Option2_Text; 
extern char Command3_Option3_Text; 
extern char Command3_Option4_Text; 
extern char Command3_Option5_Text; 
extern char Command3_Option6_Text; 
extern char Command3_Option7_Text; 

extern char Command4_Option0_Text; 
extern char Command4_Option1_Text; 
extern char Command4_Option2_Text; 
extern char Command4_Option3_Text; 
extern char Command4_Option4_Text; 
extern char Command4_Option5_Text; 
extern char Command4_Option6_Text; 
extern char Command4_Option7_Text; 

extern char Command5_Option0_Text; 
extern char Command5_Option1_Text; 
extern char Command5_Option2_Text; 
extern char Command5_Option3_Text; 
extern char Command5_Option4_Text; 
extern char Command5_Option5_Text; 
extern char Command5_Option6_Text; 
extern char Command5_Option7_Text; 

extern char Command6_Option0_Text; 
extern char Command6_Option1_Text; 
extern char Command6_Option2_Text; 
extern char Command6_Option3_Text; 
extern char Command6_Option4_Text; 
extern char Command6_Option5_Text; 
extern char Command6_Option6_Text; 
extern char Command6_Option7_Text; 

extern char Command7_Option0_Text; 
extern char Command7_Option1_Text; 
extern char Command7_Option2_Text; 
extern char Command7_Option3_Text; 
extern char Command7_Option4_Text; 
extern char Command7_Option5_Text; 
extern char Command7_Option6_Text; 
extern char Command7_Option7_Text; 


void updateOptionsPage(OptionsProc* CurrentProc) {

	//clear bg font buffers
	Text_ResetTileAllocation();
	// ClearBG0BG1();
	BG_Fill((u16*)BG0Buffer, 0);
	EnableBgSyncByIndex(0);
	//Print Headings
	char* string = &Title_Text; 
	DrawTextInline(0, BGLoc(BG0Buffer, 2, 0), 4, 0, (Text_GetStringTextWidth(string)+8)/8, string);
	//DrawTextInline(0, BGLoc(BG0Buffer, 19, 0), 4, 0, 8, "<< L/R >>");
	int i = 0; 

	
	if (thisPage == 1){
		//option names
		string = &OptionsCommand0_Text;
		DrawTextInline(0, BGLoc(BG0Buffer, 2, 3), 3, 0, (Text_GetStringTextWidth(string)+8)/8, string);
		
		string = &OptionsCommand1_Text;
		DrawTextInline(0, BGLoc(BG0Buffer, 2, 5), 3, 0, (Text_GetStringTextWidth(string)+8)/8, string);
		string = &OptionsCommand2_Text;
		DrawTextInline(0, BGLoc(BG0Buffer, 2, 7), 3, 0, (Text_GetStringTextWidth(string)+8)/8, string);
		string = &OptionsCommand3_Text;
		DrawTextInline(0, BGLoc(BG0Buffer, 2, 9), 3, 0, (Text_GetStringTextWidth(string)+8)/8, string);
		string = &OptionsCommand4_Text;
		DrawTextInline(0, BGLoc(BG0Buffer, 2, 11), 3, 0, (Text_GetStringTextWidth(string)+8)/8, string);
		string = &OptionsCommand5_Text;
		DrawTextInline(0, BGLoc(BG0Buffer, 2, 13), 3, 0, (Text_GetStringTextWidth(string)+8)/8, string);
		string = &OptionsCommand6_Text;
		DrawTextInline(0, BGLoc(BG0Buffer, 2, 15), 3, 0, (Text_GetStringTextWidth(string)+8)/8, string);
		string = &OptionsCommand7_Text;
		DrawTextInline(0, BGLoc(BG0Buffer, 2, 17), 3, 0, (Text_GetStringTextWidth(string)+8)/8, string);


		//option values
		
		i = 0; 
		switch (CurrentProc->Option[i]) { 
			case 0: { 
			string = &Command0_Option0_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 1: { 
			string = &Command0_Option1_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 2: { 
			string = &Command0_Option2_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 3: { 
			string = &Command0_Option3_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 4: { 
			string = &Command0_Option4_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 5: { 
			string = &Command0_Option5_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 6: { 
			string = &Command0_Option6_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 7: { 
			string = &Command0_Option7_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			default: { 
			string = "N/A";
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } break; 
		} 
		
		
		
		i = 1; 
		switch (CurrentProc->Option[i]) { 
			case 0: { 
			string = &Command1_Option0_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 1: { 
			string = &Command1_Option1_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 2: { 
			string = &Command1_Option2_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 3: { 
			string = &Command1_Option3_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 4: { 
			string = &Command1_Option4_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 5: { 
			string = &Command1_Option5_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 6: { 
			string = &Command1_Option6_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 7: { 
			string = &Command1_Option7_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			default: { 
			string = "N/A";
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } break; 
		} 
		
		
		i = 2; 
		switch (CurrentProc->Option[i]) { 
			case 0: { 
			string = &Command2_Option0_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 1: { 
			string = &Command2_Option1_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 2: { 
			string = &Command2_Option2_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 3: { 
			string = &Command2_Option3_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 4: { 
			string = &Command2_Option4_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 5: { 
			string = &Command2_Option5_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 6: { 
			string = &Command2_Option6_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 7: { 
			string = &Command2_Option7_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			default: { 
			string = "N/A";
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } break; 
		} 
		
		i = 3; 
		switch (CurrentProc->Option[i]) { 
			case 0: { 
			string = &Command3_Option0_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 1: { 
			string = &Command3_Option1_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 2: { 
			string = &Command3_Option2_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 3: { 
			string = &Command3_Option3_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 4: { 
			string = &Command3_Option4_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 5: { 
			string = &Command3_Option5_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 6: { 
			string = &Command3_Option6_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 7: { 
			string = &Command3_Option7_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			default: { 
			string = "N/A";
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } break; 
		} 
		i = 4; 
		switch (CurrentProc->Option[i]) { 
			case 0: { 
			string = &Command4_Option0_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 1: { 
			string = &Command4_Option1_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 2: { 
			string = &Command4_Option2_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 3: { 
			string = &Command4_Option3_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 4: { 
			string = &Command4_Option4_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 5: { 
			string = &Command4_Option5_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 6: { 
			string = &Command4_Option6_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 7: { 
			string = &Command4_Option7_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			default: { 
			string = "N/A";
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } break; 
		}  
		i = 5; 
		switch (CurrentProc->Option[i]) { 
			case 0: { 
			string = &Command5_Option0_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 1: { 
			string = &Command5_Option1_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 2: { 
			string = &Command5_Option2_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 3: { 
			string = &Command5_Option3_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 4: { 
			string = &Command5_Option4_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 5: { 
			string = &Command5_Option5_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 6: { 
			string = &Command5_Option6_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 7: { 
			string = &Command5_Option7_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			default: { 
			string = "N/A";
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } break; 
		} 
		i = 6; 
		switch (CurrentProc->Option[i]) { 
			case 0: { 
			string = &Command6_Option0_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 1: { 
			string = &Command6_Option1_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 2: { 
			string = &Command6_Option2_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 3: { 
			string = &Command6_Option3_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 4: { 
			string = &Command6_Option4_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 5: { 
			string = &Command6_Option5_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 6: { 
			string = &Command6_Option6_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 7: { 
			string = &Command6_Option7_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			default: { 
			string = "N/A";
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } break; 
		} 
		i = 7; 
		switch (CurrentProc->Option[i]) { 
			case 0: { 
			string = &Command7_Option0_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 1: { 
			string = &Command7_Option1_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 2: { 
			string = &Command7_Option2_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 3: { 
			string = &Command7_Option3_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 4: { 
			string = &Command7_Option4_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 5: { 
			string = &Command7_Option5_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 6: { 
			string = &Command7_Option6_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			case 7: { 
			string = &Command7_Option7_Text;
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } 
			default: { 
			string = "N/A";
			DrawTextInline(0, BGLoc(BG0Buffer, 15, (3+(i*2))), 2, 0, (Text_GetStringTextWidth(string)+8)/8, string); break; } break; 
		} 
		
		
		/*
		//now we get to do it all again, but for description text :/
		switch (CurrentProc->CursorIndex) {			
			case 0: { 
				switch (CurrentProc->Option[0]) { 
					case 0: {
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 13), 0, 0, 12, "Units die when they");
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 15), 0, 0, 10, "fall in battle.");
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 17), 0, 0, 10, "sucks for them."); break; } 
					case 1: {
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 13), 0, 0, 13, "Units retreat when");
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 15), 0, 0, 10, "they fall in battle."); break; } break; } break; }
			 
			case 1: { 
				switch (CurrentProc->Option[1]) { 
					case 0: {
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 13), 0, 0, 12, "Units die when they");
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 15), 0, 0, 10, "fall in battle.");
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 17), 0, 0, 10, "sucks for them."); break; } 
					case 1: {
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 13), 0, 0, 13, "Units retreat when");
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 15), 0, 0, 10, "they fall in battle."); break; } break; } break; }
			 
			case 2: { 
				switch (CurrentProc->Option[2]) { 
					case 0: {
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 13), 0, 0, 12, "Units die when they");
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 15), 0, 0, 10, "fall in battle.");
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 17), 0, 0, 10, "sucks for them."); break; } 
					case 1: {
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 13), 0, 0, 13, "Units retreat when");
						DrawTextInline(0, BGLoc(BG0Buffer, 2, 15), 0, 0, 10, "they fall in battle."); break; } break; } break; }
			 
			
			
		break;
		} 
		*/
			 
		
		 


		
		
	}
	
 };
 
void SaveOptionsData(void* target, unsigned size) {
	WriteAndVerifySramFast(&OptionsSaved, target, size);
}

void LoadOptionsData(void* source, unsigned size) {
	ReadSramFast(source, (void*)&OptionsSaved, size);
}

extern u16 OptionsToFlagsList[]; 

u16* GetOptionsToFlagData(int commandID) { 

	u16* data = &OptionsToFlagsList[0];
	if (commandID == 0) { 
		data++; // 0th entry is immediately after the ID 
		return data; 
	}
	
	while (*data != 0xFEDC) { 
		data++; 
		if (*data == 0xFFFF) { 
			data++; // we want the entry immediately after SHORT 0xFFFF 
			if (*data == commandID) { 
				data++; // we also want to ignore the SHORT commandID 
				return data; 
			} 
		} 
	
	} 
	return NULL; 
	

} 
extern struct ProcCode* ProcScr_StdEventEngine; // map event engine proc

extern u8 gPermanentFlagBits[];
void CallResetPermanentFlags(void) {
    int i;

    for (i = 0; i < 25; i++) {
        gPermanentFlagBits[i] = 0;
    }

    return;
}

extern struct ProcCode* ProcScr_BmFadeOUT; // save screen fade out 
void SaveStartingOptionsLoop(OptionsSavedProc* CurrentProc){
	CurrentProc->timer++; 
	OptionsProc* proc = (void*)ProcFind((void*)&StartingOptionsProc); 
	if (proc) { 
		for (int commandID = 0; commandID < PAGE1MAXINDEX; commandID++) { 
			u16* data = GetOptionsToFlagData(commandID);
			//asm("mov r11, r11"); 
			if (data) CurrentProc->FlagOn[commandID] = data[proc->Option[commandID]]; 
		} 
		return; 
	} 
	
	Proc* saveFadeOut = (void*)ProcFind((void*)&ProcScr_BmFadeOUT);
	if (saveFadeOut) { 
		//asm("mov r11, r11"); 
		CallResetPermanentFlags(); 
		// save flags and kill proc 
		int flag = 0; 
		for (int i = 0; i < 21; i++) { 
			flag = CurrentProc->FlagOn[i]; 
			if (flag > 0) { SetEventId(flag); } 
		} 
		SetGameTime(CurrentProc->timer);
		//int slot = gChapterData.saveSlotIndex; 
		
		BreakProcLoop((void*)CurrentProc); 
		//when event engine runs, save to file? 
	} 

	return; 
	
} 

void StartingOptionsLoop(OptionsProc* CurrentProc){

	//make snowflakes white
	*(u32*) 0x5000262 = 0x739eFFFF; //fill in the only obj palette colour that matters lol
	
	
	//if (CurrentProc->CursorIndex != CurrentProc->LastCursorIndex) updateOptionsPage(CurrentProc);
	//CurrentProc->LastCursorIndex = CurrentProc->CursorIndex;
	
	// UpdateBG3HOffset();
	UpdateHandCursor(CursorLocationTable[CurrentProc->CursorIndex].x, CursorLocationTable[CurrentProc->CursorIndex].y);	
	if ((newInput & InputStart)||(newInput & InputA)) { //press A or Start to continue
		BreakProcLoop((Proc *)CurrentProc);
		m4aSongNumStart(0x6B); 
	};


  if (thisPage == 1) {
    if ((newInput & InputDown) != 0) {
      if (CurrentProc->CursorIndex < PAGE1MAXINDEX) { CurrentProc->CursorIndex++; }
      else { CurrentProc->CursorIndex = 0; } 
	  updateOptionsPage(CurrentProc);
    }
    if ((newInput & InputUp) != 0) {
      if (CurrentProc->CursorIndex != 0) { CurrentProc->CursorIndex--; }
      else { CurrentProc->CursorIndex = PAGE1MAXINDEX; }
	  updateOptionsPage(CurrentProc);
    }

	if (newInput & InputLeft) {
		CurrentProc->Option[CurrentProc->CursorIndex]--;
		if (CurrentProc->Option[CurrentProc->CursorIndex] < 0) { 
			CurrentProc->Option[CurrentProc->CursorIndex] = NumberOfOptionsPerEntryTable[CurrentProc->CursorIndex] - 1;
		} 
		updateOptionsPage(CurrentProc);
	} 
	if (newInput & InputRight) {
		CurrentProc->Option[CurrentProc->CursorIndex]++;
		if (CurrentProc->Option[CurrentProc->CursorIndex] >= NumberOfOptionsPerEntryTable[CurrentProc->CursorIndex]) { 
			CurrentProc->Option[CurrentProc->CursorIndex] = 0;
		} 
		updateOptionsPage(CurrentProc);
	}
  }


};



