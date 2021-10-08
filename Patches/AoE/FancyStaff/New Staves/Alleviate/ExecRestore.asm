.thumb
.include "_TargetSelectionDefinitions.s"


push {r4-r7,r14}
mov        r7,r0  @copy r0 to r7 to preserve it for later
ldr     r4,=ActionStruct 
ldrb    r0,[r4,#0xC]
_blh     GetUnit
mov     r6,r0
ldrb     r1,[r4,#0x12] @load register r1 with byte at address in r4 + 0x12?
_blh     0x802CB24 @SetupSubjectBattleUnitForStaff
_blh     0x8033258 @GetPlayerLeaderUnitID
_blh     0x801829C @GetUnitByCharID
_blh     0x802CBC8 @SetupTargetBattleUnitForStaff    
mov     r0,r6
ldrb    r2,[r4,#0x12]
lsl     r2,#1
add     r2,#0x1E
ldrh    r2,[r0,r2]
ldr     r1,=0x8025F99
ldr     r3, Item_TURange
_blr    r3
_blh     0x804FD28 @GetTargetListSize
mov     r5,r0
mov     r4,#0 @put 0 in r4 to start our counter

RestoreLoop:
cmp     r4,r5
bge     EndRestoreLoop @if r4 is greater than or equal to r5, branch to label EndRestoreLoop
mov     r0,r4
_blh     0x804FD34 @GetTarget 
ldrb     r0,[r0,#2]
_blh     GetUnit
mov     r1,r0
add     r1,#0x30
ldrb     r1,[r1]
mov     r2,#0xF
and     r1,r2
cmp     r1,#0xB
bne     ResetStatus
ldr     r1,[r0,#0xC]
ldr     r2,=0x442
bic     r1,r2
str     r1,[r0,#0xC]

ResetStatus:
mov     r1,#0
_blh     0x80178D8 @SetUnitNewStatus 
add     r4,#1
b         RestoreLoop

EndRestoreLoop:
mov     r0,r7
_blh     0x802CC54 @FinishUpItemBattle 
_blh     0x802CA14 @BeginBattleAnimations 
pop     {r4-r7}
pop     {r0}
bx         r0

.ltorg 
Item_TURange:
