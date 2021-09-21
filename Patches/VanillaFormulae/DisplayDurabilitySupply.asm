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
push {r0-r3} 
ldrb r0, [r0] 
bl IsItemDurabilityBased @ check if durability based item, and if so, don't chop off top 2 durability bits 
cmp r0, #1 
pop {r0-r3} 
ldrh r6, [r0] 
beq DontChopDurability 
lsl r6, #18 
lsr r6, #18 @ chop off top two durability bits 
DontChopDurability:
ExitDisplayDurabilitySupply:

ldr r1, =0x809B791 
bx r1 

@ short 0x46C0 @ don't ldrh 6, [r0] 


@ bx'd to from 8034CDC 
.global DisplayDurabilityTradeWindowSmall 
.type DisplayDurabilityTradeWindowSmall, %function 
DisplayDurabilityTradeWindowSmall:

ldr r0, [sp, #8] 
add r0, #0x1E 
add r0, r1 
ldrh r4, [r0] 

push {r0-r3} 
ldrb r0, [r0] @ item ID 
bl IsItemDurabilityBased 
cmp r0, #1 
pop {r0-r3} 
beq DontChopDurabilityTradeWindowSmall 
lsl r4, #18 
lsr r4, #18 
DontChopDurabilityTradeWindowSmall: 
ldr r3, =0x8034CE5 
bx r3 





.global IsItemDurabilityBased
.type IsItemDurabilityBased, %function 
IsItemDurabilityBased:
push {lr} 
cmp r0, #0xF7 
blt RetFalse 

RetTrue:
mov r0, #1 
b ExitIsItemDurabilityBased

RetFalse: 
mov r0, #0 

ExitIsItemDurabilityBased:

pop {r1} 
bx r1 


