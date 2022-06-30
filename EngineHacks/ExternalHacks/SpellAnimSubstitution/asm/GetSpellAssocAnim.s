.thumb

.equ RangeAssocList, EALiterals
.equ ClassAssocList, EALiterals+0x04

.equ RangeAssocEntrySize, 0x04
.equ ClassAssocEntrySize, 0x06

.global GetSpellAssocAnim
.type GetSpellAssocAnim, %function
GetSpellAssocAnim: @ r0 = class, r1 = wpn
	push {r4, lr}
	
	mov r4, r0 @ r4 is class
	
	mov r0, #0xFF
	and r0, r1 @ r0 is wpn without uses

	bl IER_GetItemAnimation

	ldr r2, =0xFFFF @ Stores 0xFFFF in r2 (0xFFFF defines end of table)
	ldrh r0, [r0, #0x4] @ r0 = [r3+0x4] (animation id)
	
	@ Loading the attack range in r1
	ldr r1, =0x203A4D4
	ldrh r1, [r1, #0x02]
	
	@ Skip close-range anim substitution if range != 1
	cmp r1, #0x01
	bne RANGE_LOOP_SKIP
	
	ldr r3, RangeAssocList
	
RANGE_LOOP_BEGIN:
	ldrh r1, [r3]
	
	@ end of list check
	cmp r1, r2
	beq RANGE_LOOP_SKIP
	
	@ anim check
	cmp r1, r0
	beq RANGE_LOOP_END
	
	@ forwarding pointer
	add r3, #RangeAssocEntrySize
	b RANGE_LOOP_BEGIN

.ltorg

RANGE_LOOP_END:
	ldrh r0, [r3, #0x2]
	
RANGE_LOOP_SKIP:
	ldr r3, ClassAssocList
	
CLASS_LOOP_BEGIN:
	ldrh r1, [r3] @ r1 = (*ClassAssocList) aka entry anim id
	
	@ table ended (no special anim replacement)
	cmp r1, r2
	beq CLASS_LOOP_SKIP
	
	@ entry and current anim id don't match
	cmp r1, r0
	bne CLASS_LOOP_CONTINUE
	
	ldrh r1, [r3, #0x2] @ r1 = (*(ClassAssocList+0x2)) aka entry class id
	
	cmp r1, r4
	beq CLASS_LOOP_END
	
CLASS_LOOP_CONTINUE:
	add r3, #ClassAssocEntrySize @ table size
	b CLASS_LOOP_BEGIN

.ltorg

CLASS_LOOP_END:
	ldrh r0, [r3, #0x4]
	
CLASS_LOOP_SKIP:
	@ r0 = (int16) r2
	lsl r0, #0x10 @ r0 = r0 << 10
	asr r0, #0x10 @ r0 = r0 >> 10
	
	pop {r4}
	pop {r1}
	bx r1

.ltorg
.align
EALiterals:
