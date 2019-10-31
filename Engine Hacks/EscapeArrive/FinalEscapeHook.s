.thumb

cmp	r0,#0
beq	End

str	r1,[r0,#0xC]

@check your stuff
@if your stuff is false: branch to End

push {r0-r2}

ldr r0,=#0x03005274
mov r2,r0
ldrb r0,[r0]
mov r1,#0x4
tst r0,r1
beq GoBack

@if it is set, unset it then continue
bic r0,r1
strb r0,[r2]

pop {r0-r2}


push {r0}

mov r0,#1
orr r1,r0

pop {r0}




otherwise:
ldr	r0,[r6]
ldr	r1,[r0,#0xC]
mov	r2,#1
orr	r1,r2
str	r1,[r0,#0xC]
b End


GoBack:
pop {r0-r2}
End:
ldr	r0,[r6]
ldr	r3,=0x801849C
mov	lr,r3
.short	0xF800
pop	{r4-r6}
pop	{r0}
bx	r0

@praise leo
