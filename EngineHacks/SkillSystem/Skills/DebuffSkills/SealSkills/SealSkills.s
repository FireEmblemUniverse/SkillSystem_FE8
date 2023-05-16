@hook at 802c088 with jumptohack
.thumb
.equ SealSkillList, SkillTester+4
.equ ExtraUnitData, SealSkillList+4
.equ ItemTableLocation, ExtraUnitData+4 @dont forget to add this to the master skill installer
.equ FullMetalBodyID, ItemTableLocation+4
.equ DebuffTableLocation, FullMetalBodyID+4
.equ DebuffAmount, 8

mov r1,r5
ldr r3, =0x802c1ec @UpdateUnitFromBattleUnit
mov lr, r3
.short 0xf800
cmp r6, #0
beq loc_2c0a4

mov r0, r6
mov r1, r4
ldr r3, =0x802c1ec @UpdateUnitFromBattleUnit
mov lr, r3
.short 0xf800
b ApplySeals

loc_2c0a4:
ldr r0, =0x802c984 @SaveSnagWallFromBattle
mov lr, r0
mov r0, r4
.short 0xf800



ApplySeals:

@check if either one of us are dead
ldrb r0,[r5,#0x13]
cmp r0,#0
beq End
ldrb r0,[r4,#0x13]
cmp r0,#0
beq End

@first apply the weapon debuffs
@r5 = attacker
@r4 = defender
mov r0, r5
mov r1, r4
bl ApplyWeaponDebuffs @ in SetDebuffs.s 
mov r0, r4
mov r1, r5
bl ApplyWeaponDebuffs


ldr r4, SealSkillList
mov r5, #0
SealLoop:
	@check for FullMetalBody
	ldr	r1,FullMetalBodyID
	mov	r0,r7
	ldr	r2,SkillTester
	mov	lr,r2
	.short	0xf800
	cmp	r0,#1
	beq	OtherSide
  ldrb r1, [r4,r5] @nth skill
  mov r0, r6 @defender
  ldr r2, SkillTester
  mov lr, r2
  .short 0xf800
  cmp r0, #0
  beq OtherSide
    @if defender has a seal skill, apply to the attacker.
    mov r0, r7
	ldr r1, =DebuffAmount 
	ldr r1, [r1] 
    mov r2, r5 @nth seal
    bl ApplyDebuff
  OtherSide:
	@check for FullMetalBody
	ldr	r1,FullMetalBodyID
	mov	r0,r6
	ldr	r2,SkillTester
	mov	lr,r2
	.short	0xf800
	cmp	r0,#1
	beq	NextLoop
  ldrb r1, [r4,r5] @nth skill
  mov r0, r7 @attacker
  ldr r2, SkillTester
  mov lr, r2
  .short 0xf800
  cmp r0, #0
  beq NextLoop
    @if attacker has a seal skill, apply to the defender
    mov r0, r6
	ldr r1, =DebuffAmount 
	ldr r1, [r1] 
    bl ApplyDebuff
  NextLoop:
  add r5, #1
  cmp r5, #6 @ Expanded to 6 to compensate for SealMag
  ble SealLoop

End:
pop {r4-r7}
pop {r0}
bx r0
.ltorg

ApplyDebuff:
@r0 is unit data, r1 is amount, r2 is nth stat
push {r4-r5, lr}
@ r0 = unit 
mov r4, r1
mov r5, r2
bl GetUnitDebuffEntry @ r0 = unit struct 

lsl r3, r5, #2 @ 4 bytes per 
ldr r1, =SealDebuffIndex @ table of POINs 
add r1, r3 
ldr r1, [r1] @ address of the debuff offset 
ldr r1, [r1] @ debuff offset 
mov r3, r4 @ value 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
 
@ given r0 = address, r1 = bit offset, r2 = number of bits, r3 = data to store
bl PackData 

EndApplyDebuff:
pop {r4-r5}
pop {r0} 
bx r0 
.ltorg 

BXR3:
bx r3

.align
.ltorg
SkillTester:
@POIN SkillTester
@POIN SealSkillList (str/skl/spd/def/res/luk)
@POIN ExtraUnitData
@POIN ItemTableLocation
@WORD FullMetalBodyID
