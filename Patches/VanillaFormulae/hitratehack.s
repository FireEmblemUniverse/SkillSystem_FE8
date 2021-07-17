.thumb
@ mov r4, r0 @ Unit struct 
@ add r0, #0x48 @ Equipped wep 
@ LDRH r0, [r0] @ Equipped wep 
@ BL GetItemHit 
@ r0 is wep hit rate 
mov r1, r0 
push {r1}
mov r2,#0x15
ldsb r2,[r4,r2] @ Skill in r2 

@lsl r1, r2, #1 @ Skill * 2 
mov r1, r2 
add r1, #1 @ So we never multiply by 0 
mul r0, r1 @ wep hit rate * (skill*2) 
mov r1, #100 
swi 0x6 @ Divide r0 by r1 
		@ Probably clobbers the scratch registers 
pop {r1}
add r0, r1 @ 

mov r2,#0x15
ldsb r2,[r4,r2] @ Skill in r2 
lsl r2, #1 @ 2x skill added 

add r2,r0 
@ Needs r2 as hit value when returning 
ldr r3, =0x802abc1
bx r3


