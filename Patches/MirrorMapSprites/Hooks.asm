
.thumb 
.global SetMirrorSpriteHook
.type SetMirrorSpriteHook, %function 
SetMirrorSpriteHook: @ 0x2723C 
push {lr} 
add r4, #0x80 @ vanilla 
mov r1, #0xF 
and r1, r0 
lsl r1, #0xC 
add r4, r1 
strh r4, [r5, #0x8] @ vanilla 

@ r6 as unit, r5 as sms handle 
mov r0, r6 @ unit 
mov r1, r5 @ sms handle 
bl SetMirrorSpriteInSmsHandle

@ mov r0, r6 @ vanilla 
@ ... 
pop {r0} 
bx r0 
.ltorg 

.global InitSpriteHook
.type InitSpriteHook, %function 
InitSpriteHook: 
push {lr} 
ldr r0, [r3] 
str r1, [r0] 
str r0, [r2] 
mov r1, r0 
add r1, #0xC 
str r1, [r3] 

mov r3, #0 
strb r3, [r0, #0xA] 
pop {r3} 
bx r3 
.ltorg 






