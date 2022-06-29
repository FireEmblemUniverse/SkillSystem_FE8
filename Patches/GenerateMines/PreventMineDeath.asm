.thumb 
.equ CurrentUnit, 0x3004E50

.global PreventMineDeath
.type PreventMineDeath, %function 
PreventMineDeath: 
mov r0, #0xA 
strb r0, [r1, #0x15] @ trap type MINE 

ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldrb r1, [r3, #0x13] @ CurrentHP 
cmp r1, #0xA 
bgt NoCap
cmp r1, #1 
beq FloorTo0
sub r1, #1 
b Continue 

FloorTo0:
mov r1, #0 @ Deal 0 dmg / never kill 
b Continue 

NoCap: 
mov r1, #0xA 

Continue: 
mov r0, r4 
ldr r3, =0x8037591 
bx r3 
.ltorg 

.type PreventMineDeath2, %function 
.global PreventMineDeath2 
PreventMineDeath2:

ldrb r2, [r4, #0x13] @ CurrentHP 
cmp r2, #0xA 
bgt NoCap_2
cmp r2, #1 
beq FloorTo0_2
sub r2, #1 
b Continue_2

FloorTo0_2:
mov r2, #0 @ Deal 0 dmg / never kill 
b Continue_2 

NoCap_2: 
mov r2, #0xA 

Continue_2: 
neg r2, r2 
mov r3, #1 
neg r3, r3 

ldr r1, =0x80375AD 
bx r1 
.ltorg 





