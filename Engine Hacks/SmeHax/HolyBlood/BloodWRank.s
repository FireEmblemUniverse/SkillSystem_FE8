.thumb
.align 4
.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

@hooks at 0x8017E72, r1=char data in rom, r4=char struct we're filling out in ram


push {r14}

ldrb r0,[r1,#4] @r0 = char ID
blh BloodTester,r3 @r0 = holy blood offset or 0, r1=major blood boolean
cmp r0,#0
b VanillaFunction

@if r1=


VanillaFunction:


GoBack:
ldr r0











.ltorg
.align
BloodTester:
@POIN HolyBloodGetter
