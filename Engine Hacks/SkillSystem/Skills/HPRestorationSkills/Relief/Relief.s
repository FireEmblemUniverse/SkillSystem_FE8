.thumb
.align


.global Relief
.type Relief, %function



Relief:
push {r4-r5,r14}
mov r4,r0 @r4 = unit
mov r5,r1 @r5 = heal %

ldr r0,=SkillTester
mov r14,r0
mov r0,r4
ldr r1,=ReliefIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#0
beq GoBack

  @check for allies in range:
  ldr r0, =AuraSkillCheck
  mov lr, r0
  mov r0, r4 @unit
  mov r1, #0 @always true
  mov r2, #0 @same_team
  mov r3, #2 @range
  .short 0xf800
  cmp r0, #0
  bne GoBack
    @if no allies in range, heal 20%
    add r5, #20

GoBack:
mov r0,r5
pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align


