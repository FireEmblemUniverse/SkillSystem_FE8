.thumb 
@ org $2AC24 
mov r1, #0x15 
ldsb r1, [r4, r1] 
lsr r2, r1, #0x1F 
add r1, r2 
asr r1, #1 
add r2, r1, r0 @ enemy crit rate ends here 
ldrb r1, [r4, #0x0B] @ allegiance 
lsr r1, #6 @ top bits only 
cmp r1, #0 
bne Exit 
ldrb r1, [r4, #0x15] @ skill
add r1, #1 @ rounding 
lsr r1, #2 @ 1/4 of skill
add r2, r1 @ 3/4 of skill stat for players 
Exit: 
bx lr 
.ltorg 
