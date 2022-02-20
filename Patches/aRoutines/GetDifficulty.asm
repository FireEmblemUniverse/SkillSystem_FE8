
.thumb 

.equ gChapterData, 0x202BCF0
@ see $34704

ldr r2, =gChapterData
ldrb r0, [r1, #0x14] 
mov r1, #0x40 
and r1, r0 
neg r1, r1 
lsr r1, #0x1F 
@ 1 in r2 for difficult 

@ see $800E10A from CHECK_TUTORIAL? I do it differently here because it branches for some reason 
@ldr r2, =gChapterData
mov r0, r2
add r0, #0x42 
ldrb r0, [r0] 
mov r2, #0x20 
and r0, r2 
lsr r0, #5 
add r0, r1 @ 0 = easy, 1 = normal, 2 = hard 

bx lr 
.ltorg 
.align 





