
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ gMemorySlots, 0x030004B8
.equ gAttackStruct, 0x0203A4EC
.equ gDefenseStruct, 0x0203A56C

.global SetScriptedNumbers
.type SetScriptedNumbers, %function
SetScriptedNumbers: @ Autohook at 0x080120C0.
@ Instead of running calculations for the number display, let's grab the numbers from memory slots.
@ We'll want to set damage, hit %, and crit % for each unit. That's 6 shorts. We can use 3 memory slots as parameters.
@ Since memory slot 0x1 is already used for scripted battle macros, let's use slots 0x2, 0x3, and 0x4 for hit, damage, and crit respectively.
@ The attacker's value will be in the lower short, and the defender's value will be in the higher short.
@ r7 seems to be the attacker's character struct, and r8 seems to be the defender's character struct.
@ r4 is some proc. r5 is the action struct + 0x1C. r6... may be a boolean? Haven't seen it nonzero.

push { r4 }

ldr r4, =gMemorySlots
ldr r1, =gAttackStruct
ldr r2, =gDefenseStruct

mov r3, #0x60
ldrh r0, [ r4, #0x08 ] @ Bottom halfword of memory slot 0x2. Attacker's hit.
strh r0, [ r1, r3 ]
mov r3, #0x64
strh r0, [ r1, r3 ] @ Set it in battle hit as well.
mov r3, #0x60
ldrh r0, [ r4, #0x0A ] @ Top halfword of memory slot 0x2. Defender's hit.
strh r0, [ r2, r3 ]
mov r3, #0x64
strh r0, [ r2, r3 ]

mov r3, #0x5A
ldrh r0, [ r4, #0x0C ] @ Bottom of 0x3. Attacker's damage.
strh r0, [ r1, r3 ]
ldrh r0, [ r4, #0x0E ] @ Top of 0x3. Defender's damage.
strh r0, [ r2, r3 ]

mov r3, #0x66
ldrh r0, [ r4, #0x10 ] @ Bottom of 0x4. Attacker's crit.
strh r0, [ r1, r3 ]
mov r3, #0x6A
strh r0, [ r1, r3 ] @ Set it in battle crit as well.
mov r3, #0x66
ldrh r0, [ r4, #0x12 ] @ Top of 0x4. Defender's crit.
strh r0, [ r2, r3 ]
mov r3, #0x6A
strh r0, [ r2, r3 ]

@ We also need to zero out all the other values: defense, AS, avoid, crit avoid.
mov r0, #0x00
mov r3, #0x5C
strh r0, [ r1, r3 ]
strh r0, [ r2, r3 ]
mov r3, #0x5E
strh r0, [ r1, r3 ]
strh r0, [ r2, r3 ]
mov r3, #0x62
strh r0, [ r1, r3 ]
strh r0, [ r2, r3 ]
mov r3, #0x68
strh r0, [ r1, r3 ]
strh r0, [ r2, r3 ]

pop { r4 }

@ End:
ldr r0, =gAttackStruct
add r0, r0, #0x6E
mov r1, #0x00
strb r1, [ r0 ]
ldr r0, =gDefenseStruct
add r0, r0, #0x6E
mov r1, #0x00
strb r1, [ r0 ]
mov r0, r10
lsl r0, r0, #0x18

ldr r1, =#0x080120D1
bx r1
