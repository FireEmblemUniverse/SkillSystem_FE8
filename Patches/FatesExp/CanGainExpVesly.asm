.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ CheckEventId,0x8083da8
push {r4-r7, lr} 
mov r4, r0 @ unit 
bl GetDifficulty 
lsr r0, #1 @ we only care about hard mode or not 
mov r5, #11 @ 10 levels above # of badges always allowed 
lsr r5, r0 @ half that if hard mode 
mov r6, #6 
ldrb r7, [r4, #8] @ level 

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

ldr r0, =BoulderbadgeObtained
lsl r0, #16 
lsr r0, #16 
blh CheckEventId
mul r0, r6 @ x6 
add r5, r0 
cmp r5, r7 
bge True 

ldr r0, =CascadebadgeObtained
lsl r0, #16 
lsr r0, #16 
blh CheckEventId
mul r0, r6 @ x6 
add r5, r0 
cmp r5, r7 
bge True 
ldr r0, =ThunderbadgeObtained
lsl r0, #16 
lsr r0, #16 
blh CheckEventId
mul r0, r6 @ x6 
add r5, r0 
cmp r5, r7 
bge True 
ldr r0, =SoulbadgeObtained
lsl r0, #16 
lsr r0, #16 
blh CheckEventId
mul r0, r6 @ x6 
add r5, r0 
cmp r5, r7 
bge True 
ldr r0, =RainbowbadgeObtained
lsl r0, #16 
lsr r0, #16 
blh CheckEventId
mul r0, r6 @ x6 
add r5, r0 
cmp r5, r7 
bge True 
ldr r0, =MarshbadgeObtained
lsl r0, #16 
lsr r0, #16 
blh CheckEventId
mul r0, r6 @ x6 
add r5, r0 
cmp r5, r7 
bge True 
ldr r0, =VolcanobadgeObtained
lsl r0, #16 
lsr r0, #16 
blh CheckEventId
mul r0, r6 @ x6 
add r5, r0 
cmp r5, r7 
bge True 
ldr r0, =EarthbadgeObtained
lsl r0, #16 
lsr r0, #16 
blh CheckEventId
cmp r0, #1 
beq True @ if defeated giovanni, we can level up to 100 
b False @ if this isn't true, we've already compared level with our badges as 7 * 6 + (5 or 11) = 47 or 53 max level before defeating giovanni 

True: 
mov r0, #1 
b End 

False: 
mov r0, #0 
End: 
pop {r4-r7} 
pop {r1} 
bx r1 











