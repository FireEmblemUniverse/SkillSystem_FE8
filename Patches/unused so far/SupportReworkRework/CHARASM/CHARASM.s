
.thumb

.global CHAR_ASM_Hack
.type CHAR_ASM_Hack, %function
CHAR_ASM_Hack: @ Autohook to 0x0808390C. r0 = result from ASM routine.
@ If the ASM function returns 2, then this will return usable regardless of character IDs and event ID.
cmp r0, #0x02
beq ReturnTrue

@ Now vanilla stuff.
cmp r0, #0x00
beq Return @ Return false (r0 already = 0)

ldrb r0, [ r4, #0x1A ]
cmp r0, r6
beq CheckNext
	mov r0, #0x00
	cmp r6, #0x00
	bne Return @ Return false
CheckNext:
ldr r0, =#0x0808381D
bx r0

ReturnTrue:
mov r0, #0x01
Return:
pop { r4 - r7 }
pop { r1 }
bx r1
