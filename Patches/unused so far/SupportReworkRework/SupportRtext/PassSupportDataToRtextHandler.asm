.thumb

.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ New6C, 0x08002c7c

/*

to get our support data we'll need to patch somewhere in the 88f48 range.
what do 89210, 8a118 do?
  -89210 just sets position/dimensions in vram, dont touch it
  -8a118 just cleans up any existing procs we're about to create.
for 8a0fc we shuld pass in either the original proc itself, or the support data from it.
  -probably just redo that whole function tbh since we need to store the support data (pass in r2)
  -if we patch at 88f50 and return at 88f5c it can probably be done.
*/

@proc storage +5c shouldn't be more than 2? (passed in at r1)
@when its not breaking it loads the current text buffer from +3c

@proc parent is passed in as arg0 where the getter/looper func is called via r1
@rtext data pointer is passed as arg0 to HelpDialog, which is stored as r5 (r4 is proc address of new HelpDialog)
@at 88f0c, r0 is rtext stringID or slotID, which is stored to +4c.
@then, 0x18 of Rtext data is loaded (getter func), and if not 0 is called via r1 with proc as arg0 at 88f1a

@89e58 is where the problem happens
@so it's actually a different proc... a01628
@proc id keeps switching from 20253e4 and 202515c... looks like +5c is actually just not getting cleared out
@the +5c addresses are 2025440 and 20251b8
@modified at 8a008 (8a074 specifically, by pulling from 0x64 of the opposite proc)
@ +64 addrs: 2025448 / 20251c0

@hook at 88f50
ldrh r0, [r7]	@ +4e
ldrh r1, [r6]	@ +4c
mov r2, r4
bl CreateNewHelpBubbleProc
ldr r0, =0x0203e784
str r5, [r0]

ReturnToFunc:
ldr r1, =0x08088f5d
bx r1

.ltorg
.align

//0x29, 0x2a, 0x2b store unitID1, unitID2, and support total

CreateNewHelpBubbleProc:
push {r4-r7, lr}
mov r4, r0
mov r5, r1
mov r6, r2

add r2, #0x29
ldrb r0, [r2]				@unit 1
add r2, #0x1
ldrb r1, [r2]				@unit 2
lsl r1, r1, #0x8
orr r0, r1
add r2, #0x1
ldrb r2, [r2]				@point total
lsl r2, r2, #0x10
orr r0, r2
mov r7, r0

ldr r0, =0x08a01650			@helptext proc
mov r1, #0x3
blh New6C

str r4, [r0, #0x58]			@old proc's 4e
str r5, [r0, #0x5c]			@old proc's 4c

mov r4, r0
add r4, #0x29
mov r5, r0
add r5, #0x2a
mov r6, r0
add r6, #0x2b				@theres probably a more efficient way to do this but its 3 am and idrc anymore

strb r7, [r4]
lsr r7, r7, #0x8
strb r7, [r5]
lsr r7, r7, #0x8
strb r7, [r6]

pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align
