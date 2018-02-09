@ animation skills - defensive

.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@hooks at 80590a8 with jumptohack
cmp r1, #0
beq NoAnim
ldrh r1, [r7, #0x10]
mov r2, #0x20
mov r0, r2
and r0, r1
cmp r0, #0
beq ShowAnim
b NoAnim2

ShowAnim:
mov r0, r2
orr r0, r1
strh r0, [r7,#0x10]
mov r0, r7
blh 0x805a154
cmp r0, #0
bne End

@now we find the anim to show
ldrh r0, [r7,#0xe] @nth round of combat
sub r0, #1
lsl r0, #3 @multiply by 8
ldr     r1,=0x802aec4    @pointer to the base rounds
ldr     r1, [r1]
add r0, r1 @the nth round
ldrb r0, [r0,#4] @skill number to show
ldr r1, SkillAnimationPointerTable
lsl r0, #2
ldr r3, [r1,r0] @pointer to the skill routine to display
cmp r3, #0
bne FoundAnim
@if 0, show the default animation.
ldr r3, =0x806e58c
FoundAnim:
mov r0, r7
mov lr, r3
.short 0xf800

End:
ldr r0, =0x8059141
bx r0

NoAnim:
ldr r0, =0x80590D3
bx r0

NoAnim2:
ldr r0, =0x8059675
bx r0


.align
.ltorg
SkillAnimationPointerTable:
@POIN SkillAnimationPointerTable
