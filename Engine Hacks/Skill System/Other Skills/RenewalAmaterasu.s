.thumb
.equ RenewalID, SkillTester+4
.equ AuraSkillCheck, RenewalID+4
.equ AmaterasuID, AuraSkillCheck+4
.equ CamaraderieID, AmaterasuID+4
.equ ReliefID, CamaraderieID+4
.equ BondID, ReliefID+4

push {r4, lr}
ldr r1, Some_Offset
add r0, r0, r1
ldrb r0, [r0]
lsl r0, r0, #0x18
asr r4, r0, #0x18
@That much is copy-paste from vanilla.
@It loads %HP to heal from terrain into r4

@Now check for Renewal skill

ldr r0, SkillTester
mov lr, r0
mov r0, r5
ldr r1, RenewalID
.short 0xf800
cmp r0, #0x0
beq no_renewal
 @add hp
 add r4, #30
no_renewal:

@Now check for Amaterasu
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r5 @unit
ldr r1, AmaterasuID
mov r2, #0 @same_team
mov r3, #2 @range
.short 0xf800
cmp r0, #0
beq no_amaterasu
add r4, #20 @heal 20% hp

no_amaterasu:

@Now check for Camaraderie
ldr r0, SkillTester
mov lr, r0
mov r0, r5
ldr r1, CamaraderieID
.short 0xf800
cmp r0, #0x0
beq no_camaraderie
  @check for allies in range:
  ldr r0, AuraSkillCheck
  mov lr, r0
  mov r0, r5 @unit
  mov r1, #0 @always true
  mov r2, #0 @same_team
  mov r3, #2 @range
  .short 0xf800
  cmp r0, #0
  beq no_camaraderie
    @if allies in range, heal 10%
    add r4, #10

no_camaraderie:

@check for relief
ldr r0, SkillTester
mov lr, r0
mov r0, r5
ldr r1, ReliefID
.short 0xf800
cmp r0, #0x0
beq no_relief
  @check for allies in range:
  ldr r0, AuraSkillCheck
  mov lr, r0
  mov r0, r5 @unit
  mov r1, #0 @always true
  mov r2, #0 @same_team
  mov r3, #2 @range
  .short 0xf800
  cmp r0, #0
  bne no_relief
    @if no allies in range, heal 20%
    add r4, #20

no_relief:

@Now check for bond
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r5 @unit
ldr r1, BondID
mov r2, #0 @same_team
mov r3, #3 @range
.short 0xf800
cmp r0, #0
beq no_bond
add r4, #10 @heal 10% hp

no_bond:

mov r0, r4 @return the amount healed.
pop {r4}
pop {r1}
bx r1
.align
Some_Offset:
.long 0x880C744
SkillTester:
@POIN SkillTester
@WORD RenewalID
@POIN AuraSkillCheck
@WORD AmaterasuID
@WORD CamaraderieID
@WORD ReliefID
@WORD BondID
