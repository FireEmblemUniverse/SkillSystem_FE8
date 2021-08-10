.thumb

.global ReturnOne
.global IsEirika
.global GetChapterMode
.global IsOnPrepScreen
.global IsInChapter

ReturnOne:
mov		r0,#1
bx		r14


IsEirika:
mov		r0,#0
ldr		r1,=#0x3004E50
ldr		r1,[r1]
ldr		r1,[r1]
ldrb	r1,[r1,#4]
cmp		r1,#1
bne		Label1
mov		r0,#1
Label1:
bx		r14
.ltorg


GetChapterMode:
@ returns [gChapterData+0x1B]-1 (0 for prologue-ch8, 1 for eirika route, 2 for ephraim route, in vanilla FE8)
ldr		r0,=#0x202BCF0		@ gChapterData
ldrb	r0,[r0,#0x1B]
sub		r0,#1
bx		r14
.ltorg


IsOnPrepScreen:
mov		r0,#0
ldr		r1,=#0x202BCF0		@ gChapterData
ldrb	r1,[r1,#0x14]
mov		r2,#0x10			@ prep screen bit
tst		r1,r2
beq		End_IsOnPrepScreen
mov		r0,#1
End_IsOnPrepScreen:
bx		r14
.ltorg


IsInChapter:
mov		r0,#0
ldr		r1,=#0x202BCF0		@ gChapterData
ldrb	r1,[r1,#0x14]
mov		r2,#0x10			@ prep screen bit
tst		r1,r2
bne		End_IsInChapter
mov		r0,#1
End_IsInChapter:
bx		r14
.ltorg
