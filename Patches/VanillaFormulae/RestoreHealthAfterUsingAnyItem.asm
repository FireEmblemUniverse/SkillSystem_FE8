.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


	.global RestoreHealthAfterUsingAnyItem
	.type   RestoreHealthAfterUsingAnyItem, function

@ Part of the Post-action loop 
@ Buildfile\EngineHacks\Necessary\CalcLoops\PostActionCalcLoop\PostActionCalcLoop.event 
@ Eg. 
@ PostActionCalcFunctions:
@ POIN RestoreHealthAfterUsingAnyItem

@ Given Parameters: r0 = character struct
@ So we can get the active unit or just use r0 

RestoreHealthAfterUsingAnyItem:
	push	{r4-r7,lr}
	mov r4, r0 @ Unit's ram address to act upon such as 202BE4C (first player deployed, probably) 
	ldr r3, =0x3004E50 @ Current Unit Pointer 
	ldr r4, [r3] @ Specific unit pointer, such as 202BE4C
	ldrb r0, [r4, #0x12] @ Max HP 
	strb r0, [r4, #0x13] @ Store to curr hp 

	@ Action struct 203A958 + 0x11 = 203A969 	Action taken this turn 
	@ this byte should equal to 0x1A	Use item
	Term:
	pop {r4-r7}
	pop	{r0}
	bx r0 
	
	
	
	