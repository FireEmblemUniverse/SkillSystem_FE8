.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ CheckEventId,0x8083da8
	
.global CannotDieEffect 
.type CannotDieEffect, %function 
CannotDieEffect: 
push {r4-r7, lr} 
mov r6, r8 
mov r7, r9 
push {r6-r7} 
mov r8, r0 @attacker
mov r9, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data

ldr r5, [r1, #4] 
ldrb r5, [r5, #4] @ class ID 

ldr r4, =CannotDieList 
sub r4, #2 
Loop: 
add r4, #2
ldrh r0, [r4] 
cmp r0, #0 
beq Break  
ldrb r1, [r4] 
cmp r1, r5 
bne Loop 
lsr r0, #8 @ flag as a byte only 
blh CheckEventId 
cmp r0, #1 
beq Loop 

@ only 1 unit can be immune per battle 
mov r4, r8 @ atkr 
mov r5, r9 @ dfdr 

@only activate if damage > current enemy hp-1
ldrb	r5,[r5,#0x13]
@mov	r0,#0x01
@sub	r5,r0 @ current hp - 1 
ldrh    r0,[r7,#0x04] @ damage 
cmp	r5,r0
bgt Break @ if health > damage, exit 
cmp r5, #5 
ble NoCap 
sub r5, #4
NoCap:  
sub r5, #1 

@ copied bane 
@ no clue really what this does 

@if we proc, set offensive skill flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0, #0x40
lsl     r0, #8           @0x4000, attacker skill activated
orr     r1, r0
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018  

mov	r0,#0xFF	@no animation!
strb	r0,[r6,#4]

@if we proc, set the lethality flag
ldr     r3,[r6]    
lsl     r1,r3,#0xD                @ 0802B4D0 0359     
lsr     r1,r1,#0xD                @ 0802B4D2 0B49     
mov     r0,#0x80                @ 0802B4D4 2080     
lsl     r0,r0,#0x4  @ 0x800, lethality flag     @ 0802B4D6 0100     
orr     r1,r0                @ 0802B4D8 4301     
ldr     r2,=#0xFFF80000                @ 0802B4DA 4A0A     
mov     r0,r2                @ 0802B4DC 1C10     
and     r0,r3                @ 0802B4DE 4018     
orr     r0,r1                @ 0802B4E0 4308     
str     r0,[r6]                @ 0802B4E2 6020  

strh    r5,[r7,#0x4]                @ 0802B4E6 80A8  

ldr     r3,[r6]                @ 0802B4E8 6823     
lsl     r0,r3,#0xD                @ 0802B4EA 0358     
lsr     r0,r0,#0xD                @ 0802B4EC 0B40     
ldr     r1,=#0xFFFF7FFF                @ 0802B4EE 4906     
and     r0,r1                @ 0802B4F0 4008     
and     r2,r3                @ 0802B4F2 401A     
orr     r2,r0                @ 0802B4F4 4302     
str     r2,[r6]                @ 0802B4F6 6022       



Break: 
pop {r6-r7} 
mov r8, r6 
mov r9, r7 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 



