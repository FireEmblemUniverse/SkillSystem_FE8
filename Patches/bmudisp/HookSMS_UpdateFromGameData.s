@ $27274 
.thumb 

.global HookSMS_UpdateFromGameData
.type HookSMS_UpdateFromGameData, %function 
HookSMS_UpdateFromGameData: 
push {lr} 

and r0, r1 
cmp r0, #0 
beq SkipLines
ldrb r0, [r5, #0x0B] 
add r0, #0x40 
strb r0, [r5, #0x0B] @ idk 
SkipLines:
str r5, [r6, #0x3c] 

mov r0, r6 @ unit 
@bl GetUnitFacing
@cmp r0, #2 @ facing downwards already 
@beq Exit 

mov r2, r0 @ facing 
mov r0, r6 @ unit 
ldr r1, [r0, #4] @ class 
ldrb r1, [r1, #6] @ smsID 

mov r1, r2 @ direction 
bl SetUnitFacing 

@ previously crashed here sometimes during enemy phase ai stuff 
@bl UpdateSMSDir @(struct Unit* unit, u8 smsID, int facing)
Exit: 


pop {r3} 
bx r3 
.ltorg 
@ $F88C 
.global HookUnitLoadForDirection
.type HookUnitLoadForDirection, %function 
HookUnitLoadForDirection:
push {lr} 

ldr r3, =0x800F8A8 @ move unit based on REDA, "special", or nothing given unit def  
mov lr, r3 
mov r0, r9 
lsl r3, r0, #0x18 
asr r3, #0x18 
mov r0, r5 
mov r1, r6 
mov r2, r8 
.short 0xf800 

ldr r0, [r5] @ unit 
ldrb r0, [r0, #4] 
cmp r0, #0xE0 @ trainers only 
blt End 
cmp r0, #0xEF @ trainers 
bgt End 

ldrb r1, [r6, #3] 
lsr r1, #3 @ remove <8 
cmp r1, #0 
beq FaceDown 
cmp r1, #2 
beq FaceLeft 
b StoreFace
FaceDown: 
mov r1, #2 
b StoreFace 
FaceLeft: 
mov r1, #0 
b StoreFace 

StoreFace: 
mov r2, #3 
and r1, r2 

Store2: 
mov r0, r5 @ unit 
@ r1 is direction to face by default 
mov r11, r11 
bl SetUnitFacing @ (struct Unit* unit, int dir)

@ this may be dangerous idk 
@bl SetUnitFacingAndUpdateGfx

End: 
pop {r3} 
bx r3 
.ltorg 




