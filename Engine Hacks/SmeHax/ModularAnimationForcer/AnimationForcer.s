.thumb
.align

@57BB6 - if class is Demon King, force animations on
@DON'T FORGET THUMB BIT ON RETURN ADDRESSES
@If we do the thing, return to 0x8057BBA
@If we don't do the thing, return to 0x8057BD6

.equ ForceAnimationReturn, 0x8057BBB
.equ DontForceAnimationReturn, 0x8057BD7

@start with the things the hook overwrites

ldr r0,[r7]
ldrb r0,[r0,#4]

@start our loop
push {r1-r2}
ldr r2,AnimationForcerList
LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq False
cmp r0,r1
beq True
add r2,#1
b LoopStart

True:
pop {r1-r2}
ldr r0,[sp,#8]
ldr r1, =ForceAnimationReturn
bx r1

False:
pop {r1-r2}
ldr r0, =DontForceAnimationReturn
bx r0

.ltorg
.align

AnimationForcerList:
@POIN AnimationForcerList
