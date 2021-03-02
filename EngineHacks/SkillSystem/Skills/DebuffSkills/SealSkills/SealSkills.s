@hook at 802c088 with jumptohack
.thumb
.equ SealSkillList, SkillTester+4
.equ ExtraUnitData, SealSkillList+4
.equ ItemTableLocation, ExtraUnitData+4 @dont forget to add this to the master skill installer
.equ FullMetalBodyID, ItemTableLocation+4
.equ DebuffTableLocation, FullMetalBodyID+4
.equ DebuffAmount, 6

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
bl ApplyWeaponDebuffs
mov r0, r4
mov r1, r5
bl ApplyWeaponDebuffs

@ @just gonna... zero out the attack command flag here...
@ @as a safety measure
@ ldr r0, =0x203f101
@ mov r1, #0
@ strb r1, [r0]

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
    mov r1, #DebuffAmount
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
    mov r1, #DebuffAmount
    mov r2, r5
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
push {r4-r7, lr}
mov r4, r0
mov r5, r1
mov r6, r2
ldr r3, ExtraUnitData
bl BXR3
mov r7,r0
@ ldr r7, ExtraDataLocation
@ ldrb r0, [r4, #0xB]
@ lsl r0, #0x3        @8 bytes per unit
@ add r7, r0          @r7 = &extra data
@ Okay right here let's see if it's trying to apply a magic debuff
cmp r6, #0x06
bne ApplyDebuffNotMag
	@ Magic works as the 5th byte in the DebuffTable. (RallyMag<<4)||MagDebuff
	ldrb r0, [ r7, #0x05 ] @ Current extra magic byte
	mov r1, #0x0F
	and r0, r0, r1 @ r0 = isolated current debuff
	cmp r0, r5
	bge EndApplyDebuff
	ldrb r0, [ r7, #0x05 ]
	mov r1, #0xF0
	and r0, r0, r1 @ r0 = all bits of extra magic byte EXCEPT the debuff
	orr r0, r0, r5 @ r0 = new extra magic byte with updated debuff
	strb r2, [ r7, #0x05 ]
	b EndApplyDebuff
ApplyDebuffNotMag:
@now r7 has the location of the extra data, load up the appropriate debuff
ldr r0, [r7]
lsl r0, #8
lsr r0, #8 @strip the top byte
lsl r1, r6, #2 @r1 = n*4 (4 bits per stat)
lsr r0, r1
mov r2, #0xf
and r0, r2 @isolate the current debuff
@ add r0, r5 @add the debuff amount
cmp r0,r5 @check if debuff is larger than current
bge EndApplyDebuff @ Woah this used to be just a `bge End`. Jumped to a differen't routine's return
mov r0, r5 @otherwise it will stack with itself
cmp r0, #0xF
ble NotCapped
  mov r0, #0xF @max it out at 0xf
NotCapped:
@now i need to zero out the debuff for that particular stat
@r2 is 0xf
ldr r3, [r7]
lsl r2, r1
mvn r2, r2 @0xffff0f or whatever
and r3, r2 @stripped the thing
lsl r0, r1
orr r3, r0
str r3, [r7]
EndApplyDebuff:
pop {r4-r7,pc}

ApplyWeaponDebuffs:
@First apply own debuffs
push {r4-r7,lr}
mov r4, r0          @r4 = one to update
mov r5, r1          @r5 = other

ldr r3, ExtraUnitData
bl BXR3
mov r6, r0
@ ldr r6, ExtraDataLocation
@ ldrb r0, [r4, #0xB]
@ lsl r0, #0x3        @8 bytes per unit
@ add r6, r0          @r6 = &extra data

mov r0, #0x48       @Equipped item after battle
ldrh r0, [r4, r0]   
mov r1, #0xFF
and r0, r1
ldr r2, ItemTableLocation
mov r1, #0x24
mul r0, r1
add r2, r0          @r2 = &Item Data
mov r0, #0x21       @Offset of debuff data
ldrb r0, [r2, r0]
@r0 = debuff data.

ldrb r1, [r6, #0x4]
mov r2, #0x40       @str/2 for status data
and r2, r1
cmp r2, #0x0
beq checkHalveStrength
@Str was already  halved so unhalve it.
mov r2, #0xCF
and r1, r2
strb r1, [r6, #0x4]
b magicHalvingDebuff
checkHalveStrength:
mov r1, #0x80       @str/2 for weapon debuff data.
and r1, r0
cmp r1, #0x0        @No str/2 debuff
beq magicHalvingDebuff
ldrb r1, [r6, #0x4] @reload the debuff
mov r2, #0x40       @set the str/2 bit
orr r1, r2
strb r1, [r6, #0x4]

magicHalvingDebuff:
ldrb r1, [r6, #0x4]
mov r2, #0x20       @mag/2 for status data
and r2, r1 
cmp r2, #0x0
beq checkHalveMagic
@Mag was already  halved so unhalve it.
mov r2, #0xCF
and r1, r2
strb r1, [r6, #0x4]
b silverDebuff
checkHalveMagic:
mov r1, #0x40       @mag/2 for weapon debuff data.
and r1, r0
cmp r1, #0x0        @No mag/2 debuff
beq silverDebuff
ldrb r1, [r6, #0x4] @reload the debuff
mov r2, #0x20       @set the mag/2 bit
orr r1, r2
strb r1, [r6, #0x4]

silverDebuff:
mov r1, #0x20
and r1, r0
cmp r1, #0x0
beq noSilverDebuff
ldrb r1, [r6, #0x4]
mov r2, #0x1F       @silver debuff only
and r2, r1
mov r3, #0xE0       @H.o. bits only
and r1, r3
add r2, #0x2
cmp r2, #0x1F
ble storeSilverDebuff
mov r2, #0x1F
storeSilverDebuff:
orr r1, r2
strb r1, [r6, #0x4]
noSilverDebuff:

@Now the enemy weapons debuffs.
mov r0, #0x7C       @damage/hit data
ldrb r0, [r5, r0]
@ mov r1, #0x2
mov r1, #0x1 @shouldn't it be 1?
and r0, r1
cmp r0, #0x0
beq noHit
mov r0, #0x48       @Equipped item after battle
ldrh r0, [r5, r0]   
mov r1, #0xFF
and r0, r1
ldr r2, ItemTableLocation
mov r1, #0x24
mul r0, r1
add r2, r0          @r2 = &Item Data
mov r0, #0x21       @Offset of debuff data
ldrb r0, [r2, r0]
@r0 = debuff data.
mov r1, #0x1F
and r0, r1
lsl r1, r0, #0x2 @Each entry is 0x4 bytes
ldr r0, DebuffTableLocation
add r0, r1          @r0 = offset in debuff table
push { r0 }
@construct the data
ldrb r2, [r0, #0x2]
lsl r2, #0x10
ldrb r1, [r0, #0x1]
lsl r1, #0x8
ldrb r0, [r0]
orr r0, r1
orr r0, r2

ldr r1, [r6]
mov r2, #0x0        @loop counter

push {r6}
mov r6, #0x0        @accumulator
@TODO: maybe implement negative chain?
debuffLoop:
mov r3, #0xF
lsl r4, r2, #0x2    @bits in a nibble
lsl r3, r4          @this many to the left
mov r5, r3          @existing debuffs
mov r7, r3          @maybe new debuffs
and r5, r1
and r7, r0
cmp r7, r5
bge takeNew         @should work since shifted by same amount
mov r7, r5          @keep old debuffs
takeNew:
orr r6, r7          @Set the chosen debuff

add r2, #0x1
cmp r2, #0x6
blt debuffLoop
mov r0, r6
pop {r6}
ldr r1, [r6]        @we only want to store 3 bytes, so...
mov r2, #0xFF
lsl r2, #0x18       @push into 4th byte
and r2, r1
orr r0, r2
str r0, [r6]        @store new debuffs

@ Time to handle mag weapon debuff. Mag is the 4th byte of the WeaponDebuffTable and the bottom 4 bits of the 5th byte of the RAM DebuffTable.
pop { r0 } @ r0 = this entry of the WeaponDebuffTable.
ldrb r0, [ r0, #0x03 ]
mov r2, #0x0F
and r0, r0, r2 @ Ensure only the bottom 4 bits are gotten.
ldrb r1, [ r6, #0x05 ] @ r1 = current extra magic byte.
and r1, r1, r2 @ Isolated current mag debuff.
cmp r0, r1
ble noHit @ No change if the current magic byte is greater than or equal to the one to apply.
ldrb r1, [ r6, #0x05 ]
mov r3, #0xF0
and r1, r1, r3 @ Current mag byte without debuff.
orr r0, r0, r1
strb r0, [ r6, #0x05 ] @ Store new mag extra byte.

noHit:
pop {r4-r7}
pop {r3}
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
@POIN DebuffTableLocation
