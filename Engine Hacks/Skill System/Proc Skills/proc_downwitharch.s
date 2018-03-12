@this is just an edited version of proc_lethality.s
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ DownWithArchID, SkillTester+4
.equ d100Result, 0x802a52c
@ r0 is attacker, r1 is defender, r2 is current buffer, r3 is battle data
push {r4-r7,lr}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data
ldr     r0,[r2]           @r0 = battle buffer                @ 0802B40A 6800     
lsl     r0,r0,#0xD                @ 0802B40C 0340     
lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40     
mov r1, #0xC0 @skill flag
lsl r1, #8 @0xC000
add r1, #2 @miss
tst r0, r1
bne End
@if another skill already activated, don't do anything

ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, DownWithArchID
.short 0xf800
cmp r0, #0x00
beq End

@check enemy name
CheckName:
ldr	r0,[r5]
ldrh	r0,[r0]
ldr	r1,=#0x815D48C
lsl	r0,#2
add	r0,r1
ldr	r0,[r0]
ldrb	r1,[r0]
cmp	r1,#0x41
bne	End
ldrb	r1,[r0,#1]
cmp	r1,#0x72
bne	End
ldrb	r1,[r0,#2]
cmp	r1,#0x63
bne	End
ldrb	r1,[r0,#3]
cmp	r1,#0x68
bne	End

@set lethality chance, just in case
mov	r0,#0x6C
ldrb	r1,[r4,r0]
mov	r1,#0x64
strb	r1,[r4,r0]

@if we proc, set offensive skill flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0, #0x40
lsl     r0, #8           @0x4000, attacker skill activated
orr     r1, r0
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018  

ldrb  r0, DownWithArchID
strb  r0, [r6,#4] 

@if we proc, set the lethality flag
ldr     r3,[r6]    
lsl     r1,r3,#0xD                @ 0802B4D0 0359     
lsr     r1,r1,#0xD                @ 0802B4D2 0B49     
mov     r0,#0x80                @ 0802B4D4 2080     
lsl     r0,r0,#0x4  @ 0x800, lethality flag     @ 0802B4D6 0100     
orr     r1,r0                @ 0802B4D8 4301     
ldr     r2,=#0xFFF80000                @ 0802B4DA 4A0A     
mov     r0,r2                @ 0802B4DC 1C10     
and     r0,r3                @ 0802B4DE 4018     
orr     r0,r1                @ 0802B4E0 4308     
str     r0,[r6]                @ 0802B4E2 6020  

mov	r5,#0x7F
strh    r5,[r7,#0x4]                @ 0802B4E6 80A8  

ldr     r3,[r6]                @ 0802B4E8 6823     
lsl     r0,r3,#0xD                @ 0802B4EA 0358     
lsr     r0,r0,#0xD                @ 0802B4EC 0B40     
ldr     r1,=#0xFFFF7FFF                @ 0802B4EE 4906     
and     r0,r1                @ 0802B4F0 4008     
and     r2,r3                @ 0802B4F2 401A     
orr     r2,r0                @ 0802B4F4 4302     
str     r2,[r6]                @ 0802B4F6 6022       

End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD DownWithArchID
