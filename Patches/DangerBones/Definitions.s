

.if FE8 == true 
.include "fe8.s" 
.endif 

.macro SET_FUNC name, value
	.global \name
	.type   \name, function
	.set    \name, \value
.endm

.macro SET_DATA name, value
	.global \name
	.type   \name, object
	.set    \name, \value
.endm




.if FE6 == true 

.global strlen 
.type strlen, %function 
strlen: 
@mov r11, r11 
mov r2, #0 
loop_strlen:
ldrb r1, [r0, r2]
add r2, #1  
cmp r1, #0 
bne loop_strlen 
sub r2, #1 
mov r0, r2 
bx lr 


SET_FUNC GetPidStats, 0x8084F4D
SET_FUNC ReadGlobalSaveInfo, 0x80842E9
SET_FUNC StartBgmExt, 0x809C8D9
SET_DATA getSoundRoom, 0x808b9c4
SET_DATA getSongTable, 0x8039170
SET_FUNC UpdateMapViewWithFog, 0x801C6C5
SET_DATA gVision, 0x202AA48+0x0D
@SET_FUNC GetItemAttributes, fe7 0x801727c unk fe6 
SET_FUNC GetItemAfterUse, 0x8016929 
SET_FUNC FadeExists, 0x80145d1
SET_DATA ProcScr_PrepUnitScreen, 0x8678E38
SET_DATA gPaletteSyncFlag, 0x300000C
SET_DATA gPaletteBuffer, 0x2021708
SET_DATA gCursorX, 0x202AA1C
SET_DATA gCursorY, 0x202AA1E
SET_DATA BattleAttackerSideBool, 0x203CCFE
SET_DATA gProcScr_StatScreen, 0x8677680
SET_DATA gProc_ekrBattleDeamon, 0x85CB508
SET_DATA gProcScr_UnitDisplay_MinimugBox, 0x86781D4
SET_DATA sFaceConfig, 0x20293E4
SET_DATA gFaces, 0x3004000
SET_DATA gBattleActorUnit, 0x2039214  
SET_DATA gBattleActor, 0x2039214  
SET_DATA gBattleTargetUnit, 0x2039290
SET_DATA gBattleTarget, 0x2039290
SET_FUNC StartGreenText, 0x8006C9D
SET_FUNC UnpackUiVArrowGfx, 0x809777D
SET_FUNC DisplayUiVArrow, 0x80977C1
SET_FUNC GetUnit, 0x801860D
SET_FUNC GetUnitPortraitId, 0x80184F1
SET_FUNC memset, 0x0809F9F1
SET_DATA SaveMenuProc, 0x0 @ fe6
SET_DATA DifficultySelectionProc, 0x868A09C @ fe6
SET_FUNC SaveMenuStartBlockingProc, 0x8089551 @ fe6 
SET_FUNC SetupBackgrounds, 0x80026BD
SET_FUNC RegisterBlankTile, 0x8001581
SET_FUNC GetStringFromIndex, 0x8013ad1
SET_FUNC GetTextDrawDest, 0x8006009
SET_DATA gActiveFont, 0x2027BCC
SET_DATA gDefaultFont, 0x2027BB4
SET_DATA sSpecialCharStList, 0x2027BD0
SET_DATA gBmSt, 0x202AA08
SET_DATA gCameraX, 0x202AA14
SET_DATA gCameraY, 0x202AA16
SET_DATA gObject_8x8, 0x85c39A0 
SET_FUNC IsItemStealable, 0x8016D35
SET_FUNC CallARM_PushToSecondaryOAM, 0x8003871
SET_FUNC GetUnitAid, 0x80180FD
SET_FUNC SetPopupNumber, 0x800d705 
SET_FUNC GetPartyGoldAmount, 0x8020a59
SET_FUNC SetPartyGoldAmount, 0x8020a65
SET_FUNC NewPopup_Simple, 0x800d721 
SET_DATA PopupScr_GotGold, 0x8356140
SET_DATA PopupScr_GoldWasStole, 0x8356188
SET_FUNC NewPopup_GoldGot, 0x80120D1 
SET_FUNC NextRN_N, 0x8000E09
SET_FUNC GenerateExtendedMovementMap, 0x8019425
SET_DATA TerrainTable_MovCost_BerserkerNormal, 0x860C714
SET_DATA TerrainTable_MovCost_BerserkerRain, 0x860C714
SET_DATA gPhase, 0x202AA57
SET_DATA gTurn, 0x202AA58
SET_DATA gSfx, 0x202AA65
SET_FUNC StartBgm, 0x8003211
SET_FUNC GetCurrentBgmSong, 0x8002F69
SET_FUNC GetCurrentMapMusicIndex, 0x801637D
SET_FUNC Sound_FadeOutBGM, 0x8003065
SET_FUNC PhaseIntroInitText, 0x801D03D
SET_FUNC StartBgmExt, 0x800322D
SET_FUNC StartMapSongBgm, 0x80163E5
SET_FUNC EndAllMenus, 0x8041A39
SET_FUNC RenderBmMap, 0x8018D91
SET_FUNC RefreshBMapGraphics, 0x80292dd
SET_FUNC Text_SetCursor, 0x80059e1 
SET_FUNC Text_SetColor, 0x8005a39
SET_FUNC Text_DrawStringAscii, 0x80064b5
SET_FUNC PutText, 0x8005ab5
SET_FUNC GetLang, 0x800562d
SET_FUNC GetStringFromIndex, 0x8013AD1 
SET_DATA sActiveMsg, 0x202A404 
SET_DATA sMsgString, 0x2029404 
SET_DATA u32MsgString, 0x2029404 
SET_FUNC gARM_DecompText, 0x3003780
SET_FUNC CallARM_DecompText, 0x800384d 
SET_DATA gPrepUnitList, 0x200e6d4
SET_DATA ProcScr_PalFade, 0x85C4D7C
SET_DATA ProcScr_FadeCore, 0x85C4E14
SET_DATA ProcScr_BmFadeIN, 0x8679008 
SET_DATA ProcScr_BmFadeOUT, 0x8679028 
SET_FUNC HbPopulate_SSCharacter, 0x80704DD
SET_DATA ggMsgStringTable, 0x8013b10
SET_FUNC GetChapterEventDataPointer, 0x802BBA1
SET_FUNC GetUnitFromCharId, 0x8017ABD
SET_FUNC GetUnitRescueName, 0x80185C9
SET_FUNC Text_InsertDrawString, 0x8006455
SET_FUNC LoadUnit, 0x8017599
SET_FUNC ClearUnit, 0x8017395
SET_FUNC ArenaIsUnitAllowed, 0x8029FE1
SET_FUNC GetUnitBestWRankType, 0x8029965
SET_DATA gProcScr_ArenaUiMain, 0x86911AC
SET_FUNC SetupDebugFontForOBJ, 0x8005471
SET_FUNC PrintDebugStringAsOBJ, 0x8005551
SET_FUNC GetPortraitData, 0x8007fc1
SET_FUNC GetStringTextLen, 0x8005b95
SET_FUNC PutFaceTm, 0x8008729 @ maybe ? 
SET_FUNC ResetFaces, 0x8008001
@SET_FUNC GetStringTextCenteredPos, 0x80056A9
@SET_FUNC EnablePaletteSync, 
@SET_DATA sUnknown_085911C4, 0x80059C8
SET_FUNC StartFace2, 0x800830D @ really StartFace 
SET_FUNC CpuFastSet, 0x809DCD9
SET_FUNC CopyToPaletteBuffer, 0x800105D
SET_FUNC RegisterDataMove, 0x8002B05
SET_FUNC EndFaceById, 0x8008581

SET_FUNC MU_EndAll, 0x80608D5 
SET_FUNC HideUnitSprite, 0x8022A39
SET_FUNC MU_Exists, 0x800C2C9
SET_FUNC MU_SetDefaultFacing_Auto, 0x805FC55
SET_FUNC MU_Create, 0x805F875
@SET_FUNC MenuAutoHelpBoxSelect, 0x804a9D5
SET_FUNC StartOrphanMenuAdjusted, 0x80417E9
SET_FUNC SetAllUnitNotBackSprite, 0x801809D
SET_DATA gActiveUnitMoveOrigin, 0x202AB74 
SET_DATA gActiveUnitId, 0x202AB70
SET_DATA gActionData, 0x203956C
SET_FUNC EnsureCameraOntoPosition, 0x80161C1
SET_FUNC SetCursorMapPosition, 0x801600D
SET_FUNC HideMoveRangeGraphics, 0x801C061
SET_FUNC RefreshEntityBmMaps, 0x80190F5
SET_FUNC RefreshUnitSprites, 0x8022095
@SET_FUNC NewBMXFADE, 0x801C39D
SET_FUNC DoesBMXFADEExist, 0x8093445
SET_FUNC Proc_End, 0x8004265
SET_FUNC HandlePlayerCursorMovement, 0x801B04D
SET_FUNC IsUnitSpriteHoverEnabledAt, 0x8022725
SET_FUNC PutMapCursor, 0x8015F1D
SET_FUNC Text_DrawString, 0x8005da5
@ PlayerPhase_ApplyUnitMovement 1BAF0 
SET_FUNC UnitFinalizeMovement, 0x8017C61
SET_FUNC ResetUnitSpriteHover, 0x8022629
SET_FUNC sub_802C334, 0x8025781
SET_DATA gProcScr_TerrainDisplay, 0x8678174
SET_DATA gProcScr_PlayerPhase, 0x85C56A8
SET_DATA gKeyStatusPtr, 0x858E578
SET_DATA gUnknown_08A02274, 0x83080D0

SET_DATA sMutableHbi, 0x0203D3E0 @ in StartHelpBox 
SET_DATA sLastHbi, 0x203D3FC 
SET_DATA sHbOrigin, 0x203D400 @ in StartHelpBox 

SET_DATA gHelpBoxSt, 0x203D40C
SET_DATA gProcScr_HelpBox, 0x8677720  @ StartHelpBox
SET_DATA ProcScr_HelpBoxIntro, 0x8677FF8 @ StartHelpBox
SET_FUNC ApplyHelpBoxContentSize, 0x8070a31
@SET_FUNC StringInsertSpecialPrefixByCtrl, 0x8012CBD
SET_FUNC GetHelpBoxItemInfoKind, 0x8070b31
SET_FUNC LoadHelpBoxGfx, 0x8070E71
SET_FUNC SpriteText_DrawBackground, 0x80066f9
SET_FUNC GetStringTextBox, 0x8005D05
SET_FUNC ApplyHelpBoxPosition, 0x8070A71
SET_FUNC SetHelpBoxInitPosition, 0x8070AFD
SET_FUNC ResetHelpBoxInitSize, 0x8070B21
SET_FUNC CloseHelpBox, 0x807089D
SET_FUNC HelpBoxSetupstringLines, 0x08071375 @ ? 
SET_FUNC HelpBoxDrawstring, 0x080713dd @? 
SET_FUNC HelpBoxIntroDrawTexts, 0x8071411
SET_DATA gProcScr_HelpBoxTextScroll, 0x8677FD0
SET_FUNC UnpackUiWindowFrameImg2, 0x8041309
SET_FUNC ApplyUiWindowFramePal, 0x8041285
SET_FUNC SetBackgroundTileDataOffset, 0x8001351
SET_FUNC SetPrimaryHBlankHandler, 0x8002A29
SET_FUNC PidStatsAddActAmt, 0x8084b85 
SET_FUNC PidStatsAddStatViewAmt, 0x8084bb9 
SET_FUNC PidStatsAddDeployAmt, 0x8084bed
SET_FUNC PidStatsAddSquaresMoved, 0x8084c31 
SET_FUNC PidStatsAddExpGained, 0x8084c85 
@ 08084cd8 T PidStatsCountTotalBattles	/Users/laqieer/Projects/FEHRR/include/decomp/src/save_stats.c:282
@ 08084cfc T PidStatsCountTotalWins	/Users/laqieer/Projects/FEHRR/include/decomp/src/save_stats.c:292
@ 08084d1c T PidStatsCountTotalLosses	/Users/laqieer/Projects/FEHRR/include/decomp/src/save_stats.c:302
SET_FUNC PidStatsGetTotalLevel, 0x8084d35 
@ 08084d64 T PidStatsUpdateFromBattleOutcome	/Users/laqieer/Projects/FEHRR/include/decomp/src/save_stats.c:322
SET_FUNC SetupMapSpritesPalettes, 0x8021B99 
SET_FUNC ResetUnitSprites, 0x8021BD1 
SET_FUNC ResetUnitSpriteHover, 0x8022629  
SET_FUNC ForceSyncUnitSpriteSheet, 0x8021FE9   
SET_FUNC PutBlendWindowUnitSprite, 0x8022941 
SET_FUNC UseUnitSprite, 0x8021C39 
SET_FUNC func_fe6_08022A2C, 0x8022A2D 
SET_FUNC ReadLastGameSaveId, 0x8084f95  
SET_FUNC ReadGameSave, 0x80851b5  
SET_FUNC CpuSet, 0x809DCDD 
SET_FUNC WriteGlobalSaveInfoNoChecksum, 0x8084389  

SET_FUNC RenderBmMapOnBg2, 0x8018E11 
SET_FUNC MoveActiveUnit, 0x801BAF1
SET_FUNC NewBMXFADE, 0x801C39D
SET_FUNC HandlePostActionTraps, 0x80273BD
SET_FUNC RunPotentialWaitEvents, 0x801B9B1
SET_FUNC EnsureCameraOntoActiveUnitPosition, 0x801B9CD
@SET_FUNC StartBmPromotion, 0x802529D @ UnitPromote ?? 
SET_FUNC StartBmPromotion, 0x08027ccd
SET_FUNC StartArenaScreen, 0x8097e85
SET_FUNC GetUnitEquippedWeapon, 0x8016959
SET_FUNC InitBattleUnit, 0x80243F9
SET_FUNC SetupMapBattleAnim, 0x8062891
SET_FUNC UnitBeginAction, 0x8017df9
SET_DATA gProcScr_CamMove, 0x85c5234 
SET_DATA gManimSt, 0x203cde4 @ from MapAnimProc_DisplayExpBar
SET_DATA gBattleHitArray, 0x203930C  @ from SetupMapBattleAnim 

@ ProcScr_BattleManim 664DA4 
@ ProcScr_EndManim 664E4C @ https://github.com/FireEmblemUniverse/fireemblem6j/blob/c0065f139f1cbe2aa974046448898427ecc5a021/src/manim.c#L159

SET_FUNC BattleEventEngineExists, 0x8011f71
SET_FUNC DeleteBattleAnimInfoThing, 0x8062cf1
SET_FUNC MapAnimProc_DisplayExpBar, 0x8061d01
SET_FUNC MapAnim_MoveCameraOntoSubject, 0x8061B81
SET_FUNC MapAnim_Cleanup, 0x80619b1
SET_FUNC UpdateActorFromBattle, 0x80254CD @ BattleApplyUnitUpdates
SET_FUNC ReadSramFast, 0x3006640
SET_FUNC WriteAndVerifySramFast, 0x809DE9D 
SET_FUNC RegisterDataMove, 0x8002B05 
SET_DATA gFrameTmRegisterConfig, 0x2023B34
SET_DATA gFrameTmRegister, 0x2023B3C 
SET_DATA SRRBuffer, 0x2025B8C	@ normally used by debug printing 


SET_DATA gBmMapSize, 0x202D200
SET_DATA gBmMapUnit, 0x202D204
SET_DATA gBmMapTerrain, 0x202D208 
SET_DATA gBmMapMovement, 0x202D20C
SET_DATA gBmMapRange, 0x202D210 
SET_DATA gBmMapFog, 0x202D214 
SET_DATA gBmMapTrick, 0x202d218 
SET_DATA gBmMapOther, 0x202d21c 
SET_FUNC SetLastCoords, 0x802a861
SET_FUNC SetWorkingBmMap, 0x801A559
SET_FUNC BmMapFill, 0x8018961
SET_FUNC GenerateUnitMovementMap, 0x8019345 @ "MapFlood_UpToMove" 
SET_FUNC GenerateUnitCompleteAttackRange, 0x8019B39  
SET_FUNC MuExists 0x805FCB5 
SET_FUNC GetUnitDisplayedSpritePalette_FE6, 0x8022049
SET_FUNC GetUnitSpritePalette, 0x08022065
SET_FUNC GenerateUnitStandingReachRange, 0x801a211 
SET_FUNC GetUnitWeaponReachBits, 0x8016EAD


SET_DATA DangerBonesBuffer, 0x20099c0	@ size: 0x3A18+ gBanimOamr2 - b anims free to 200d3e0 B gSortedUnitsBuf
SET_DATA DangerBonesPalBuffer, 0x200c130	@ size: 0x3A18+ gBanimOamr2 - b anims free to 200d3e0 B gSortedUnitsBuf
@ smaller free ram in fe6 
@SET_DATA DangerBonesBuffer,    0x201C8BC @ gTmA_Banim from sub_80559B0 at 8047C4C
@ 201F0E8 gGenericBuffer ?? 8085F4C SramChecksum32 
@SET_DATA DangerBonesPalBuffer, 0x201f12c@ 8 bytes at the end gTmA_Banim from sub_80559B0 at 8047C4C

.endif     
.if FE7 == true 
SET_FUNC GetUnitWeaponReachBits, 0x8016EbD 
SET_FUNC MuExists, 0x806C041 
@SET_DATA DangerBonesBuffer, 0x201C8C4 @ gTmA_Banim from sub_80559B0 at 8050798
SET_DATA DangerBonesBuffer, 0x20099c8	@ size: 0x3A18+ gBanimOamr2 - b anims free to 200d3e0 B gSortedUnitsBuf
SET_FUNC GenerateUnitCompleteAttackRange, 0x801A4D5  
SET_FUNC GenerateUnitStandingReachRange, 0x801AC61 
SET_FUNC GenerateUnitMovementMap, 0x8019BA1 
SET_FUNC BmMapFill, 0x80190AD
SET_FUNC SetWorkingBmMap, 0x801B191
SET_FUNC SetLastCoords, 0x802fab9 

SET_DATA gBmMapSize, 0x202E3D8
SET_DATA gBmMapUnit, 0x202E3DC
SET_DATA gBmMapTerrain, 0x202E3E0
SET_DATA gBmMapMovement, 0x202e3e4 
SET_DATA gBmMapRange, 0x202e3e8 
SET_DATA gBmMapFog, 0x202e3ec 
SET_DATA gBmMapTrick, 0x202e3f0 
SET_DATA gBmMapOther, 0x202e3f4 

SET_DATA gFrameTmRegisterConfig, 0x2024C94  
SET_DATA gFrameTmRegister, 0x2024C9C 
SET_FUNC RegisterDataMove, 0x8003079
SET_FUNC ReadSramFast, 0x3005E70  
SET_FUNC WriteAndVerifySramFast, 0x80BFBD9  

SET_FUNC RenderBmMapOnBg2, 0x8019585  
SET_FUNC MoveActiveUnit, 0x801CDBD 
SET_FUNC NewBMXFADE, 0x8082015
SET_FUNC HandlePostActionTraps, 0x8034521
SET_FUNC RunPotentialWaitEvents, 0x801CC4D
SET_FUNC EnsureCameraOntoActiveUnitPosition, 0x801CC69
SET_FUNC StartBmPromotion, 0x0802cc69 
SET_FUNC StartArenaScreen, 0x80b267D
SET_FUNC GetUnitEquippedWeapon, 0x8016765
SET_FUNC InitBattleUnit, 0x80285D5
SET_FUNC SetupMapBattleAnim, 0x806F30D
SET_FUNC UnitBeginAction, 0x80180ED 
SET_DATA gProcScr_CamMove, 0x8B92E38 
SET_DATA gManimSt, 0x203e0fc @ from MapAnimProc_DisplayExpBar
SET_DATA gBattleHitArray, 0x203a4f0  @ from SetupMapBattleAnim 

SET_FUNC BattleEventEngineExists, 0x800F08D
@SET_FUNC EventEngineExists, 0x8001BC9
SET_FUNC DeleteBattleAnimInfoThing, 0x806F76D
SET_FUNC MapAnimProc_DisplayExpBar, 0x806E7C5
SET_FUNC MapAnim_MoveCameraOntoSubject, 0x806E645
SET_FUNC MapAnim_Cleanup, 0x806E475
SET_FUNC UpdateActorFromBattle, 0x8029A71 @ BattleApplyUnitUpdates 
SET_FUNC WriteGlobalSaveInfoNoChecksum, 0x809EFB1 
SET_FUNC CpuSet, 0x80BFA11 
SET_FUNC ReadGameSave, 0x80A08ED  
SET_FUNC ReadLastGameSaveId, 0x80A05F5  
SET_FUNC PutUnitSpriteForClassId, 0x802619D   
SET_FUNC ForceSyncUnitSpriteSheet, 0x8025581   
SET_FUNC ResetUnitSpriteHover, 0x8025F9D  
SET_FUNC ResetUnitSprites, 0x8024CF9  
SET_FUNC StartUiSMS, 0x8024D61 
SET_FUNC SetupMapSpritesPalettes, 0x8024C99 
SET_FUNC PidStatsAddActAmt, 0x809FF6D
SET_FUNC PidStatsAddStatViewAmt, 0x809FFAD 
SET_FUNC PidStatsAddDeployAmt, 0x809FFED
SET_FUNC PidStatsAddSquaresMoved, 0x80A003D
SET_FUNC PidStatsAddExpGained, 0x80A009D
SET_FUNC PidStatsSubFavval08, 0x80A00FD
SET_FUNC PidStatsSubFavval100, 0x80A0111
SET_FUNC PidStatsGetTotalLevel, 0x80A0191
SET_FUNC PidStatsGetTotalExpGain, 0x80A01BD @ ? 
SET_FUNC PidStatsGetExpGain, 0x80A01DD
SET_FUNC PidStatsGetFavval, 0x80A0211
SET_FUNC PidStatsAddFavval, 0x80A0249

SET_FUNC StartHelpPromptSprite, 0x8081FBD
SET_FUNC strlen, 0x80C0115
SET_DATA gProcScr_HelpPromptSpr, 0x8CC209C 
SET_FUNC SetPrimaryHBlankHandler, 0x8002F15
SET_FUNC SetBackgroundTileDataOffset, 0x8001435
SET_FUNC ApplyUiWindowFramePal, 0x8049A95
SET_FUNC UnpackUiWindowFrameImg2, 0x8049B25
SET_DATA sMutableHbi, 0x203E674 @ in StartHelpBox 
SET_DATA sLastHbi, 0x203E690 
SET_DATA sHbOrigin, 0x203E694 @ in StartHelpBox 
SET_DATA gHelpBoxSt, 0x203E6A0
SET_DATA gProcScr_HelpBox, 0x8CC2014 @ StartHelpBox
SET_DATA ProcScr_HelpBoxIntro, 0x8CC29BC @ StartHelpBox
SET_FUNC HelpBoxIntroDrawTexts, 0x8082C8d
SET_FUNC ApplyHelpBoxContentSize, 0x8081CDD
SET_FUNC StringInsertSpecialPrefixByCtrl, 0x8012CBD
SET_FUNC GetHelpBoxItemInfoKind, 0x8081E01
@SET_FUNC SetMsgTerminator, 0x8012c11
SET_FUNC LoadHelpBoxGfx, 0x8082529
SET_FUNC SpriteText_DrawBackground, 0x8005C99
SET_FUNC GetStringTextLen, 0x80055FD
SET_FUNC GetStringTextBox, 0x80056C5
SET_FUNC ApplyHelpBoxPosition, 0x8081D41
SET_FUNC SetHelpBoxInitPosition, 0x8081DCD
SET_FUNC ResetHelpBoxInitSize, 0x8081DF1
SET_FUNC CloseHelpBox, 0x8081B45
SET_FUNC HelpBoxSetupstringLines, 0x8082BD9
SET_FUNC HelpBoxDrawstring, 0x8082C4D
SET_DATA gProcScr_HelpBoxTextScroll, 0x8CC2994
SET_DATA gUnknown_08A02274, 0x83FCE8C
SET_FUNC MU_EndAll, 0x806CCB9 
SET_FUNC HideUnitSprite, 0x8026575
SET_FUNC MU_Exists, 0x8009FB9
SET_FUNC MU_SetDefaultFacing_Auto, 0x806BFE1
SET_FUNC MU_Create, 0x806BAF1
SET_FUNC MenuAutoHelpBoxSelect, 0x804a9D5
SET_FUNC StartOrphanMenuAdjusted, 0x804a225
SET_FUNC SetAllUnitNotBackSprite, 0x80183F5
SET_DATA gActiveUnitMoveOrigin, 0x202BBF8
SET_DATA gActiveUnitId, 0x202BD48
SET_DATA gActionData, 0x203A85C
SET_FUNC EnsureCameraOntoPosition, 0x8015CE1
SET_FUNC SetCursorMapPosition, 	0x8015A91
SET_FUNC HideMoveRangeGraphics, 	0x801D2D5
SET_FUNC RefreshEntityBmMaps, 	0x8019abd
SET_FUNC RefreshUnitSprites, 0x8025725
SET_FUNC DoesBMXFADEExist, 0x801D635
SET_FUNC Proc_End, 0x800486D
SET_FUNC HandlePlayerCursorMovement, 0x801C195
SET_FUNC IsUnitSpriteHoverEnabledAt, 0x8026065
SET_FUNC PutMapCursor, 0x801596D
SET_FUNC Text_DrawString, 0x8005719
SET_FUNC UnitFinalizeMovement, 0x8017F29
SET_FUNC ResetUnitSpriteHover, 0x8025F9D
SET_FUNC sub_802C334, 0x8029D6D
SET_FUNC PutText, 0x8005591
SET_FUNC Text_SetColor, 0x8005581
SET_DATA gProcScr_TerrainDisplay, 0x8CC2C00
SET_DATA gProcScr_PlayerPhase, 0x8B93374
SET_DATA gKeyStatusPtr, 0x8B857F8
@ 
@ 80180EC UnitBeginAction for ram 



@SET_FUNC ClearText, 0x80054E1, 55fc 
@SET_DATA sUnknown_085911C4, 0x80059C8
@SET_DATA gProcScr_HelpPromptSpr, 0x80059C8
@SET_FUNC EnablePaletteSync, 
SET_FUNC StartFace2, 0x8007BCD
SET_FUNC EndFaceById, 0x8006D51
SET_FUNC GetStringTextCenteredPos, 0x80056A9
SET_FUNC ResetFaces, 0x8006B35
SET_FUNC RegisterDataMove, 0x8003079
SET_FUNC PutFaceTm, 0x8006E8D
SET_FUNC CpuFastSet, 0x80BFA0D
SET_FUNC CopyToPaletteBuffer, 0x8001085
SET_FUNC GetPortraitData, 0x8006B21
SET_FUNC GetPidStats, 0x80A0551
SET_FUNC ReadGlobalSaveInfo, 0x809E4F1
SET_FUNC StartBgmExt, 0x80038AD
SET_DATA getSoundRoom, 0x80AADB0 
SET_DATA getSongTable, 0x8040230 
SET_FUNC SetupDebugFontForOBJ, 0x8005281
SET_FUNC PrintDebugStringAsOBJ, 0x800530d
SET_DATA gProcScr_ArenaUiMain, 0x8CE729C
SET_DATA gMode, 0x202BBF8+0x1B
SET_FUNC GetUnitBestWRankType, 0x802EAC1
SET_FUNC ArenaIsUnitAllowed, 0x802F159
SET_FUNC LoadUnit, 0x8017789 
SET_FUNC ClearUnit, 0x8017509 
SET_FUNC GetChapterEventDataPointer, 0x80315BD
SET_FUNC GetUnitFromCharId, 0x8017D35
SET_DATA ggMsgStringTable, 0x8012cb8
SET_FUNC UpdateMapViewWithFog, 0x801DB59
SET_DATA gVision, 0x202BBF8+0x0D
SET_FUNC GetItemAttributes, 0x801727D
SET_FUNC GetItemAfterUse, 0x8016731
SET_FUNC FadeExists, 0x8013EB9
SET_FUNC GetUnitFromPrepList, 0x808DD19
SET_DATA ProcScr_PrepUnitScreen, 0x8CC4854
SET_DATA ProcScr_PrepItemScreen, 0x8CC4448
SET_DATA gPaletteSyncFlag, 0x300000D 
SET_DATA gPaletteBuffer, 0x2022860
SET_DATA gCursorX, 0x202BBCC
SET_DATA gCursorY, 0x202BBCE
SET_DATA gBmSt, 0x202BBB8
SET_DATA gCameraX, 0x202BBC4
SET_DATA gCameraY, 0x202BBC6
SET_DATA gObject_8x8, 0x8B905B0 
SET_FUNC IsItemStealable, 0x8016D39
SET_FUNC CallARM_PushToSecondaryOAM, 0x8004389
SET_FUNC CallEndEvent, 0x8079A39 
SET_DATA BattleAttackerSideBool, 0x203E014
SET_DATA gProcScr_StatScreen, 0x8CC1F6C
SET_DATA gProc_ekrBattleDeamon, 0x8B9A99C
SET_DATA gProcScr_UnitDisplay_MinimugBox, 0x8CC2C60
SET_DATA sFaceConfig, 0x202A58C
SET_DATA gFaces, 0x30041C0
SET_DATA gBattleActor, 0x203A3F0  
SET_DATA gBattleActorUnit, 0x203A3F0  
SET_DATA gBattleTarget, 0x203A470
SET_DATA gBattleTargetUnit, 0x203A470
SET_FUNC GetUnitPortraitId, 0x8018BD9
SET_FUNC UnpackUiVArrowGfx, 0x80B1F6D
SET_FUNC DisplayUiVArrow, 0x80B1FB1 
SET_FUNC StartGreenText, 0x8005FF5
SET_FUNC GetUnit, 0x8018D0D
SET_FUNC memset, 0x080BFFF9
SET_DATA SaveMenuProc, 0x8CE3C54 @ fe7 
SET_DATA DifficultySelectionProc, 0x8CE4930 @ fe7 
SET_FUNC SaveMenuStartBlockingProc, 0x80A8665 @ fe7 
SET_FUNC SetupBackgrounds, 0x8002A6D
SET_FUNC SaveMenu_Init, 0x80A3631
SET_FUNC ProcSaveMenu_InitScreen, 0x80A36AD 
SET_FUNC SaveMenu_LoadExtraMenuGraphics, 0x80A38D9
SET_FUNC RegisterBlankTile, 0x8001841 
SET_FUNC RegisterFillTile, 0x80030FD   @ 0x8001841 
SET_FUNC GetUnitAid, 0x8018451 
SET_FUNC SetPopupNumber, 0x800AD35 
SET_FUNC GetPartyGoldAmount, 0x8023905
SET_FUNC SetPartyGoldAmount, 0x8023911
SET_FUNC NewPopup_Simple, 0x800AD41 
SET_DATA PopupScr_GotGold, 0x8B91BE4
SET_DATA PopupScr_GoldWasStole, 0x8B91C2C
SET_FUNC NewPopup_GoldGot, 0x800EE4D 
SET_FUNC DisplayLeftPanel, 0x807FA8D 
SET_FUNC ResetIconGraphics_, 0x8004CE9
SET_FUNC InitTexts, 0x807FA39
SET_FUNC NextRN_N, 0x8000E31
SET_FUNC GenerateExtendedMovementMap, 0x8019C81
SET_DATA TerrainTable_MovCost_BerserkerNormal, 0x8BE398C
SET_DATA TerrainTable_MovCost_BerserkerRain, 0x8BE3DDD
SET_DATA gPhase, 0x202BC07
SET_DATA gTurn, 0x202BC08
SET_DATA gSfx, 0x202BC39
SET_FUNC GetCurrentMapMusicIndex, 0x8015E9D 
SET_FUNC StartBgm, 0x8003891
SET_FUNC GetCurrentBgmSong, 0x80034DD 
SET_FUNC Sound_FadeOutBGM, 0x80035ED
SET_FUNC StartBgmExt, 0x80038AD
SET_FUNC PhaseIntroInitText, 0x801E5C9
SET_FUNC StartMapSongBgm, 0x8015F85
SET_FUNC EndAllMenus, 0x804A491
SET_FUNC RenderBmMap, 0x8019505 
SET_FUNC RefreshBMapGraphics, 0x802E369
SET_DATA ProcScr_PalFade, 0x8B92914
SET_DATA ProcScr_FadeCore, 0x8B929AC
SET_DATA ProcScr_BmFadeIN, 0x8CE4C50 
SET_DATA ProcScr_BmFadeOUT, 0x8CE4C80 
SET_FUNC GetStringFromIndex, 0x8012C61
SET_DATA sActiveMsg, 0x202B5B4 
SET_DATA sMsgString, 0x202A5B4 
SET_DATA u32MsgString, 0x202A5B4 

SET_FUNC gARM_DecompText, 0x3003940 
SET_FUNC CallARM_DecompText, 0x8004365 
SET_FUNC HbPopulate_SSCharacter, 0x80816FD 
SET_DATA SRRBuffer, 0x2026d30	@ normally used by debug printing 

.endif 
.if FE8 == true 
SET_DATA DangerBonesBuffer, 0x201c8d0 @ gTmA_Banim 

@ 7743's extend SMS past 0xCF uses ram at 0x201f148, which limits us to 0x2878 bytes, which is about the max anyway  
@ Extend SMS past 0xCF patch using SoundRoom Buffer 0201F148
@ by 7743 

SET_DATA SRRBuffer, 0x2026Ec0	@ size: 0x1f98	- normally used by debug printing
SET_FUNC MuExists, 0x8078721 
SET_FUNC StartUiSMS, 0x80266f1
SET_FUNC UnpackUiWindowFrameImg2, 0x804E169
SET_FUNC ApplyUiWindowFramePal, 0x804E0A9
SET_DATA pPromoJidLut, 0x80cc7d0 
SET_DATA Pal_SpinningArrow, 0x8a1a084 
SET_DATA PrepItemSuppyTexts, 0x2013648
SET_FUNC SetBlendConfig, 0x8001ea1
SET_DATA gProcScr_TerrainDisplay, 0x8a018ac
SET_DATA sTilesetConfig, 0x2030b8c
SET_FUNC __aeabi_idiv,    __divsi3
SET_FUNC __aeabi_idivmod, __modsi3
SET_FUNC Div, __divsi3
SET_FUNC Mod, __modsi3
SET_FUNC GetSoloAnimPreconfType, 0x802ca71
SET_DATA gEfxHpLutOff, 0x203e152
SET_DATA gEkrGaugeDmg, 0x203e1bc
SET_DATA gProcScr_efxHPBar, 0x8052354
SET_DATA gProcScr_efxHPBarResire, 0x8052624
SET_DATA classTablePoin, 0x8017AB8 
SET_DATA gBanimExpGain, 0x203e1c8

SET_DATA sUnknown_085911C4, 0x80059C8
@SET_DATA textHandles, 0x201117c @ gPrepMainMenuTexts
SET_DATA getSoundRoom, 0x80AECA8 
SET_DATA getSongTable, 0x080458E0 
SET_DATA ggMsgStringTable, 0x800a2a0 
SET_DATA u32MsgString, 0x0202A6AC
SET_FUNC gARM_DecompText, 0x3004150 
SET_FUNC CallARM_DecompText, 0x8002ba5 
SET_DATA gVision, 0x202BCF0+0x0D
SET_DATA gBattleActorUnit, 0x0203A4EC
SET_DATA gBattleTargetUnit, 0x0203A56C

SET_DATA gPaletteSyncFlag, 0x300000E 
SET_DATA gPaletteBuffer, 0x20228A8
SET_DATA gCursorX, 0x202BCB0+0x14 
SET_DATA gCursorY, 0x202BCB0+0x16
SET_DATA gCameraX, 0x202BCB0+0xC
SET_DATA gCameraY, 0x202BCB0+0xE

SET_DATA BattleAttackerSideBool, 0x203E108
SET_DATA SaveMenuProc, 0x8A200B8 @ fe8 
SET_DATA DifficultySelectionProc, 0x8A20A10 @ fe8 
SET_FUNC SaveMenuStartBlockingProc, 0x80AC3E1 @ fe8  
SET_FUNC SetupBackgrounds, 0x8001B59

SET_FUNC StartBlockingPrepVendor, 0x80B41E1
SET_FUNC StartBlockingPrepArmory, 0x80B4201
SET_FUNC StartBlockingPrepSecret, 0x80B4211

dat 0x085921C8, ProcScr_Popup
dat 0x08592228, ProcScr_PopupUpdateIcon
dat 0x08592230, PopupSrc_GotItem
dat 0x08592288, PopupSrc_ItemWasPilfered
dat 0x085922D0, ProcScr_GotItem
dat 0x08592300, PopupScr_GotGold
dat 0x08592348, PopupScr_GoldWasStole
SET_FUNC UnitLoadStatsFromCharacter, 0x8017e35 
@SET_FUNC Div, __divsi3
@SET_FUNC Mod, __modsi3
SET_DATA weatherId, 0x202BD05
SET_DATA gPlaySt, 0x202BCF0
SET_DATA gCh, 0x202BCFE 
SET_DATA Ballista_TerrainTable, 0x880BC18
SET_DATA gPhase, 0x202BCFF
SET_DATA gTurn, 0x202BD00
SET_DATA gSfx, 0x202BD31
SET_FUNC UnsetFlag, 0x8083d95
.endif 


.if FE6 == true
SET_FUNC __aeabi_idiv, 0x809DCE1 
@SET_FUNC Div, 0x809DCE1
@SET_FUNC Mod, 0x809DCE5
SET_FUNC SetFlag, 0x806BA49
SET_FUNC UnsetFlag, 0x806BA75
SET_FUNC ClearFlag, 0x806BA75
SET_FUNC CheckFlag, 0x806bA5D
 
SET_FUNC GetItemMight, 0x80171e9
SET_FUNC GetItemHit, 0x80171fd
SET_FUNC GetItemWeight, 0x8017211
SET_FUNC GetItemCrit, 0x8017225
SET_FUNC GetItemData, 0x8017359
SET_FUNC GetItemAttributes, 0x8017191
SET_FUNC GetItemIndex, 0x8017129
SET_FUNC GetItemUseEffect, 0x801730d

SET_FUNC GetCharacterData, 0x801863d
SET_FUNC GetClassData, 0x8018621
SET_FUNC UnitLoadStatsFromCharacter, 0x80176E5
SET_FUNC UnitInitFromDefinition, 0x8017655
SET_FUNC GetAutoleveledStatIncrease, 0x80250D5
@SET_FUNC CanBattleUnitGainLevels, @ inline ? 
SET_FUNC CheckBattleUnitStatCaps, 0x80253Cd
SET_FUNC UnitCheckStatCaps, 0x80179Ed
SET_FUNC GetUnit, 0x801860d
SET_FUNC CheckBattleUnitLevelUp, 0x8025105
@SET_FUNC UnitLevelUp, @ unused 
SET_FUNC UnitAutolevelCore, 0x8017855
SET_FUNC GetUnitMaxHp, 0x80183C9
SET_FUNC GetUnitPower, 0x80183E9
SET_FUNC GetUnitSkill, 0x8018409
SET_FUNC GetUnitSpeed, 0x8018449
SET_FUNC GetUnitDefense, 0x8018489
SET_FUNC GetUnitResistance, 0x80184A9
SET_FUNC GetUnitLuck, 0x80184D1
SET_FUNC DrawStatWithBar, 0x806EC6d
SET_FUNC PutNumberOrBlank, 0x8006f51
SET_FUNC PutNumberBonus, 0x8007001
SET_FUNC PutSpecialChar, 0x8006E75
SET_FUNC PutNumberSmall, 0x8006FE1
SET_FUNC StartStatScreenHelp, 0x807030d
SET_FUNC UnitHasMagicRank, 0x8018189


@SET_FUNC UnitLoadItemsFromDefinition, @ unused 
SET_FUNC UnitAddItem, 0x80174Ad 
SET_FUNC MakeNewItem, 0x801650d
@SET_FUNC UnitClearInventory, 

SET_FUNC LockGame, 0x801597d
SET_FUNC UnlockGame, 0x801598d
SET_FUNC BMapDispSuspend, 0x8028395
SET_FUNC BMapDispResume, 0x80283c9
SET_FUNC StartFastFadeFromBlack, 0x80146Ed
SET_FUNC StartFastFadeToBlack, 0x80146C9
SET_FUNC WaitForFade, 0x80149B1
SET_FUNC BG_Fill, 0x8001551
SET_FUNC BG_EnableSyncByMask, 0x8000fd5 
SET_FUNC BG_SetPosition, 0x80019Dd






SET_FUNC LoadUiFrameGraphics, 0x80417D5
SET_FUNC LoadObjUIGfx, 0x8015B45

SET_FUNC Proc_Start, 0x8003a05
SET_FUNC Proc_StartBlocking, 0x8003ad9
SET_FUNC Proc_Find, 0x8003e7d 
SET_FUNC Proc_Break, 0x8003e61
SET_FUNC Proc_Goto, 0x8003f6d
SET_FUNC Proc_EndEach, 0x8004249

SET_FUNC m4aSongNumStart, 0x809C861
SET_FUNC PutDrawText, 0x8006409
SET_FUNC ClearText, 0x80058ed
SET_FUNC InitText, 0x800579d
SET_FUNC InitTextFont, 0x800566d
SET_FUNC ResetText, 0x800563d
SET_FUNC SetTextFontGlyphs, 0x8005705 
SET_FUNC ResetTextFont, 0x800573d
SET_FUNC InitSystemTextFont, 0x8006345 
SET_FUNC PutNumber, 0x8006F31
SET_FUNC SetFontGlyphSet, 0x8005705
SET_FUNC SetTextFont, 0x8005769
SET_FUNC TileMap_FillRect, 0x809FAA1

SET_FUNC DisplayUiHand, 0x80415Cd
SET_FUNC NewPopup_ItemGot, 0x80121F5   
SET_FUNC Roll1RN, 0x8000E39
SET_FUNC SetLCGRNValue, 0x8000E99
SET_FUNC InitRN, 0x8000C89
SET_FUNC GetGameClock, 0x8000EEd
SET_FUNC PutSprite, 0x8007d3d
SET_FUNC PrintDebugStringToBG, 0x8004f19
SET_FUNC SetupDebugFontForBG, 0x8004e59 @ hook this 

SET_FUNC StartShopScreen, 0x8095E91 
SET_FUNC EndPlayerPhaseSideWindows, 0x8073325 @ maybe EndMapUi 
SET_FUNC UpdateShopItemCounts, 0x8095F5d
	@SET_FUNC GetUnitMovementCost, @ dunno @ fe7 0x80187d5
SET_FUNC GetUnitItemCount, 0x8017521
SET_FUNC GetUnitItemSlot, 0x8016D09 
SET_FUNC CanUnitUseChestKeyItem, 0x80236C5
SET_FUNC CanUnitUseDoorKeyItem, 0x8023701
SET_FUNC CanUnitOpenBridge, 0x8023715
SET_FUNC AiGetChestUnlockItemSlot, 0x80303F9
SET_FUNC GetUnitKeyItemSlotForTerrain, 0x80181d5
SET_FUNC CanUnitUseLockpickItem, 0x8023729
SET_FUNC IsItemDisplayUsable, 0x8016BD9
SET_FUNC CanUnitUseStaff, 0x8016645
SET_FUNC CanUnitUseWeapon, 0x8016539
SET_FUNC StatScreen_Display, 0x806ffdd
SET_FUNC InitStatScreenText, 0x806eaf1 

SET_DATA gBG0TilemapBuffer, 0x2021B08
SET_DATA gBG1TilemapBuffer, 0x2022308
SET_DATA gBG2TilemapBuffer, 0x2022B08
SET_DATA gBG3TilemapBuffer, 0x2023308
SET_DATA sKeyStatusBuffer, 0x2023B20
SET_DATA gStatScreen, 0x2003108 @ for text handles 
SET_DATA gUiTmScratchA, 0x2003238 @ might be wrong 
SET_DATA gUiTmScratchC, 0x2003C38 
SET_FUNC DrawStatBarGfx, 0x806E999
SET_DATA gActiveUnit, 0x30044B0
SET_DATA gActiveUnit_, 0x30044B0
@ 202AA08 gBmSt https://github.com/StanHash/fe6/blob/5430c7ea15313a5754ddb466916b1d2946e72c4a/include/bm.h#L90C8-L90C12
@ 801E2C0	801FFE0	801FB78	0	0	ChapterIntro_InitMapDisplay
SET_DATA weatherId, 0x202AA5D
SET_DATA gPlaySt, 0x202AA48
SET_DATA gCh, 0x202AA56
SET_DATA gProcScr_Shop, 0x8690F00
SET_DATA sPrevHandClockFrame, 0x203C9D8
SET_DATA sPrevHandScreenPosition, 0x203C9D4
SET_DATA gLCDControlBuffer, 0x30026B0
SET_DATA ProcScr_GotItem, 0x85C4934 @ maybe 
SET_FUNC StartBlockingPrepShop, 0x8095df1
SET_FUNC ApplyUnitDefaultPromotion, 0x8029819
SET_FUNC Decompress, 0x8013CA5
SET_FUNC memcpy, 0x809F991
SET_FUNC ClearBg0Bg1, 0x8041679
SET_FUNC UnitRemoveInvalidItems, 0x80174cd
SET_FUNC Text_GetColor, 0x8005a61
SET_FUNC PutUiWindowFrame, 0x8041359
SET_FUNC DrawIcon, 0x8004cf9
SET_FUNC GetItemIconId, 0x80172d9
SET_FUNC LoadIconPalettes, 0x8004aa5
SET_FUNC ResetIconGraphics, 0x8004a55
@SET_DATA sStatusNameTextIdLookup, 0x85C526C


.endif


.if FE7 == true 
@ SET_DATA sStatusNameTextIdLookup, 0x85C526C 
SET_FUNC ResetIconGraphics, 0x8004ce9
SET_FUNC LoadIconPalettes, 0x8004d2d
SET_FUNC GetItemIconId, 0x8017401
SET_FUNC DrawIcon, 0x8004e29 @ maybe 
SET_FUNC PutUiWindowFrame, 0x8049CE5
SET_FUNC Text_GetColor, 0x8005585
SET_FUNC UnitRemoveInvalidItems, 0x8017689
SET_FUNC ClearBg0Bg1, 0x804a041
SET_FUNC ApplyUnitDefaultPromotion, 0x8029819
SET_DATA TacticianName, 0x202BC18
SET_FUNC __aeabi_idiv, 0x80BFA15 
@SET_FUNC Div, 0x80BFA15
@SET_FUNC Mod, 0x80BFA19
SET_FUNC SetFlag, 0x80798E5 
SET_FUNC UnsetFlag, 0x8079911 
SET_FUNC ClearFlag, 0x8079911 
SET_FUNC CheckFlag, 0x80798F9
SET_FUNC GetItemMight, 0x80172E1
SET_FUNC GetItemHit, 0x80172F9
SET_FUNC GetItemWeight, 0x8017311
SET_FUNC GetItemCrit, 0x8017329
SET_FUNC GetItemData, 0x80174AD 
SET_FUNC GetItemAttributes, 0x801727D
SET_FUNC GetItemIndex, 0x80171B5
SET_FUNC GetItemUseEffect, 0x801743D

SET_FUNC GetCharacterData, 0x8018D39
SET_FUNC GetClassData, 0x8018D21
SET_FUNC UnitLoadStatsFromCharacter, 0x8017931
SET_FUNC UnitInitFromDefinition, 0x8017869
SET_FUNC GetAutoleveledStatIncrease, 0x8029605
SET_FUNC CanBattleUnitGainLevels, 0x8029635
SET_FUNC CheckBattleUnitStatCaps, 0x8029971
SET_FUNC UnitCheckStatCaps, 0x8017C65
SET_FUNC GetUnit, 0x8018D0D
SET_FUNC CheckBattleUnitLevelUp, 0x8029661
SET_FUNC UnitLevelUp, 0x802A995
SET_FUNC UnitAutolevelCore, 0x8017AC1
SET_FUNC GetUnitMaxHp, 0x8018AB1
SET_FUNC GetUnitPower, 0x8018AD1
SET_FUNC GetUnitSkill, 0x8018AF1
SET_FUNC GetUnitSpeed, 0x8018B31
SET_FUNC GetUnitDefense, 0x8018B71
SET_FUNC GetUnitResistance, 0x8018B91
SET_FUNC GetUnitLuck, 0x8018BB9
SET_FUNC DrawStatWithBar, 0x807FD29
SET_FUNC PutNumberOrBlank, 0x80061E5
SET_FUNC PutNumberBonus, 0x8006241
SET_FUNC PutSpecialChar, 0x800615D
SET_FUNC PutNumberSmall, 0x8006235
SET_FUNC StartStatScreenHelp, 0x80814F5
 
SET_FUNC UnitLoadItemsFromDefinition, 0x80178F5
SET_FUNC UnitAddItem, 0x8017655 
SET_FUNC MakeNewItem, 0x8016175
SET_FUNC UnitClearInventory, 0x8017675
SET_FUNC LockGame, 0x8015309
SET_FUNC UnlockGame, 0x8015319
SET_FUNC BMapDispSuspend, 0x802D3B5
SET_FUNC BMapDispResume, 0x802D3E9
SET_FUNC StartFastFadeFromBlack, 0x8013FD5
SET_FUNC StartFastFadeToBlack, 0x8013FB1
SET_FUNC WaitForFade, 0x8014299
SET_FUNC BG_Fill, 0x8001811
SET_FUNC BG_EnableSyncByMask, 0x8000ffd
SET_FUNC BG_SetPosition, 0x8001D8D
SET_FUNC LoadUiFrameGraphics, 0x804A211
SET_FUNC LoadObjUIGfx, 0x8015591

SET_FUNC Proc_Start, 0x8004495 
SET_FUNC Proc_StartBlocking, 0x80044F9
SET_FUNC Proc_Find, 0x80046A9 
SET_FUNC Proc_Break, 0x80046A1
SET_FUNC Proc_Goto, 0x8004721
SET_FUNC Proc_EndEach, 0x800486D 
SET_FUNC m4aSongNumStart, 0x80BE595
SET_FUNC PutDrawText, 0x8005AD5
SET_FUNC ClearText, 0x80054E1
SET_FUNC InitText, 0x8005475
SET_FUNC ResetText, 0x80053B1
SET_FUNC SetTextFontGlyphs, 0x8005411 
SET_FUNC ResetTextFont, 0x8005439
SET_FUNC ChapterStatus_SetupFont, 0x8086E61
SET_FUNC InitSystemTextFont, 0x8005A41
SET_FUNC TileMap_FillRect, 0x80C57BD
SET_FUNC StartBlockingPrepShop, 0x8098F71

SET_FUNC DisplayUiHand, 0x8049F59
SET_FUNC NewPopup_ItemGot, 0x800EF55
SET_FUNC Roll1RN, 0x8000E61
SET_FUNC SetLCGRNValue, 0x8000EC1
SET_FUNC InitRN, 0x8000CA9
SET_FUNC PutNumber, 0x80061D9
SET_FUNC GetGameClock, 0x8000F15
SET_FUNC PutSprite, 0x80069F5
SET_FUNC SetFontGlyphSet, 0x8005411
SET_FUNC SetTextFont, 0x8005451
SET_FUNC PrintDebugStringToBG, 0x8004F71
SET_FUNC SetupDebugFontForBG, 0x8004EF9


SET_FUNC StoreRNState, 0x8000D75
SET_FUNC LoadRNState, 0x8000DD1

SET_FUNC StartShopScreen, 0x80B0455 
SET_FUNC EndPlayerPhaseSideWindows, 0x8085C7D
SET_FUNC UpdateShopItemCounts, 0x80B0521
SET_FUNC GetUnitMovementCost, 0x80187d5

SET_FUNC GetUnitItemCount, 0x80176DD
SET_FUNC GetUnitItemSlot, 0x8016D0D 
SET_FUNC CanUnitUseChestKeyItem, 0x8027355
SET_FUNC CanUnitUseDoorKeyItem, 0x8027391
SET_FUNC CanUnitOpenBridge, 0x80273A5
SET_FUNC AiGetChestUnlockItemSlot, 0x8036A8D
SET_FUNC GetUnitKeyItemSlotForTerrain, 0x8018525
SET_FUNC CanUnitUseLockpickItem, 0x80273B9
SET_FUNC IsItemDisplayUsable, 0x8016AB1
SET_FUNC CanUnitUseStaff, 0x80163D5
SET_FUNC CanUnitUseWeapon, 0x80161A5
SET_FUNC StatScreen_Display, 0x808119D

SET_FUNC GetUnitStatusName, 0x8018CF1
SET_FUNC memcpy, 0x80BFF99
SET_FUNC GetStringFromIndex, 0x8012C61
SET_FUNC UnitHasMagicRank, 0x80184DD
SET_FUNC DisplayTexts, 0x807FA49
SET_FUNC UpdateStatArrowSprites, 0x8015AA9
SET_FUNC PageNumCtrl_DisplayBlinkIcons, 0x8080F55
SET_FUNC GetUnitAid, 0x8018451
SET_FUNC DrawIcon, 0x8004e29
SET_FUNC GetUnitAidIconId, 0x8018579
SET_FUNC GetUnitRescueName, 0x8018CC1 
SET_FUNC GetUnitStatusName, 0x8018CF1
SET_FUNC DisplayBwl, 0x807FBF1
SET_FUNC Text_InsertDrawString, 0x8005B19 
SET_FUNC GetUnitAffinityIcon, 0x8026B25 
SET_DATA sPage0TextInfo, 0x84049A0
SET_DATA gObject_8x8, 0x8B905B0

SET_FUNC Decompress, 0x8013169 
SET_DATA gBuf, 0x2020140
@SET_DATA Tsa_StatScreenPage0, 0x83FCA4C 
SET_FUNC TmApplyTsa, 0x80C57B5 

SET_DATA gBG0TilemapBuffer, 0x2022C60
SET_DATA gBG1TilemapBuffer, 0x2023460
SET_DATA gBG2TilemapBuffer, 0x2023C60
SET_DATA gBG3TilemapBuffer, 0x2024460
SET_DATA sKeyStatusBuffer, 0x2024C78
SET_DATA gStatScreen, 0x200310C @ for text handles 
SET_DATA gUiTmScratchA, 0x200323C 
SET_DATA gUiTmScratchB, 0x200373C 
SET_DATA gUiTmScratchC, 0x2003C3C 
SET_FUNC DrawStatBarGfx, 0x807F849 @ 806E998
SET_DATA gLCDControlBuffer, 0x3002870
SET_DATA ProcScr_GotItem, 0x8B91DC4
SET_DATA gActiveUnit, 0x3004690
SET_DATA gActiveUnit_, 0x3004690
SET_DATA gProcScr_Shop, 0x8CE6FC0
SET_DATA gLCGRNValue, 0x3000008 
SET_DATA sPrevHandClockFrame, 0x203DCF0
SET_DATA sPrevHandScreenPosition, 0x203DCEC
SET_DATA Ballista_TerrainTable, 0x8BEC398
SET_DATA weatherId, 0x202BC0D
SET_DATA gPlaySt, 0x202BBF8
SET_DATA gCh, 0x202BC06


@SET_FUNC DivArm, 0x80D1681
@
@@ division & other libgcc functions
@SET_FUNC __aeabi_idiv,    __divsi3
@SET_FUNC __aeabi_idivmod, __modsi3
@

@SET_DATA classTablePoin, 0x8017AB8 
.endif



