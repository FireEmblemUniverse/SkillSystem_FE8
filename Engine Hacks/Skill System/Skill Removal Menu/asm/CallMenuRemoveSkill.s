.thumb
.include "_Definitions.h.s"

.set prNewMenu_DefaultChild, (0x0804EBC8+1)
@ .set prNewMenu_Default,    (0x0804EBE4+1)
.set prClearIconGfx,         (0x08003584+1)
.set prLoadIconPalettes,     (0x080035BC+1)

.set pExtraItemOrSkill,       0x0202BCDE

.set EAL_pMenuDef,           (EALiterals+0x00)
.set EAL_p6CWrapper,         (EALiterals+0x04)

@ Arguments: r0 = Unit, r1 = Parent 6C
@ Skill to be learned is byte at 0x0202BCDE
Hi:
	push {r4-r5, lr}
	
	mov r4, r0 @ var r4 = Unit
	mov r5, r1 @ var r5 = Parent 6C
	
	@ Loading The Skill Index
	ldr  r3, =pExtraItemOrSkill
	
	@ Storing 0 where the skill identifer bit was
	mov  r1, #0
	strb r1, [r3, #1]
	
	@ Clearing existing icons
	_blh prClearIconGfx
	
	@ Loading Icon Palette(s)
	mov r0, #4
	_blh prLoadIconPalettes
	
	@ Loading Wrapper 6C Code
	ldr r0, EAL_p6CWrapper
	
	@ If has parent, then make it blocking
	cmp r5, #0
	bne HasParent
	
	@ This one is batman
	mov r1, #3
	_blh pr6C_New
	
HasParent:
	@ This one is blocking its parent
	mov r1, r5
	_blh pr6C_NewBlocking

Continue:
	@ Storing Unit Pointer in Wrapper 6C Field 0x2C
	str  r4, [r0, #0x2C]
	
	@ Actually making the Menu
	mov r1, r0
	ldr r0, EAL_pMenuDef
	
	_blh prNewMenu_DefaultChild
	
	@ Making the BB with text directly from the rom because why not
	adr r1, TempText
	_blh prBottomHelpDisplay_New
	
	pop {r4-r5}
	
	pop {r1}
	bx r1

.align
TempText:
	.asciz "Select which skill you wish to forget"

.ltorg
.align

EALiterals:
	@ POIN pMenuDef
	@ POIN p6CWrapper
