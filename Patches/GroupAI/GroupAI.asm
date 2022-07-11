.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb
.equ AiGetPositionUnitSafetyWeight, 0x803E114 
.equ AiBattleGetDamageTakenWeight, 0x803E0B4 

.equ SetupAiDangerMap, 0x803E2F4 
.equ FillAiDangerMap, 0x803E320 
.equ gpAiBattleWeightFactorTable, 0x30017D8 
.equ gMapMove2, 0x202E4F0 @ 3e190 @ 2030448 
.equ AiData, 0x203AA04 
.equ ai3_address, 0x80D8178 
.equ ActionStruct, 0x203A958
.equ Attacker, 0x203A4EC
.equ Defender, 0x203A56C
.equ bmMapFill, 0x80197E4 
push	{r4-r6,lr}
@ldr r4, =Attacker 
ldr r5, =Defender 
ldr r6, =ActionStruct 


mov r0, #0x41
ldrb r6, [r4,r0]
mov r0, #0x5F
and r6, r0
cmp r6, #0x0
bne ActivateGroupIfAttacked 

CheckDefender:
mov r0, #0x41
ldrb r6, [r5,r0]
mov r0, #0x1F
and r6, r0
cmp r6, #0x0
bne ActivateGroupIfAttacked 
b End 

ActivateGroupIfAttacked: 
@check if attacked this turn
ldr r3, =0x203A958 @ gAction 
ldrb r0, [r3,#0x11]	@action taken this turn
cmp	r0, #0x2 @attack
beq ActivateGroup 
b End 


ActivateGroup:
mov r4, #0x80 @first enemy unit
ldr r5, =0x8019430 @get ram from dplynum
NextUnit:
mov r0, r4
mov lr, r5
.short 0xf800
cmp r0, #0 
beq NotInGroup 
ldr r1, [r0] 
cmp r1, #0 
beq NotInGroup 
@r0 is now ram

mov r2, #0x41
ldrb r3, [r0,r2]
mov r2, #0x1F
and r3, r2
cmp r3, r6
bne NotInGroup

mov r2, #0x41
ldrb r3, [r0,r2]
mov r2, #0xE0
and r3, r2
mov r2, #0x41
strb r3, [r0, r2]
mov r2, #0x44
mov r3, #0x0
strb r3, [r0,r2]

@add unit to the AI list so enemies act twice
ldr	r2,=0x203AA03
ldrb	r1, [r0,#0x0B]	@allegiance byte of the character we are checking
AddAILoop:
add	r2, #0x01
ldrb	r3, [r2]
cmp	r3, #0x00
bne	AddAILoop
strb	r1, [r2]
add	r2, #0x01
strb	r3, [r2]

NotInGroup:
add r4, #1
cmp r4, #0xBF
ble NextUnit

End:
pop	{r4-r6}
pop	{r0}
bx	r0


	.equ FillRangeMapForDangerZone, 0x0801B810
	.equ BmMapFill, 0x080197E4
	.equ gMapMovement, 0x202E4E0 
	.equ gMapRange, 0x202E4E4 
@.global IsUnitInDanger 
@.type IsUnitInDanger, %function 
IsUnitInDanger:
push {r4, lr} 
mov r4, r0 @ unit 
@ If you want the AI to act differently when players/npcs can target you, use this. 
@ It is turn dependent, so on player phase it will get enemy range and vice versa 

@ 202E4E4 range map 
@ 202E4F0 @ ai danger map - 0203AA04 + 7A | byte | 1 if the second movement map is readable as the "danger" map (0 if not)
@ dunno what toggles that  but we aren't using it here so whatever 

@ldr r3, =0x203AA75 @ldr r2, =0x202E4F0 @ enemy danger map? 
@ldrb r0, [r3] 


mov r0, #0 @ arg r0 = staff range?
blh FillRangeMapForDangerZone 

ldr r0, =gMapMovement
ldr r0, [r0]
mov r1, #1
neg r1, r1            @ arg r1 = -1
blh BmMapFill @ Make movement impossible..? 

ldrb r0, [r4, #0x10] 
ldrb r1, [r4, #0x11] 

ldr r2, =gMapRange @ Range map 
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates

cmp r0, #0 
bne ActiveUnitIsInDanger 
mov r0, #0 
b EndIsActiveUnitInDanger

ActiveUnitIsInDanger:
mov r0, #1 
EndIsActiveUnitInDanger:

pop {r4} 
pop {r1} 
bx r1 

.ltorg 
