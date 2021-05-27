@ Definitions

@ Functions
.global PushToSecondaryOAM
.type   PushToSecondaryOAM, function
.set    PushToSecondaryOAM, 0x08002BB9

.global m4aSongNumStart
.type   m4aSongNumStart, function
.set    m4aSongNumStart, 0x080D01FD

.global Find6C
.type   Find6C, function
.set    Find6C, 0x08002E9D

.global Goto6CLabel
.type   Goto6CLabel, function
.set    Goto6CLabel, 0x08002F25

.global GetUnitStruct
.type   GetUnitStruct, function
.set    GetUnitStruct, 0x08019431

.global DeletePlayerPhaseInterface6Cs
.type   DeletePlayerPhaseInterface6Cs, function
.set    DeletePlayerPhaseInterface6Cs, 0x0808D151

.global ClearMapWith
.type   ClearMapWith, function
.set    ClearMapWith, 0x080197E5

.global PlayerPhase_DisplayDangerZone
.type   PlayerPhase_DisplayDangerZone, function
.set    PlayerPhase_DisplayDangerZone, 0x0801CCB5

.global ApplyStuffToRangeMaps
.type   ApplyStuffToRangeMaps, function
.set    ApplyStuffToRangeMaps, 0x0801B811

.global UpdateGameTilesGraphics
.type   UpdateGameTilesGraphics, function
.set    UpdateGameTilesGraphics, 0x08019C3D

.global UpdateUnitMapAndVision,
.type   UpdateUnitMapAndVision, function
.set    UpdateUnitMapAndVision, 0x08019FA1

.global UpdateTrapHiddenStates,
.type   UpdateTrapHiddenStates, function
.set    UpdateTrapHiddenStates, 0x0801A1A1

.global UpdateTrapFogVision,
.type   UpdateTrapFogVision, function
.set    UpdateTrapFogVision, 0x0801A175

.global ApplyUnitMovement,
.type   ApplyUnitMovement, function
.set    ApplyUnitMovement, 0x0801849D

.global RefreshFogAndUnitMaps,
.type   RefreshFogAndUnitMaps, function
.set    RefreshFogAndUnitMaps, 0x0801A1F5

.global TryRemoveUnitFromBallista,
.type   TryRemoveUnitFromBallista, function
.set    TryRemoveUnitFromBallista, 0x08037A6D

.global ClearUnitSupports,
.type   ClearUnitSupports, function
.set    ClearUnitSupports, 0x080283E1

.global GetUnitStructFromEventParameter,
.type   GetUnitStructFromEventParameter, function
.set    GetUnitStructFromEventParameter, 0x0800BC51

.global ClearUnitStruct,
.type   ClearUnitStruct, function
.set    ClearUnitStruct, 0x080177F5

.global GetNextFreeUnitStructPtr,
.type   GetNextFreeUnitStructPtr, function
.set    GetNextFreeUnitStructPtr, 0x08017839

.global prGotoMovGetter,
.type   prGotoMovGetter, function
.set    prGotoMovGetter, 0x08019225

.global GetUnitMovCostTable,
.type   GetUnitMovCostTable, function
.set    GetUnitMovCostTable, 0x08018D4D

.global SetMovCostTable,
.type   SetMovCostTable, function
.set    SetMovCostTable, 0x0801A4CD

.global MapFillMovement,
.type   MapFillMovement, function
.set    MapFillMovement, 0x0801A4ED


@ RAM locations
.global ChapterData
.set    ChapterData, 0x0202BCF0

.global KeyStatusBuffer
.set    KeyStatusBuffer, 0x02024CC0

.global GameState
.set    GameState, 0x0202BCB0

.global UnitMap
.set    UnitMap, 0x0202E4D8

.global FogMap
.set    FogMap, 0x0202E4E8

.global MovementMap
.set    MovementMap, 0x0202E4E0

.global ActiveUnit
.set    ActiveUnit, 0x03004E50

.global SubjectMap
.set    SubjectMap, 0x030049A0

.global gMapTerrainPool
.set    gMapTerrainPool, 0x0202ECAC

.global HiddenMap
.set    HiddenMap, 0x0202E4EC

.global Slot0
.set		Slot0, 0x030004B8

.global gActiveUnitPosition
.set    gActiveUnitPosition, 0x0202BE48

.global MovementMap
.set    MovementMap, 0x202E4E0

.global ActionData
.set    ActionData, 0x203A958


@ ROM locations, I'm assuming these aren't repointed. So make changes if you have repointed these!
.global OAM8x8
.set    OAM8x8, 0x08590F44

.global RAMSlotTable
.set    RAMSlotTable, 0x0859A5D0


@ Procs
.global Procs_PlayerPhase
.set    Procs_PlayerPhase, 0x0859AAD8
