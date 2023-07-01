@Hook 879C4

.thumb

.equ Table2, Table+4 
@r2 class
@r3 keep

push {r4}

ldr r1, [r3] 
ldrb r1, [r1, #4] 
ldr r0, Table2 
Loop2: 
ldrb r2, [r0] 
cmp r2, #0 
beq TryLoop
cmp r1, r2 
beq Found 
add r0, #1 
b Loop2 

TryLoop: 

ldr r2, [r3, #4] 
ldrb r0, [r2, #0x4]
ldr r4, Table

Loop:
	ldrb r1,[r4]
	cmp r1,#0x00
	beq Display_Exit

	cmp r0,r1
	beq Found

	add r4,#0x01
	b   Loop

Found:
pop {r4}
ldr r0, =0x8087930+1
bx  r0

Display_Exit:
pop {r4}
ldr r0, =0x80879CE+1
bx  r0

.align 4
.ltorg
Table:
