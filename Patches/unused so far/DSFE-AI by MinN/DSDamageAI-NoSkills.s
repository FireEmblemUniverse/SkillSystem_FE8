.thumb
.org 0x0
@jumpToHack here from 3DF38

@ returns the TP(Target Priority) for damage
@ TP = if kill 0xFF + combat hit
@           if provoke 0xF8
@               TP = Damage x Number of Attacks x (Hit >= 30 ? 1 : Hit/128) x (Crit >= 10 ? 3 : 1) x 4, capped at 0xF0

push   {r4-r7}


ldr r4, Attacker
ldr r5, Defender

@ if kill, end
mov r0, #0x13
ldsb r0, [r5, r0]
cmp r0, #0x0
bne NotKill
    mov r6, #0xFF
    mov r0, #0x64   @combat hit
    ldrsh r0, [r4, r0]
    add r6, r0
    b End
NotKill:

mov r0, #0x5A       @attack
ldrsh r6, [r4, r0]   @r6 is damage

@ luna check
mov r1, #0x4c
ldr r0, [r5,r1]
mov r2, #0x2
lsl r2, #0x10
tst r0, r2
bne NegateDefense
    mov r1, #0x5C       @defense
    ldrsh r1, [r5, r1]
    sub r6, r1
NegateDefense:

ASCheck:
mov r0, #0x5E       @as
ldrsh r0, [r4, r0]
mov r1, #0x5E       @as
ldrsh r1, [r5, r1]
add r1, #4
cmp r0, r1
blt NotPursuit
    lsl r6, #1
NotPursuit:

@ brave check
mov r1, #0x4c
ldr r0, [r4,r1]
mov r2, #0x20
tst r0, r2
beq NotBrave
    lsl r6, #1
NotBrave:

@crit stuff 
@3x TP if crit above 10
mov r0, #0x6A
ldrsh r0, [r4, r0] @battle crit
cmp r0, #10 @ 10% crit causes AI to go for crit damage, change this to whatever you want or disable it 
blt NotCrit
    mov r1, r6
    lsl r1, #1
    add r6, r1 @x3
NotCrit:

@ hit calc
mov r0, #0x64   @combat hit
ldrsh r0, [r4, r0]

@ avoid stuff, if < 30 displayed hit, damage * hit/128, aka >> 7, not super relevant in normal ds games as you can imagine
cmp r0, #30
bge HighHit
    mul r6, r0
    lsr r6, #7 @ div by 128 for dramatic effect
HighHit:

lsl r6, #1  @ this ensures 1 damage difference gives 2 TP
            @ greater than no counter that gives 1
cmp r6, #0x0
bge NotNeg
    mov r6, #0x0
NotNeg:

@Set TP cap to 0xF0
cmp   r6,#0xF0
ble   NotCapped
    mov   r6,#0xF0
NotCapped:

End:
mov   r0,r6 @r0 is return value

pop   {r4-r7}
pop   {r4}
pop   {r1}
bx    r1

.align
Attacker:
.long 0x0203A4EC
Defender:
.long 0x0203A56C
