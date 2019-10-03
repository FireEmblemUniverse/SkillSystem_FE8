.thumb
.align 4

push {r14}


ldr	r0,=#0x800D07C		@event engine thingy
mov	lr, r0
ldr	r0, EscapeEvent	@the text part
mov	r1, #0x01		@0x01 = wait for events
.short	0xF800

@grab action struct 
ldr r0,=#0x203A958

@set X coord in action struct (+0x0E)
@mov r1,#0xFF
@strb r1,[r0,#0xE]

@set last used command to Wait
mov r1,#1
strb r1,[r0,#0x11]


pop {r0}
bx r0

.ltorg
.align 4
EscapeEvent:



@praise uhh whoever wrote despoil
