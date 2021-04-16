
@ $802BA28 - $802BBFC: Check for leveling up, does level up.
@ $802BB26 seems to be the final stat level up calculation (except con?). Done with con at $802BB3E
@ Level up data (of action struct) for attacker starts at $0203A55F and $0203A5DF for defender.
@ It seems that at some point after my routine, another routine checks the growths and sets level up values back to 0 if the growths are 0... 0x0802BB5A... weird. It seems to be different from the other routine that sets growths.
@ Seems to branch to the stupid 0x0802BB5A at 0x0802BBDE.

@ Placing the hook at 0x0802BBF0. This would probably avoid hitting that stupid routine.

.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.global LevelUp
.type   LevelUp, %function

@ Battle struct offset in r7.

LevelUp:
push { r4 }
cmp r0, #200
blt End @ Due to the nature of the routine this hooks to, not level ups also fall into here. This skips this if there was no level up.

ldr r4, [ r7, #0x4 ] @ r4 has pointer to class data
@ First, we need to figure out if all stats are maxed.
ldrb r1, [ r4, #19 ] @ Max HP
ldrb r0, [ r7, #0x12 ] @ Current Max HP
cmp r0, r1
blt EndLoop @ HP is not maxed
ldrb r0, [ r7, #0x19 ] @ Current luck
cmp r0, #30
blt EndLoop @ Luck is not maxed

mov r0, #0x00
MaxLoop:
cmp r0, #0x06
beq End @ All stats are maxed. Wow
mov r1, r0
add r1, #20
ldrb r2, [ r4, r1 ] @ Get this stat's max.
mov r1, r0
add r1, #0x14
ldrb r3, [ r7, r1 ] @ This unit's stat.
add r0, #0x01
cmp r2, r3
beq MaxLoop @ This stat is maxed. Keep checking for all stats being maxed.

EndLoop:
mov r0, r7
mov r1, #0x73
ldrb r2, [ r0, r1 ]
cmp r2, #0x00
bne End @ Leave if HP is growing
mov r1, #0x74
add r0, r1
ldmia r0!, { r1, r2 }
cmp r1, #0x00
bne End
lsl r2, #0x08 @ Take off the WEXP multiplier byte at the end
cmp r2, #0x00
bne End

GetRN: @ 0 = HP growth, 1 = str, 2 = skl, 3 = spd, 4 = def, 5 = res, 6 = luk, 7 = can't use
blh #0x08000C81, r0
lsl r0, #29
lsr r0, #29 @ I only care about that last byte. This gets rid of all of that junk at the beginning. This also makes it a max of 7.
cmp r0, #0x7
bgt GetRN @ Returned a 7. I don't want this, so get another RN.
cmp r0, #0x00
bne NotHP
	ldrb r3, [ r4, #19 ]
	ldrb r2, [ r7, #0x12 ]
	cmp r2, r3
	beq GetRN @ HP is maxed. Try again.
NotHP:
cmp r0, #0x06
bne NotLuck
	ldrb r2, [ r7, #0x19 ]
	cmp r2, #30
	beq GetRN @ Luck is maxed. Try again.
NotLuck:
mov r1, r0
add r1, #20
ldrb r2, [ r4, r1 ] @ Get this stat's max.
mov r1, r0
add r1, #0x13
ldrb r3, [ r7, r1 ] @ This unit's stat.
cmp r2, r3
beq GetRN @ This stat is maxed. Try another RN.

mov r1, #0x73
add r0, r1
mov r2, #0x01
strb r2, [ r7, r0 ]

End:
pop { r4 }
pop { r3 - r5 }
mov r8, r3
mov r9, r4
mov r10, r5
pop { r4 - r7 }
pop { r0 }
bx r0
