
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







