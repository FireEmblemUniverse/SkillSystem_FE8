
#include "Ai.h" 


// can break at start and end of 8039858 CpOrderFunc_BeginDecide to see how much lag there is 
// see https://github.com/FireEmblemUniverse/fireemblem8u/blob/b9ad9bcafd9d4ecb7fc13cc77a464e2a82ac8338/src/cp_decide.c#L71
// CpDecideMain at 8039B00 
// AiTryDoOffensiveAction 0x803D450 - 0x803D880 
// AiTryMoveTowards 0x803BA08 
// if these function are optimized, the ai will be faster 

// in proc gProcScr_CpPerform it calls CpPerform_803A63C
// which calls AiRefreshMap(); which calls 
//  RefreshEntityBmMaps(); RenderBmMap(); and RefreshUnitSprites();
// Therefore we only need them to be called before the first unit 
// so we'll add them to CpOrder_BuildUnitList at 0x8039858 

// time between 8037744 HandlePostActionTraps and 8039F0C CpPerform_MoveCameraOntoUnit: 11.8m - 18.8m cycles or 36-56 frames 
// after cmb window disappears, 21 frames until greyed out 
// then 51 frames until next unit starts moving 

// 2m cycles on 59D908 MapTask (weather?) 
// does AiDecideMain at 39CAC which calls NewAiAttemptOffensiveAction which can take 11m cycles 

// 17 frames spent between battle on 0x802A398 

void CpOrderFunc_BeginDecide(ProcPtr proc)
{
	asm("mov r11, r11");
    int unitAmt = BuildAiUnitList();

    if (unitAmt != 0)
    {
        SortAiUnitList(unitAmt);

        gAiState.units[unitAmt] = 0;
        gAiState.unitIt = gAiState.units;

        AiDecideMainFunc = AiDecideMain;
        RefreshEntityBmMaps(); 
        RenderBmMap();
        RefreshUnitSprites();

        Proc_StartBlocking(gProcScr_CpDecide, proc);
    }
	asm("mov r11, r11");
}

/*
void NewCpDecide_Main(ProcPtr proc)
//void CpDecide_Main(ProcPtr proc)
{
	//asm("mov r11, r11"); 

next_unit:
    gAiState.decideState = 0;

    if (*gAiState.unitIt)
    {
        gAiState.unk7C = 0;

        gActiveUnitId = *gAiState.unitIt;
        gActiveUnit = GetUnit(gActiveUnitId);

        if (gActiveUnit->state & (US_DEAD | US_UNSELECTABLE) || !gActiveUnit->pCharacterData)
        {
            gAiState.unitIt++;
            goto next_unit;
        }

        do
        {
			// These 3 add some lag - maybe they can be done conditionally?
            //RefreshEntityBmMaps(); 
            //RenderBmMap();
            //RefreshUnitSprites();

            AiUpdateNoMoveFlag(gActiveUnit);

            gAiState.combatWeightTableId = (gActiveUnit->ai3And4 & 0xF8) >> 3;

            gAiState.dangerMapFilled = FALSE;
            AiInitDangerMap(); // This causes some lag (but has been optimized) 

            AiClearDecision();
			//asm("mov r11, r11"); 
            AiDecideMainFunc();  // Lag from ai scripts eg. 
				// AiTryDoOffensiveAction 0x803D450
				// AiTryMoveTowards 0x803BA08 
*/
/* 
// Try each AI until one is accepted 
static DecideFunc CONST_DATA sDecideFuncList[] =
{
    DecideHealOrEscape,
    DecideScriptA,
    DecideScriptB,
    DecideSpecialItems,
    NULL, NULL,
};

void AiDecideMain(void)
{
    while (sDecideFuncList[gAiState.decideState] && !gAiDecision.actionPerformed)
    {
        sDecideFuncList[gAiState.decideState++]();
    }
}
*/
/*
            gActiveUnit->state |= US_HAS_MOVED_AI;

            if (!gAiDecision.actionPerformed ||
                (gActiveUnit->xPos == gAiDecision.xMove && gActiveUnit->yPos == gAiDecision.yMove && gAiDecision.actionId == AI_ACTION_NONE))
            {
                // Ignoring actions that are just moving to the same square

                gAiState.unitIt++;
                //Proc_Goto(proc, 0);
				goto next_unit; // maybe faster? 
            }
            else
            {
                gAiState.unitIt++;
				//asm("mov r11, r11"); 
                Proc_StartBlocking(gProcScr_CpPerform, proc);
            }
        } while (0);
    }
    else
    {
        Proc_End(proc);
    }
}
*/








