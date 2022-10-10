.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ gActionStruct, 0x203A958 
	.equ CheckEventId,0x8083da8
push {r4-r5, lr} 
mov r4, r0 @ unit 
@bl GetDifficulty 

ldrb r5, [r4, #8] @ level 

ldr r0, =0x202BCb0 
ldrb r1, [r0, #4] 
mov r0, #0x40 @  (gGameStatebits ) ? 
and r0, r1 
cmp r0, #0 
bne MaybeTrue 
ldrb r0, [r4, #0x9] @ exp 
cmp r0, #0xFF @ exp is 255, so can't levelup 
beq False 
mov r0, #0xB 
ldsb r0, [r4, r0] 
mov r1, #0xC0 
and r0, r1 
cmp r0, #0 
bne False 

MaybeTrue: 
ldr r0, =gActionStruct 
ldrb r0, [r0, #0x11] 
cmp r0, #0x1A @ used item (eg. rare candy) this turn 
beq True @ can always level up when using a rare candy 

bl CountNumberOfBadges 
ldr r3, =maxLevelTableHard
ldrb r0, [r3, r0] 
cmp r5, r0 
blt True 
b False 

True: 
mov r0, #1 
b End 

False: 
mov r0, #0 
End: 
pop {r4-r5} 
pop {r1} 
bx r1 

.ltorg 
CountNumberOfBadges:
push {r4-r6, lr} 
mov r4, #0 
ldr r5, =BadgeFlagLink
mov r6, #0 

Loop: 
ldrb r0, [r5, r6] 
blh CheckEventId
add r4, r0 
add r6, #1 
cmp r6, #8 
ble Loop 
mov r0, r4 @ number of badges 

pop {r4-r6}
pop {r1} 
bx r1 
.ltorg 


.global ExpModifyBasedOnBadges
.type ExpModifyBasedOnBadges, %function 
ExpModifyBasedOnBadges: 
push {r4-r5, lr} 
mov r4, r0 @ exp 
mov r5, r1 @ unit 
bl CountNumberOfBadges 
ldrb r1, [r5, #8] @ level 
ldr r3, =maxLevelTableHard
ldrb r0, [r3, r0] @ max level 

cmp r1, r0 
bge ReturnZero
sub r0, r1 
cmp r0, #5 
bgt Return 
mov r1, #20 
mul r0, r1 
mul r0, r4 @ exp * (20 / 40 / 60 / 80%) 
mov r1, #100 
swi 6 
mov r4, r0 
b Return 

ReturnZero: 
mov r4, #0 

Return: 
mov r0, r4 

pop {r4-r5}
pop {r1} 
bx r1 
.ltorg 


