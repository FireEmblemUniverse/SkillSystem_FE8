.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ RefreshFogAndUnitMaps, 0x801A1F4 
.equ AddArrowTrapTargetsToTargetList, 0x802E710 @r0 = x, r1 = y, r2 = trap type (7 for arrow) 
.equ BWL_AddLossFromTrap, 0x802EA1C 
.equ GenerateDisplayedTrapDamageTargets, 0x802E8A8 
.equ AddTarget, 0x804F8BC 
.equ InitTargets, 0x804F8A4 
.equ gProc_ShowArrowAnimation, 0x859E490 
.equ RefreshEntityMaps, 0x801A1F4 
.equ CheckForDeadUnitsAndGameOver, 0x802EA28 
.equ MemorySlot, 0x30004B8 
.equ ProcStart, 0x8002C7C 
.equ ProcStartBlocking, 0x8002CE0 
.equ CurrentUnit, 0x3004E50
.equ UnitMap, 0x202E4D8
.equ EndMMS, 0x80790a4 
.equ ProcFind, 0x8002E9D
.equ gProc_MoveUnit, 0x89A2C48
.equ ShowUnitSMS, 0x8028130 

push {r4-r7, lr} 
@mov r4, r0 @ Parent proc 

blh RefreshFogAndUnitMaps

@ make it hit the active unit, too 
ldr r3, =CurrentUnit 
ldr r3, [r3] 
cmp r3, #0 
beq NoActiveUnit 
ldrb r0, [r3, #0x10] @ XX 
ldrb r1, [r3, #0x11] @ YY 

ldr r2, =UnitMap 
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb r0, [r3, #0x0B] @ deployment byte 
strb r0, [r2] @ at their coordinate 


@ldr r0, [r3, #0x0C] @ state 
@mov r1, #1 
@bic r0, r1 @ no hide 
@str r0, [r3, #0x0C] 
@
@mov r0, r3 @ unit 
@blh ShowUnitSMS 
@@mov r11, r11 @ [202be4c+0x0C]!
@
@@blh 0x80790a4 @ End MMS 
@@
@ldr r0, =gProc_MoveUnit
@blh ProcFind 
@cmp r0, #0 
@beq SkipHidingInProc
@add r0, #0x40 @this is what MU_Hide does @MU_Hide, 0x80797D5
@mov r1, #1 
@strb r1, [r0] @ store back 0 to show active MMS again aka @MU_Show, 0x80797DD
@
@SkipHidingInProc: 
@
@blh RefreshEntityMaps 

NoActiveUnit: 

mov r0, #0 
mov r1, #0 
blh InitTargets 

ldr r3, =MemorySlot 
ldrh r5, [r3, #4*1] @ damage 
add r3, #0x0B*4 

ldrh r6, [r3] @ XX 
ldrh r7, [r3, #2] @ YY
mov r0, r6 
mov r1, r7  
mov r2, r5 @ damage 
blh AddArrowTrapTargetsToTargetList 
blh BWL_AddLossFromTrap 
@blh GenerateDisplayedTrapDamageTargets 

mov r0, #0 
mov r1, #0 
blh InitTargets 

mov r0, r6 @ XX 
mov r1, r7 @ YY 
mov r2, #0 
mov r3, #7 @ arrow trap ID @ $36384 has a whole bunch of if statements related to target's r3 value 
blh AddTarget, r4  
mov r0, r6 @ XX 
mov r1, r7 @ YY 
mov r2, r5 @ damage 
blh AddArrowTrapTargetsToTargetList 

@ldr r0, =gProc_ShowArrowAnimation 
@mov r1, r4 @ parent 
@blh ProcStartBlocking 





pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 





