
.macro fun value, name
    .global \name
    .type \name, function
    .set \name, \value
.endm

.macro dat value, name
    .global \name
    .type \name, object
    .set \name, \value
.endm

@ NewSkillTester
fun 0x02026BB0, gAttackerSkillBuffer
fun 0x02026C00, gDefenderSkillBuffer 
fun 0x02026B90, gTempSkillBuffer     
fun 0x02027200, gAuraSkillBuffer     
fun 0x0202764C, gUnitRangeBuffer     

@ CheckBattleUnitLevelUp
fun 0x08017AB8, classTablePoin

@ PopupRework
fun 0x0878D518, gAnimScr_PopupIcon 
fun 0x08803B30, gGfx_BattlePopup 
fun 0x08803CB0, gPal_BattlePopup
fun 0x08803BD0, gGfx_BattlePopupTextBg 
fun 0x02019790, gSpellFxTsaBuffer 
fun 0x08803CD0, gTsa_BattlePopup 
fun 0x08071991, SomeBattlePlaySound_8071990 
fun 0x0203E18C, gpUnitRight_BattleStruct 
fun 0x0203E188, gpUnitLeft_BattleStruct 
