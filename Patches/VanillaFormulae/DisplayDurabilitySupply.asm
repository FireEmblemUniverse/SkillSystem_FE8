@ hook at 9B788

@ jump with r6, return with r1 
.thumb 


.global DisplayDurabilitySupply
.type DisplayDurabilitySupply, %function 

DisplayDurabilitySupply:
lsl r1, r0, #1 
mov r0, r10 

add r0, #0x1E 
add r0, r1 
ldrb r6, [r0] 
@ check if durability based item, and if so, don't chop off top 2 durability bits 
@ instead of this hard coding by berry ID 
cmp r6, #0x6C @ Berries lol 
ldrh r6, [r0] 
bne DontChopDurability
lsl r6, #18 
lsr r6, #18 @ chop off top two durability bits 
DontChopDurability:


ldr r1, =0x809B791 
bx r1 

@ short 0x46C0 @ don't ldrh 6, [r0] 







