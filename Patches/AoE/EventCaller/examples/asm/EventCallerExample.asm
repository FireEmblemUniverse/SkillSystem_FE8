.thumb
.macro blh to,reg=r4
	push {\reg}
	ldr \reg,=\to
	mov r14,\reg
	pop {\reg}
	.short 0xF800
.endm


.global NewActionWait
.type   NewActionWait, function

@ From 0x80320D9 of FE8U
NewActionWait:
	mov		r0, r4
	ldr		r1, =pEventWait
	blh		EventCaller	 @ (Proc* proc, u32* EventDef)

	ldr		r0, =0x80320D9
	bx		r0

