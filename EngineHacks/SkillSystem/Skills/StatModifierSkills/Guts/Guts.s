.thumb 

.type StrongCon, %function 
.global StrongCon 
StrongCon: 
push {r4-r5, lr} 
mov r4, r0 @ stat value
mov r5, r1 @ unit 

mov r0, r5 
ldr r1, =StrongConID_Link 
ldr r1, [r1] 
bl SkillTester 
cmp r0, #0 
beq Exit

mov r3, #0x30 
ldrb r2, [r5, r3] @ status 
cmp r2, #0 
beq Exit 
ldr r3, =StrongConAmount_Link 
ldr r3, [r3] 
add r4, r3 
Exit: 
mov r0, r4 @ value 
mov r1, r5 @ unit 
pop {r4-r5} 
pop {r2} 
bx r2 
.ltorg


.type Guts, %function 
.global Guts 
Guts: 
push {r4-r5, lr} 
mov r4, r0 @ stat value
mov r5, r1 @ unit 

mov r0, r5 
ldr r1, =GutsID_Link 
ldr r1, [r1] 
bl SkillTester 
cmp r0, #0 
beq Exit2

mov r3, #0x30 
ldrb r2, [r5, r3] @ status 
cmp r2, #0 
beq Exit2 
ldr r3, =GutsAmount_Link 
ldr r3, [r3] 
add r4, r3 
Exit2: 
mov r0, r4 @ value 
mov r1, r5 @ unit 
pop {r4-r5} 
pop {r2} 
bx r2 
.ltorg


