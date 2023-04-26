.thumb 
.equ ProvokePlusID, SkillTester+4 


ldr r0, SkillTester 
mov lr, r0 
ldr r0, =0x203A56C @ dfdr 
ldr r1, ProvokePlusID 
.short 0xf800 @ blh 
cmp r0, #1 
beq ReturnTrue 

ldr r3, =0x203A56C @ dfdr 
mov r0, #0x13 
ldsb r0, [r3, r0] 
mov r1, #50 @ lethal gets a priority bonus of 50 
cmp r0, #0 
beq Lethal
ldr r1, =0x803DF49 
bx r1 
.ltorg 

ReturnTrue: 
mov r1, #0xFF 
lsl r1, #8 @ 0xFF00 priority lol 
Lethal: 
ldr r2, =0x803DF85 
bx r2 
.ltorg 
.align 
SkillTester: 
