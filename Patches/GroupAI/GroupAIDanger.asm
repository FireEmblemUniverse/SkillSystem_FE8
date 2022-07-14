.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ gpAiBattleWeightFactorTable, 0x30017D8 
.equ ActionStruct, 0x203A958
.equ gActiveUnit, 0x03004E50	@{U}
.equ gMapMove2, 0x202E4F0 
.equ AiDecision, 0x203AA94 @ [203AA96..203AA97]!!
mov r0, r8 @ vanilla 
strb r0, [r4, #8] 
mov r0, r9 
strb r0, [r4, #9] 
mov r0, #1 
strb r0, [r4, #0xA] @ vanilla 
push {r4-r6, lr} 

ldr r3, =gActiveUnit 
ldr r3, [r3] 
cmp r3, #0 
beq End 

ldr r2, =gpAiBattleWeightFactorTable 
ldr r2, [r2] 
ldrb r2, [r2, #6] @ should ai ignore dangerous tiles 
cmp r2, #0 
beq End @ if the ai does not care about dangerous tiles, then they won't all trigger when one enters opposing attack range 

mov r0, #0x41
ldrb r6, [r3,r0] @ ai4 byte 
mov r0, #0x5F
and r6, r0
cmp r6, #0x0
beq End 

ldr r3, =AiDecision 
ldrb r0, [r3, #2]  @ XX
ldrb r1, [r3, #3]  @ YY 



ldr		r2, =gMapMove2	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates
 @ this will only consider weapon with highest might 

cmp r0, #0 
bne ActivateGroup 
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
pop {r4-r6} 
pop {r1} 
bx r1 
.ltorg 




