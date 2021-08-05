@ Definitions

@ Functions
.global PushToSecondaryOAM
.type   PushToSecondaryOAM, function
.set    PushToSecondaryOAM, 0x8002BB9

.global m4aSongNumStart
.type   m4aSongNumStart, function
.set    m4aSongNumStart, 0x80D01FD

.global Find6C
.type   Find6C, function
.set    Find6C, 0x8002E9D

.global Goto6CLabel
.type   Goto6CLabel, function
.set    Goto6CLabel, 0x8002F25

.global GetUnitStruct
.type   GetUnitStruct, function
.set    GetUnitStruct, 0x8019431

.global DeletePlayerPhaseInterface6Cs
.type   DeletePlayerPhaseInterface6Cs, function
.set    DeletePlayerPhaseInterface6Cs, 0x808D151

.global ClearMapWith
.type   ClearMapWith, function
.set    ClearMapWith, 0x80197E5

.global PlayerPhase_DisplayDangerZone
.type   PlayerPhase_DisplayDangerZone, function
.set    PlayerPhase_DisplayDangerZone, 0x801CCB5

.global ApplyStuffToRangeMaps
.type   ApplyStuffToRangeMaps, function
.set    ApplyStuffToRangeMaps, 0x801B811

.global UpdateGameTilesGraphics
.type   UpdateGameTilesGraphics, function
.set    UpdateGameTilesGraphics, 0x8019C3D

.global UpdateUnitMapAndVision,
.type   UpdateUnitMapAndVision, function
.set    UpdateUnitMapAndVision, 0x8019FA1

.global UpdateTrapHiddenStates,
.type   UpdateTrapHiddenStates, function
.set    UpdateTrapHiddenStates, 0x801A1A1

.global UpdateTrapFogVision,
.type   UpdateTrapFogVision, function
.set    UpdateTrapFogVision, 0x801A175

.global ApplyUnitMovement,
.type   ApplyUnitMovement, function
.set    ApplyUnitMovement, 0x801849D

.global RefreshFogAndUnitMaps,
.type   RefreshFogAndUnitMaps, function
.set    RefreshFogAndUnitMaps, 0x801A1F5

.global TryRemoveUnitFromBallista,
.type   TryRemoveUnitFromBallista, function
.set    TryRemoveUnitFromBallista, 0x8037A6D

.global ClearUnitSupports,
.type   ClearUnitSupports, function
.set    ClearUnitSupports, 0x80283E1

.global GetUnitStructFromEventParameter,
.type   GetUnitStructFromEventParameter, function
.set    GetUnitStructFromEventParameter, 0x800BC51

.global ClearUnitStruct,
.type   ClearUnitStruct, function
.set    ClearUnitStruct, 0x80177F5

.global GetNextFreeUnitStructPtr,
.type   GetNextFreeUnitStructPtr, function
.set    GetNextFreeUnitStructPtr, 0x8017839

.global prGotoMovGetter,
.type   prGotoMovGetter, function
.set    prGotoMovGetter, 0x8019225

.global GetUnitMovCostTable,
.type   GetUnitMovCostTable, function
.set    GetUnitMovCostTable, 0x8018D4D

.global SetMovCostTable,
.type   SetMovCostTable, function
.set    SetMovCostTable, 0x801A4CD

.global MapFillMovement,
.type   MapFillMovement, function
.set    MapFillMovement, 0x801A4ED

.global MoveActiveUnit,
.type   MoveActiveUnit, function
.set    MoveActiveUnit, 0x8018741


@ RAM locations
.global ChapterData
.set    ChapterData, 0x202BCF0

.global KeyStatusBuffer
.set    KeyStatusBuffer, 0x2024CC0

.global GameState
.set    GameState, 0x202BCB0

.global UnitMap
.set    UnitMap, 0x202E4D8

.global FogMap
.set    FogMap, 0x202E4E8

.global MovementMap
.set    MovementMap, 0x202E4E0

.global HiddenMap
.set    HiddenMap, 0x202E4EC

.global ActiveUnit
.set    ActiveUnit, 0x3004E50

.global SubjectMap
.set    SubjectMap, 0x30049A0

.global gMapTerrainPool
.set    gMapTerrainPool, 0x202ECAC

.global Slot0
.set		Slot0, 0x30004B8

.global gActiveUnitPosition
.set    gActiveUnitPosition, 0x202BE48

.global MovementMap
.set    MovementMap, 0x202E4E0

.global ActionData
.set    ActionData, 0x203A958


@ ROM locations, I'm assuming these aren't repointed. So make changes if you have repointed these!
.global OAM8x8
.set    OAM8x8, 0x8590F44

.global RAMSlotTable
.set    RAMSlotTable, 0x859A5D0


@ Procs
.global Procs_PlayerPhase
.set    Procs_PlayerPhase, 0x859AAD8
