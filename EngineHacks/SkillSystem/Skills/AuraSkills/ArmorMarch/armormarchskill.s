.equ ArmorMarchID, AuraSkillCheck+4
.equ SkillTester, ArmorMarchID+4
.equ ArmorMarchList, SkillTester+4
.thumb

.set gChapterData,                 0x0202BCF0
.set GetUnit,                      0x08019430
	@ arguments:
		@r0 = unit deployment id
	@returns:
		@r0 = unit pointer



ArmorMarch_StartOfTurn: 
push	{r4-r6, lr}
@unset everyone
mov	r4,#1
unsetLoop:

@unset the bit for this skill in the debuff table entry for the unit
mov r0,r4
ldr r2,=GetUnit
mov lr,r2
.short 0xf800
cmp r0,#0
beq unsetReit
bl GetUnitDebuffEntry 
ldr r1, =ArmorMarchBitOffset_Link
ldr r1, [r1] 
bl UnsetBit 
unsetReit:
add	r4,#1
cmp	r4,#0xB3
beq	allUnset
b	unsetLoop

allUnset:
ldr	r2,=gChapterData
ldrb	r4,[r2,#0xF]	@phase
add	r4,#1

Loop:
mov	r0,r4
ldr	r1,=GetUnit	@get char data
mov	lr,r1
.short	0xf800
mov	r5,r0		@r5 = pointer to unit in ram

@check if there is a unit
cmp	r5,#0
beq	Next
ldr	r0,[r5]
cmp	r0,#0
beq	Next
ldrb	r0,[r5,#0x0C]
mov	r1,#0xC @ dead or undeployed 
tst r0, r1 
bne	Next

@check if this unit is an armor
ldr	r0,ArmorMarchList
ldr	r1,[r5,#0x4]
ldrb	r1,[r1,#0x4]	@class id
armorLoop:
ldrb	r2,[r0]
cmp	r2,#0
beq	notArmor
cmp	r2,r1
beq	Armor
add	r0,#1
b	armorLoop

Armor:
@check for the skill from nearby units
ldr	r0,AuraSkillCheck
mov	lr,r0
mov	r0,r5		@unit to check
ldr	r1,ArmorMarchID
mov	r2,#0		@can_trade
mov	r3,#1		@range
.short	0xf800
mov	r6,r0
cmp	r6,#0
bne	Set

notArmor:
@check if the unit has the skill
ldr	r0,SkillTester
mov	lr,r0
mov	r0,r5		@unit to check
ldr	r1,ArmorMarchID
.short	0xf800
mov	r6,r0
cmp	r6,#0
beq	Set

@get nearby units
ldr	r0,AuraSkillCheck
mov	lr,r0
mov	r0,r5		@unit to check
mov	r1,#0
mov	r2,#0		@can_trade
mov	r3,#1		@range
.short	0xf800

@check if any nearby unit is an armor
ldr	r6,=#0x202B256	@bugger for the nearby units
checkArmorsLoop:
ldrb	r0,[r6]
cmp	r0,#0
beq	noArmors
ldr	r1,=GetUnit	@get char data
mov	lr,r1
.short	0xf800		@r0 = pointer to unit in ram
mov	r3,r0
ldr	r0,ArmorMarchList
ldr	r1,[r3,#0x4]
ldrb	r1,[r1,#0x4]	@class id
armorLoop2:
ldrb	r2,[r0]
cmp	r2,#0
beq	checkArmorsLoopNext
cmp	r2,r1
beq	armorFound
add	r0,#1
b	armorLoop2
checkArmorsLoopNext:
add	r6,#1
b	checkArmorsLoop

noArmors:
mov	r6,#0
b	Set

armorFound:
mov	r6,#1


Set:
@set or unset the bit for this skill in the debuff table entry for the unit
mov r0,r4
ldr r2,=GetUnit
mov lr,r2
.short 0xf800
bl GetUnitDebuffEntry 
ldr r1, =ArmorMarchBitOffset_Link
ldr r1, [r1] 
cmp	r6,#0		@check if the skill check was successful or not
beq	Unset
bl SetBit 
b	Next

Unset:
bl UnsetBit 

Next:
add	r4,#1
cmp	r4,#0x3F
beq	End
cmp	r4,#0x55
beq	End
cmp	r4,#0xB3
beq	End
b	Loop


End:
mov r0, #0 @ no blocking proc / animation 
pop	{r4-r6}
pop	{r1}
bx	r1

.align
.ltorg
AuraSkillCheck:
@POIN AuraSkillCheck
@WORD ArmorMarchID
@POIN SkillTester
@POIN ArmorMarchList
