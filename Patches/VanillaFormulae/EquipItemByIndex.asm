

@ EquipUnitItemByIndex 
@ bx'd to using r2 from 8016BC4 

@ push {r4-r5, lr} 
@ mov r3, r0 

@ r0/r3 is Unit 
@ r1/r4 is item index 


cmp r1, #9 @ GaidenMagic 
bne Continue


Continue: 
lsl r4, r1, #1 
add r0, #0x1E 
add r0, r4 


















