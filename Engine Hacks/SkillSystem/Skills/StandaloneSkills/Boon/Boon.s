.thumb
.align 4

.equ BoonID,SkillTester+4

@check if you have boon
push {r1-r3} @don't crucify me this is the easiest way to do this since every single register is in use here
mov r0,r4
ldr	r1,BoonID
ldr	r2,SkillTester
mov	r14,r2
.short	0xF800
cmp	r0,#1
bne DecrementStatusTimer @if you don't have Boon, do vanilla

BoonEffect:
pop {r1-r3}
mov r0,#0 @otherwise, status is over
strb r0,[r1]
b GoBack

DecrementStatusTimer: @the part of the vanilla function that the hook overwrites and we return to after
pop {r1-r3}
lsr r0,r3,#4
sub r0,#1
cmp r0,#0
bne KeepStatus
strb r0,[r1]
b GoBack
KeepStatus:
lsl r0,r0,#4
orr r0,r2
strb r0,[r1]
b GoBack





GoBack:
ldrb r1,[r1]
mov r0,#0xF0

ldr r2,ReturnPoint
bx r2

.ltorg
.align 4

ReturnPoint:
.word 0x8018905
SkillTester:
@POIN SkillTester
@WORD BoonID
