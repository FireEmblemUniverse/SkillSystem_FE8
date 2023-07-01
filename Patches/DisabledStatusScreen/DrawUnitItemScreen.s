@Hook 874AC

.thumb
.equ Table2, Table+4 
@r0 class
@r1 !keep (unit struct) 
@r2 !keep
@r3 temp
@r7 temp

ldr r0, [r1] 
ldrb r0, [r0, #4] 
ldr r7, Table2 
Loop2: 
ldrb r3, [r7] 
cmp r3, #0 
beq TryLoop
cmp r0, r3 
beq Found 
add r7, #1 
b Loop2 

TryLoop: 

ldr r0, [r1, #4] 
ldrb r3, [r0, #0x4]
ldr r7, Table

Loop:
	ldrb r0,[r7]
	cmp r0,#0x00
	beq Display_Exit

	cmp r0,r3
	beq Found

	add r7,#0x01
	b   Loop

Found:
ldr r0, =0x08087532 + 1
bx  r0

Display_Exit:
ldr r0, =0x080874B6 + 1
bx  r0

.align 4
.ltorg
Table:
