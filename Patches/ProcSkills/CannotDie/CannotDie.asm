.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ CheckEventId,0x8083da8
	.equ CurrentRound_ComputeWeaponEffect, 0x802B600 
.global CannotDieEffect 
.type CannotDieEffect, %function 
CannotDieEffect: 
mov r1, r5 @ vanilla 
push {r4-r7, lr} 
mov r5, r8 
mov r6, r9 
mov r7, r10
push {r5-r7} 
mov r8, r0 @attacker
mov r9, r1 @defender

mov r0, #0 
mov r10, r0 
ldr     r0,=0x802b444    @pointer to the current round
ldr     r0, [r0]          @current round pointer (usually 203a608)
ldr     r6, [r0]         @current round (originally starting at 203a5ec), increment by 4 bytes to get the next round

ldr     r0,=0x203A4D4    @Battle Stats Data?                @ 0802B3FA 4C11   
mov     r7, r0

@mov r6, r2 @battle buffer
@mov r7, r3 @battle data
mov r5, r9 
ldr r4, CannotDieList 
sub r4, #4 
b Loop 

TryAttacker: 
mov r5, r8
mov r0, r10 
cmp r0, #0 
bne Break 
mov r0, #1 
mov r10, r0 
ldr r4, CannotDieList 
sub r4, #4

Loop: 
add r4, #4
ldr r0, [r4] 
mov r1, #0 
sub r1, #1 @ 0xFFFFFFFF terminator 
cmp r0, r1
beq TryAttacker 
ldr r2, [r5] @ char pointer 
ldrb r2, [r2, #4] @ char id 
ldrb r0, [r4] @ matching char ID 
cmp r0, #0 
beq AnyChar 
cmp r0, r2 
bne Loop 

AnyChar: 
ldr r3, [r5, #4] @ class pointer 
ldrb r3, [r3, #4] @ class ID 
ldrb r0, [r4, #1] 
cmp r0, #0 
beq AnyClass 
ldrb r1, [r4, #1] 
cmp r1, r3 
bne Loop 
AnyClass: 

ldrh r0, [r4, #2] @ flag 
cmp r0, #0 
beq AnyFlag
blh CheckEventId 
cmp r0, #1 
beq Loop 
AnyFlag: 
@only activate if damage > current enemy hp-1
ldrb	r5,[r5,#0x13]
@mov	r0,#0x01
@sub	r5,r0 @ current hp - 1 
ldrh    r0,[r7,#0x04] @ damage 
cmp	r5,r0
bgt Break @ if health > damage, exit 
@ copied bane 
@ no clue really what this does 

@set offensive skill flag and miss flag 
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0,#0x2          @miss flag     @ 0802B430 2002  
orr r1, r0 @ set miss flag 
mov     r0, #0x40
lsl     r0, #8           @0x4000, attacker skill activated
orr     r1, r0
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018   


mov	r0,#0xFF	@no animation!
strb	r0,[r6,#4]

mov r0, #0 
strh r0, [r7, #0x04] @ no damage 


Break: 
pop {r5-r7} 
mov r8, r5
mov r9, r6
mov r10, r7  
pop {r4-r7}
mov r0, r4 
mov r1, r5 
blh CurrentRound_ComputeWeaponEffect
mov r0, #0x13 
ldsb r0, [r4, r0] 
cmp r0, #0 
 
pop {r1} 
bx r1 
.ltorg 
CannotDieList: 


