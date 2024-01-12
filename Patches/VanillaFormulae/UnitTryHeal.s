.thumb 


mov r3, r0 
mov r0, r6 @ curr hp 
add r0, r5 @ hp to gain/lose 
cmp r0, #0 
bgt NoLowerCap
mov r0, #0 
NoLowerCap:
cmp r0, r3 
ble NoFullHeal
mov r0, r3 
NoFullHeal:
strb r0, [r4, #0x13] 
bx lr 

.ltorg 








