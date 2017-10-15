.thumb
.include "_Definitions.h.s"

.set prNewMenu_DefaultChild, (0x0804EBC8+1)
.set prNewMenu_Default,      (0x0804EBE4+1)
.set prClearIconGfx,         (0x08003584+1)
.set prLoadIconPalettes,     (0x080035BC+1)

.set pExtraItemOrSkill,       0x0202BCDE

@ Arguments: r0 = Parent 6C
Hi:
	push {r4, lr}
	
	mov r4, r0
	
	ldr  r0, =pExtraItemOrSkill
	mov  r1, #0
	strb r1, [r0, #1] @ Storing 0 where the skill identifer bit was
	
	@ Clearing existing icons
	_blh prClearIconGfx
	
	@ Loading Icon Palette(s)
	mov r0, #4
	_blh prLoadIconPalettes
	
	@ Actually making the Menu (if parent is 0, no parent)
	ldr r0, EALiterals
	
	cmp r4, #0
	beq NoParent
	
	mov r1, r4
	_blh prNewMenu_DefaultChild
	b Continue
	
NoParent:
	_blh prNewMenu_Default
	
Continue:
	@ Making the BB with text directly from the rom because why not
	adr r1, TempText
	_blh prBottomHelpDisplay_New
	
	pop {r4}
	
	pop {r1}
	bx r1

.align
TempText:
	.asciz "Select which skill you wish to forget"

.ltorg
.align

EALiterals:
	