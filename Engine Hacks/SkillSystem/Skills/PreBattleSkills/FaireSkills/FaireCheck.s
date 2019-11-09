.equ FaireIDList, SkillTester+4
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

push {r4-r7, lr} 
mov        r4,r0 @ r0 = battle struct.

@ EDIT BY SNEK:
	@ Getting the weapon type in this way doesn't account for magic swords.
	@ I'm going to get the weapon type by item ID -> ROM item data -> weapon type.
@add     r0,#0x50    @Move to the attacking unit's weapon type.
@ldrb    r0,[r0]        @Load in the attacking unit's weapon type.    

mov r1, #0x4A
ldrh r0, [ r4, r1 ] @ Equipped item halfword.
cmp r0, #0x00
beq NoSkill
blh 0x080174EC, r1 @ GetItemIndex. This function is such a meme tbh. r0 = item ID.
blh 0x080177B0, r1 @ GetItemData. r0 = pointer to ROM item data.
ldrb r0, [ r0, #0x07 ] @ r0 = this item's weapon type.

ldr     r1,FaireIDList    @Load in the list of Faire Skills.
ldrb     r1,[r1,r0]    @Load in the Faire Skill corresponding to the equipped weapon.
mov     r0,r4        @Store attacker data into r0 (for the purposes of SkillTester).
ldr        r3,SkillTester
mov     lr, r3        
.short 0xf800        @Call Skill Tester.
cmp r0, #0            @Check if unit has the corresponding Faire skill.
beq     NoSkill
mov     r0,r4        @Move attacker data into r0.
add     r0,#0x5A    @Move to the attacker's power.
ldrh    r3,[r0]        @Load the attacker's power into r3.
add     r3,#0x04    @Add 4 to the attacker's power.
strh     r3,[r0]        @Store attacker power.
NoSkill:
pop {r4-r7} 
pop {r0}
bx r0

.align
.ltorg
SkillTester:
@POIN SkillTester
@POIN FaireIDList
