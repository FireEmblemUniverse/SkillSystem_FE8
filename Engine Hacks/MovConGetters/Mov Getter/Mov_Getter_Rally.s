.thumb
.org 0x0
.equ SkillTester, AdditionalDataTable+4
.equ CelerityID, SkillTester+4
@r0=char data ptr
push {r4-r6, lr}
mov r4, r0              @Unit

@nullifycheck
mov   r1,#0x41
ldrb  r1,[r0,r1]    @AI byte 4
mov   r2,#0x20
tst   r1,r2
bne   NoMove
mov   r1,#0x30
ldrb  r1,[r0,r1] @status
mov r2, #0xf
and r1, r2
cmp r1, #9 @freeze
bne GetMov
NoMove:
mov   r5,#0x0
b   GoBack

GetMov:
ldr   r1,[r0,#0x4]
ldrb  r1,[r1,#0x12] @class mov
mov   r2,#0x1D
ldsb  r0,[r0,r2]
add   r0,r1 @total mov
mov r5, r0 @accumulator

ldr r6, AdditionalDataTable
ldrb r1, [r4 ,#0xB]     @Deployment number
lsl r1, r1, #0x3    @*8
add r6, r1          @r0 = *debuff data

@Rally Bonus
@40 bit of the 0x3 byte
ldrb r1, [r6, #0x3]
mov r0, #0x40
and r0, r1
cmp r0, #0x0
beq noMovRally
add r5, #0x1
noMovRally:

@check for Celerity
mov r0, r4
ldr r1, CelerityID
ldr r2, SkillTester
mov lr, r2
.short 0xf800
cmp r0, #0
beq GoBack
add r5, #2

GoBack:
mov r0, r5
pop {r4-r6}
pop		{r1}
bx		r1
.align
AdditionalDataTable:
@poin 203f100 probably
@POIN SkillTester
@WORD CelerityID
