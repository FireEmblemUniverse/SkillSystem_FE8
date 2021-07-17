.thumb
@ mov r4, r0 @ Unit struct 
@ add r0, #0x48 @ Equipped wep 
@ LDRH r0, [r0] @ Equipped wep 
@ BL GetItemHit 
@ r0 is wep hit rate 
mov r2,#0x15
ldsb r2,[r4,r2] @ Skill in r2 
lsl r2, #2 @ Skill * 4 
@lsr r3,r2,#0x1 @ Skill / 2 
@lsl r2,r2,#0x1 @ Skill * 2 
@add r2,r3 @ 
add r2,r0

ldr r3, =0x802abc1
bx r3


