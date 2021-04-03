
/*
Additional Data Format: 0x0203F100, indexed by allegiance byte
0-2: Debuffs, 4 bits each (str/skl/spd/def/res/luk)
3: Rallys (bit 7 = rally move, bit 8 = rally spectrum)
4: Str/Skl Silver Debuff (5 bits), bit 6 = half magic?, bit 7 = half strength, HO bit = Hexing Rod
5: (RallyMag<<4)||MagDebuff
6: LO Nibble = Dual Guard Meter?
7: unused3
*/

.thumb
.global prDebuffMag
.type prDebuffMag, %function
prDebuffMag:
push { r4 - r6, lr }
mov r5, r0 @ Stat
mov r4, r1 @ Unit ... @ Are the comments for the other debuff functions wrong...?

mov r0,r4
ldr r6, =MagDebuffTableLink
ldr r6, [ r6 ]
mov lr, r6
.short 0xF800
mov r6, r0
@ @ Get the magic debuff from the bottom 4 bits of byte 5 of the debuff table.
@ ldrb r0, [ r4, #0x0B ] @ Allegiance byte.
@ lsl r0, r0, #0x03 @ Multipy by 8.
@ add r6, r0, r6 @ r6 = this DebuffTable entry.

@Mag/2 Debuff NOTE TO SELF: off of base only.
ldr r2, [r6, #0x4]
mov r1, #0x20
and r2, r1
cmp r2, #0x0
beq noHalfMag
lsr r2, r5, #0x1F
add r5, r2
asr r5, #0x1            @Signed divide by two.
noHalfMag:

ldrb r0, [ r6, #0x05 ]
mov r1, #0x0F
and r0, r0, r1 @ r0 = isolated debuff value.

sub r0, r5, r0 @ r0 = altered stat.
pop { r4 - r6, pc }

.global prRallyMag
.type prRallyMag, %function
prRallyMag:
push { r4 - r6, lr }
mov r5, r0 @ Stat
mov r4, r1 @ Unit
mov r0,r4
ldr r6, =MagDebuffTableLink
ldr r6, [ r6 ]
mov lr, r6
.short 0xF800
mov r6, r0
@ ldrb r0, [ r4, #0x0B ] @ Allegiance byte.
@ lsl r0, r0, #0x03 @ Multipy by 8.
@ add r6, r0, r6 @ r6 = this DebuffTable entry.
@ Rally mag is at the 5th byte at the 5th bit
ldrb r0, [ r6, #0x05 ]
mov r1, #0x10 @ 10000b
tst r0, r1
beq NoRallyMag
	add r5, r5, #0x04
NoRallyMag:
ldrb r0, [ r6, #0x03 ]
mov r1, #0x80
tst r0, r1
beq NoRallySpectrum
	add r5, r5, #0x02
NoRallySpectrum:
mov r0, r5
pop { r4 - r6, pc }
