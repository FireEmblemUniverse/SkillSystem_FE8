.thumb 
.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
@808A100  
.equ New6C, 0x8002C7C 

push {lr} 
mov r5, r1 
ldr r0, =0x808A114 @ poin Procs DrawDialog
ldr r0, [r0] 
mov r1, #3 
blh New6C 
str r4, [r0, #0x58] 
str r5, [r0, #0x5C] 

ldr r1, =SpellScrollID
lsl r1, #24 
lsr r1, #24 
mov r2, #0xFF @ id 
and r2, r4 
cmp r2, r1 
bne Skip 
lsr r4, #8 
mov r2, #10 
lsl r2, #8 
orr r4, r2 @ durability weapon with 10 durability 
str r4, [r0, #0x58] 

Skip: 

pop {r0} 
bx r0 
.ltorg 

.global ShowWepDesc2
.type ShowWepDesc2, %function 
ShowWepDesc2: 
push {lr} 
add r4, #0xF 
mov r0, #0xF0
and r4, r0 
mov r0, r6 
add r0, #0x4E 
ldrh r0, [r0] @ item 

ldr r1, =SpellScrollID
lsl r1, #24 
lsr r1, #24 
mov r2, #0xFF @ id 
and r2, r0 
cmp r2, r1 
bne Skip2 
lsr r0, #8 
mov r2, #10 
lsl r2, #8 
orr r0, r2 @ durability weapon with 10 durability 
mov r3, r6 
add r3, #0x4E @ item 
strh r0, [r3] 

Skip2: 


pop {r3} 
bx r3 
.ltorg 



