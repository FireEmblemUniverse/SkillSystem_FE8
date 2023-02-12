.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ ActionData, 0x203A958 
.global HoardersBane
.type HoardersBane, %function 
HoardersBane: 
push {r4-r5, lr} 
mov r4, r0 @ parent proc 

mov r0, #2 
blh  0x0800BC50   @GetUnitFromEventParam	{U}
mov r5, r0 @ unit 

ldrb r1, [r0, #0x0B] @ deployment byte 
ldr r2, [r4, #0x34] @ end of what phase 
mov r3, #0xC0 
and r1, r3 
cmp r2, r1 
bne HoardersBane_False 


mov r1, #5 
strb r1, [r0, #0x13] @ current hp 
ldrb r1, [r0, #0x0B] @ deployment byte 
ldr r2, =ActionData 
strb r1, [r2, #0x0C] @ deployment byte 



ldr  r3, =0x30004B8	@MemorySlot	{U}
mov r0, #2 
str r0, [r3, #4] 
mov r0, #18 
str r0, [r3, #4*6] @ slot6 HealValue 
@blh ASMC_HealLikeVulnerary

mov r0, #2 
blh  0x0800BC50   @GetUnitFromEventParam	{U}
@mov r1, #23 
@strb r1, [r0, #0x13] @ current hp 
ldr r0, =0x03004E50
str r5, [r0] 




HoardersBane_True: 
mov r0, #1 @ has a child proc 
b ExitHoardersBane 
HoardersBane_False: 
mov r0, #0 @ skipped this time 

ExitHoardersBane: 
pop {r4-r5} 
pop {r1} 
bx r1
.ltorg 
