@Hook 1C92C

.thumb
.equ Table2, Table+4 

cmp r0, #0 
beq Found 
ldr r1, [r0] 
cmp r1, #0 
beq Found 
ldrb r1, [r1, #4] 
ldr r3, Table2 
Loop2: 
ldrb r2, [r3] 
cmp r2, #0 
beq TryLoop
cmp r1, r2 
beq Found 
add r3, #1 
b Loop2 

TryLoop: 
ldr r0, [r0, #4] 
@r0 class id
ldrb r0, [r0, #0x4]
ldr r3, Table

Loop:
	ldrb r1,[r3]
	cmp r1,#0x00
	beq Display_Exit

	cmp r0,r1
	beq Found

	add r3,#0x01
b   Loop

Found:
mov r0, #0x0
b   Exit

Display_Exit:
mov r0 , #0x1

Exit:
pop {r1}
bx r1

.align 4
.ltorg
Table:
