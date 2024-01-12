.thumb 




.global NoDefenderHook1
.type NoDefenderHook1, %function 
NoDefenderHook1: 
mov r7, r10 
ldr r0, [r7] 
cmp r0, #0 
beq Exit1 
ldrb r0, [r0, #4] 
sub r0, #1 
ldr r3, =0x8057451 
bx r3 
.ltorg 

Exit1: 
mov r1, #0 
mov r2, #3 @ this is what is in r2 if it read 0x0 as an address  
mov r3, #0 
ldr r0, =0x8057469 
bx r0 
.ltorg 

.global NoDefenderHook2
.type NoDefenderHook2, %function 
NoDefenderHook2: 
ldr r0, [r2, #4] 
cmp r0, #0 
beq Exit2 
cmp r0, #0x3C @ is defender manakete? are they holding a sleep staff? (what?) 
bne Exit2 
ldr r3, =0x8057B05 
bx r3 
.ltorg 


Exit2: 
ldr r3, =0x8057B15 
bx r3 
.ltorg 

.global NoDefenderHook3
.type NoDefenderHook3, %function 
NoDefenderHook3: 
ldr r0, [r5, #4] 
cmp r0, #0 
beq Exit3 
ldrb r0, [r0, #4] @ class ID 
cmp r0, #0x3C 
bne Exit3 
ldr r3, =0x8057B39 
bx r3 
.ltorg 
Exit3: 
ldr r3, =0x8057B49 
bx r3 
.ltorg 

.global NoDefenderHook4
.type NoDefenderHook4, %function 
NoDefenderHook4: 
ldr r0, [r1, #4] 
cmp r0, #0 
beq Exit4 
ldrb r0, [r0, #4] @ class id 
cmp r0, #0x3C 
bne Exit4 
ldr r3, =0x8057B6D 
bx r3 
.ltorg 

Exit4: 
mov r2, r9 
ldr r3, =0x8057B7D 
bx r3 
.ltorg 

.global NoDefenderHook5
.type NoDefenderHook5, %function 
NoDefenderHook5: 
mov r3, r10 
ldr r0, [r3, #4] 
cmp r0, #0 
beq Exit5 
ldrb r0, [r0, #4] 
cmp r0, #0x3C 
bne Exit5 
ldr r3, =0x8057B9D 
bx r3 
.ltorg 

Exit5: 
ldr r5, [sp, #0x20] 
ldr r3, =0x8057BAD 
bx r3 
.ltorg 

.global NoDefenderHook6
.type NoDefenderHook6, %function 
NoDefenderHook6: 
mov r3, #0xC0 
and r1, r3 
ldr r0, [r2, #0x14] 
cmp r0, #0 
beq Exit6 
ldrb r0, [r0, #0x0B] 
and r0, r3 
mov r7, r2 
ldr r3, =0x807ABFD
bx r3 
.ltorg 
Exit6: 
ldr r3, =0x807AC1D 
bx r3 
.ltorg 

.global NoDefenderHook7
.type NoDefenderHook7, %function 
NoDefenderHook7: @ [0x30049DC]!!
mov r5, r1 
cmp r0, #0 
beq Exit7 
ldr r2, [r0] 
cmp r2, #0 
beq Exit7 
ldr r0, [r2, #4] 
ldrb r0, [r0, #4] @ class ID 
ldr r3, =0x807AC2D 
bx r3 
.ltorg 

Exit7: 
mov r0, #0x28 @ this is what r0 would be if the game reads the address 0 as a pointer a few times 
ldr r3, =0x807AC2D 
bx r3 
.ltorg 

// 2y +xy < 1634 
@ 0x7B8 
@ 47x31 map 
@ 49x35 buffer 
@ 35 * 4 bytes = 140 / #0x8C 
@ 49*35 = 1715 / 0x6B3 




