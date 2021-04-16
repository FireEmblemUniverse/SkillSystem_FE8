
.thumb
.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.include "Functions.asm"
.include "PrepScreenSupport.asm"
.include "SupportConvos.asm"

@ Vanilla does A > 0xF0 > B > 0xA0 > C > 0x50. This is read and analyzed at 0x0802823C
	@ The most efficient way to do this is store both the character ID and support level in the character struct, but this will take up 10 bits.
	@ Over 8 bytes of space in each character struct, this means there are 64 bits at our disposal.
	@ If we're fancy, we can fit 5 individual support partners into here.
	
	
@ It seems that while caculating support bonuses, they are written to a temporary bit of RAM: 0x03007CF0... Holy shit they use the stack.
@ Well it's passed in as an argument, so hm. Looks like space is allocated in the stack for this. Be sure to handle this as a parameter and not a static location.
@ For now, I'll call this the Support Bonus Temp
	@ These are then used to add bonuses to the battle struct.
	@ These are added at 0x0802A9F4
		@ 0x01: Byte: Attack bonus
		@ 0x02: Byte: Defense bonus
		@ 0x03: Byte: Hit bonus
		@ 0x04: Byte: Avoid bonus
		@ 0x05: Byte: Crit bonus
		@ 0x06: Byte: Crit avoid bonus
		
		@ I think I should be able to completely rewrite the support calculation system. All I need to do is rewrite the master function to reflect this... easier said than done...?
	
	@ Here's the plan: Each support will consist of a character ID starting at 0x34 and ending at 0x38 inclusive. 0x32 as a short will hold each two bit support level in order

.global MasterSupportCalculation
.type MasterSupportCalculation, %function
MasterSupportCalculation: @ Autohook to 0x080285B0. r0 = battle struct, r1 = r4 = Support Bonus Temp. This handle the support bonuses in the battle calculation.
push { r5 - r7, lr }
mov r6, r0 @ Store the battle struct in r6.
mov r0, #0x00
str r0, [ r4, #0x04 ] @ Clears the support bonus temp
str r0, [ r4 ]
ldrb r0, [ r6, #0x0B ]
lsr r1, r1, #0x06
cmp r1, #0x00
bne EndMasterSupportCalculation
sub r6, r6, #0x01
mov r5, #0x00 @ r5 is a counter.
sub r5, r5, #0x01
StartMasterSupportCalculationLoop:
add r6, r6, #0x01
add r5, r5, #0x01
cmp r5, #0x05
beq EndMasterSupportCalculation
mov r1, #0x34
ldrb r0, [ r6, r1 ] @ Supporting character
cmp r0, #0x00
beq StartMasterSupportCalculationLoop @ Skip if there is no character in this slot.
	bl FindCharacter
	cmp r0, #0x00
	beq StartMasterSupportCalculationLoop
	mov r1, r6
	sub r1, r1, r5
	bl GetCharacterDistance
	cmp r0, #0x03
	bgt StartMasterSupportCalculationLoop
	mov r0, r4
	mov r1, r6
	sub r1, r1, r5
	mov r2, r5
	bl HandleBonus
	b StartMasterSupportCalculationLoop
EndMasterSupportCalculation:
pop { r5 - r7 }
pop { r0 }
bx r0

HandleBonus: @ r0 = Support Bonus Temp, r1 = battle struct, r2 = counter: i.e. which support this is. This takes this valid support and writes the data to the Support Bonus Temp.
push { r4 - r7, lr }
mov r4, r0 @ Support bonus temp
mov r5, r1 @ Battle struct
mov r6, r2 @ Counter
mov r0, r5
mov r1, r6
bl GetSupportLevel @ r0 = this support level.
push { r0 }
ldr r7, =SupportReworkBonusTable
sub r7, r7, #20
StartHandleBonusLoop:
add r7, r7, #20
ldr r1, [ r7 ]
cmp r1, #0x00
beq EndHandleBonus @ End if the end of the bonus table was reached.
mov r1, r5
add r1, r1, #0x34
ldrb r1, [ r1, r6 ] @ Supporting character
ldrb r2, [ r7 ] @ Character in the bonus table
cmp r1, r2
bne NotFirstSupporting
	ldr r3, [ r5 ]
	ldrb r2, [ r3, #0x04 ] @ Character ID of this battle struct.
	ldr r0, =#0x0202BE4C
	cmp r0, r3
	bne HandleBonusNotTact1
		mov r2, #0xFF
	HandleBonusNotTact1:
	ldrb r3, [ r7, #0x01 ] @ Other character in the bonus table.
	cmp r2, r3
	beq ApplyHandleBonus
NotFirstSupporting:
ldrb r2, [ r7, #0x01 ] @ Other character in the bonus table
cmp r1, r2
bne StartHandleBonusLoop @ Neither the first nor the second characters in the bonus table match the supporting character. Loop back.
	ldr r3, [ r5 ]
	ldrb r2, [ r3, #0x04 ] @ Character ID of this battle struct.
	ldr r0, =#0x0202BE4C
	cmp r0, r2
	bne HandleBonusNotTact2
		mov r2, #0xFF
	HandleBonusNotTact2:
	ldrb r3, [ r7 ] @ First character in the bonus table.
	cmp r2, r3
	bne StartHandleBonusLoop
ApplyHandleBonus: @ So at this point, r7 has this entry of the bonus table.
add r7, r7, #0x02
mov r1, #0x06
ldr r0, [ sp ] @ Get this support level off of the stack.
sub r0, r0, #0x01
mul r0, r1
add r7, r0, r7 @ Now r4 has this entry of this support level
add r4, r4, #0x01
mov r0, #0x00 @ r0 is a counter.
StartApplyHandleBonusLoop:
ldrb r1, [ r4, r0 ]
ldrb r2, [ r7, r0 ]
add r1, r1, r2
strb r1, [ r4, r0 ]
add r0, r0, #0x01
cmp r0, #0x06
bne StartApplyHandleBonusLoop
EndHandleBonus:
pop { r0 }
pop { r4 - r7 }
pop { r0 }
bx r0

.global DisplaySupportStatScreen1
.type DisplaySupportStatScreen1, %function
DisplaySupportStatScreen1: @ Autohook to 0x080876A4.
mov r0, #0x06
str r0, [ sp, #0x08 ]
mov r0, #0x00
str r1, [ sp, #0x0C ]
ldr r4, =#0x02003BFC
ldr r0, [ r4, #0x0C ]
bl CountSupports
mov r10, r0
mov r1, #0x00
mov r9, r1
cmp r0, #0x00
bne ContinueDisplaySupport
	ldr r0, =#0x08087771 @ There are zero supports. Just end.
	bx r0
ContinueDisplaySupport:
mov r1, #0x80
lsl r1, r1, #0x01
add r1, r4, r1
str r1, [ sp, #0x10 ]
@ Well we'll just fall through to this function I guess...

.global DisplaySupportStatScreen2
.type DisplaySupportStatScreen2, %function
DisplaySupportStatScreen2: @ Autohook to 0x080876D8. r9 is a counter, r10 = number of supports.
@ This function is looped through for each support this unit has.
ldr r1, =#0x02003BFC
ldr r0, [ r1, #0x0C ] @ Current character struct
add r0, r0, #0x34
mov r1, #0x00
sub r1, r1, #0x01
mov r3, #0x00
sub r3, r3, #0x01
DisplaySupportStatScreen2Loop:
add r3, r3, #0x01
ldrb r2, [ r0, r3 ]
cmp r2, #0x00
beq DisplaySupportStatScreen2Loop
add r1, r1, #0x01
cmp r1, r9
bne DisplaySupportStatScreen2Loop
@ r2 has the r9th support character. r3 has the support location.
mov r4, r2
sub r0, r0, #0x34
mov r1, r3
bl GetSupportLevel
mov r7, r0 @ Store this support level in r7.
cmp r4, #0xFF
bne DisplaySupportNotTact1
	ldr r0, =#0x0202BE4C
	ldr r0, [ r0 ]
	ldrb r4, [ r0, #0x04 ]
DisplaySupportNotTact1:
ldr r0, =#0x080876F5 @ Upon returning I need to have the support level in r7 and the support character in r4.
bx r0

.align
.ltorg

@ These functions will be called by the user via events.
.global CallAddSupport
.type CallAddSupport, %function
CallAddSupport: @ Memory slot 0x1 = character 1, slot 0x2 = character 2. Defaults to setting a C support.
push { r4, lr }
mov r0, r4
bl CallAddSupportNoPopup @ I can treat this like an ext too hmm.
cmp r0, #0x00
beq EndCallAddSupport @ The ext determined they are not eligible for a support. Just end.
ldr r0, =#0x0203EFC0
mov r1, #0x43 @ ASCII "C".
strb r1, [ r0 ]
mov r1, #0x00
strb r1, [ r0, #0x01 ]
ldr r0, =IncreaseSupportPopupDefinitions
mov r1, #90 @ Duration of the popup
mov r2, #0x00 @ Style of popup window
ldr r3, =NewPopup
mov lr, r3
mov r3, r4 @ Parent proc
.short 0xF800 @ No scratch registers ree
EndCallAddSupport:
pop { r4 }
pop { r0 }
bx r0

.global CallAddSupportNoPopup
.type CallAddSupportNoPopup, %function
CallAddSupportNoPopup:
push { r4 - r7, lr }
ldr r0, =#0x0030004B8 @ Memory slot 0x0.
ldr r4, [ r0, #0x04 ] @ Character 1.
ldr r5, [ r0, #0x08 ] @ Character 2.
mov r0, r4
bl FindCharacter @ r0 equals character struct of character 1.
mov r6, r0
ldrb r1, [ r0, #0x0C ]
mov r2, #0x04
tst r1, r2
bne EndCallAddSupportNoPopupFalse @ This character is dead.
bl CountSupports @ r0 has the number of supports of character 1.
cmp r0, #0x05
beq EndCallAddSupportNoPopupFalse @ End if there are already 6 supports.
mov r0, r5
bl FindCharacter @ r0 equals character struct of character 2.
mov r7, r0
ldrb r1, [ r0, #0x0C ]
mov r2, #0x04
tst r1, r2
bne EndCallAddSupportNoPopupFalse @ This character is dead.
bl CountSupports @ r0 has the number of supports of character 2.
cmp r0, #0x05
beq EndCallAddSupportNoPopupFalse @ End if there are already 6 supports.
mov r0, r6
mov r1, r5
bl FindSupportData
mov r1, #0x00
mvn r1, r1
cmp r0, r1
beq EndCallAddSupportNoPopupFalse @ End if there is already a support that exists.
mov r0, r6 @ Character 1 character struct.
mov r1, r5 @ Character 2 ID.
bl AddSupport
mov r0, r7 @ Character 2 character struct.
mov r1, r4 @ Character 1 ID.
bl AddSupport
mov r0, #0x01
EndCallAddSupportNoPopup:
pop { r4 - r7 }
pop { r1 }
bx r1
EndCallAddSupportNoPopupFalse:
mov r0, #0x00
b EndCallAddSupportNoPopup

.global CallIncreaseSupport
.type CallIncreaseSupport, %function
CallIncreaseSupport: @ Memory slot 0x1 = character 1, slot 0x2 = character 2. Increases the support level by 1.
push { r4 - r6, lr }
mov r4, r0
bl CallIncreaseSupportNoPopup
cmp r0, #0x00
beq EndCallIncreaseSupport @ For some reason, CallIncreaseSupportNoPopup determined that a support can't occur.
ldr r1, =#0x0030004B8 @ Memory slot 0x0.
ldr r0, [ r1, #0x04 ] @ Character 1.
ldr r5, [ r1, #0x08 ] @ Character 2.
bl FindCharacter @ r0 = character 1's character struct.
mov r6, r0 @ Character 1's character struct.
mov r1, r5
bl FindSupportData @ r0 has distance to this support.
mov r1, r0
mov r0, r6
bl GetSupportLevel @ r0 has this support level.
ldr r2, =#0x0203EFC0
mov r1, #0x44 @ ASCII D
sub r1, r1, r0
strb r1, [ r2 ]
mov r1, #0x00
strb r1, [ r2, #0x01 ]
ldr r0, =IncreaseSupportPopupDefinitions
mov r1, #90 @ Duration of the popup
mov r2, #0x00 @ Style of popup window
ldr r3, =NewPopup
mov lr, r3
mov r3, r4 @ Parent proc
.short 0xF800 @ No scratch registers ree
EndCallIncreaseSupport:
pop { r4 - r6 }
pop { r0 }
bx r0 

.global CallIncreaseSupportNoPopup
.type CallIncreaseSupportNoPopup, %function
CallIncreaseSupportNoPopup: @ Memory slot 0x1 = character 1, slot 0x2 = character 2. Increases the support level by 1.
push { r4 - r7, lr }
ldr r0, =#0x0030004B8 @ Memory slot 0x0.
ldr r4, [ r0, #0x04 ] @ Character 1.
ldr r5, [ r0, #0x08 ] @ Character 2.
mov r0, r4
bl FindCharacter
mov r6, r0 @ Character 1's character struct.
ldrb r1, [ r0, #0x0C ]
mov r2, #0x04
tst r1, r2
bne EndCallIncreaseSupportNoPopupFalse @ This character is dead.
mov r0, r5
bl FindCharacter
mov r7, r0 @ Character 2's character struct.
ldrb r1, [ r0, #0x0C ]
mov r2, #0x04
tst r1, r2
bne EndCallIncreaseSupportNoPopupFalse @ This character is dead.
mov r1, r4
bl FindSupportData
mov r1, #0x00
mvn r1, r1
cmp r0, r1
bne CallIncraseSupportNotC
	@ If they want to increase the support, let's insure that they haven't reached the max number (5).
	mov r0, r6
	bl CountSupports
	cmp r0, #0x05
	beq EndCallIncreaseSupportNoPopupFalse
	mov r0, r7
	bl CountSupports
	cmp r0, #0x05
	beq EndCallIncreaseSupportNoPopupFalse
	mov r0, r6
	mov r1, r5
	bl AddSupport
	mov r0, r7
	mov r1, r4
	bl AddSupport
	mov r0, #0x01
	b EndCallIncreaseNoPopup
CallIncraseSupportNotC:
mov r1, r0
mov r0, r6
bl GetSupportLevel
cmp r0, #0x03
beq EndCallIncreaseSupportNoPopupFalse @ This is already an A support. Let's just end.
mov r0, r6
mov r1, r5
bl IncreaseSupport
mov r0, r7
mov r1, r4
bl IncreaseSupport
mov r0, #0x01
EndCallIncreaseNoPopup:
pop { r4 - r7 }
pop { r1 }
bx r1
EndCallIncreaseSupportNoPopupFalse:
mov r0, #0x00
b EndCallIncreaseNoPopup

.global CallSetSupport
.type CallSetSupport, %function
CallSetSupport: @ Memory slot 0x1 = character 1, slot 0x2 = character 2, 0x3 = level to set. Sets a level for a support (C, B, or A)
push { r4 - r7, lr }
ldr r0, =#0x0030004B8 @ Memory slot 0x0.
ldr r4, [ r0, #0x04 ] @ r4 = character 1.
ldr r5, [ r0, #0x08 ] @ r5 = character 2.
ldr r0, [ r0, #0x0C ]
cmp r0, #0x03
bgt EndCallSetSupport @ This isn't a valid level. Let's just end.
cmp r0, #0x00
beq EndCallSetSupport @ They're trying to set 0. Let's just end.
mov r0, r4
bl FindCharacter
cmp r0, #0x00
beq EndCallSetSupport
mov r6, r0 @ r6 = character 1's character struct.
mov r0, r5
bl FindCharacter
cmp r0, #0x00
beq EndCallSetSupport
mov r7, r0 @ r7 = character 2's character struct.

mov r0, r6
mov r1, r5
bl FindSupportData @ r0 has the location of this support.
mov r1, #0x00
mvn r1, r1
cmp r0, r1
bne CallSetSupportNoAdd
	@ No support exists. Let's add this support then.
	mov r0, r6
	bl CountSupports
	cmp r0, #0x05
	beq EndCallSetSupport @ Character 1 has too many supports. End.
	mov r0, r7
	bl CountSupports
	cmp r0, #0x05
	beq EndCallSetSupport @ Character 2 has too many supports. End.
	mov r0, r6
	mov r1, r5
	bl AddSupport
	mov r0, r7
	mov r1, r4
	bl AddSupport
	ldr r0, =#0x0030004C4
	ldr r0, [ r0 ] @ Support level
	cmp r0, #0x01
	beq EndCallSetSupport @ They're trying to set to C. May as well end.
	mov r0, r6
	mov r1, r5
	bl FindSupportData	
CallSetSupportNoAdd:
mov r1, r0
mov r0, r6
ldr r2, =#0x0030004C4
ldr r2, [ r2 ] @ Support level
bl SetSupport
mov r0, r7
mov r1, r4
bl FindSupportData @ r0 has the location of this support.
mov r1, #0x00
mvn r1, r1
cmp r0, r1
beq EndCallSetSupport @ This support doesn't exist. Let's just end.
mov r1, r0
mov r0, r7
ldr r2, =#0x0030004C4
ldr r2, [ r2 ] @ Support level
bl SetSupport
EndCallSetSupport:
pop { r4 - r7 }
pop { r0 }
bx r0

.align
.ltorg

.global CallClearSupport
.type CallClearSupport, %function
CallClearSupport: @ Memory slot 0x1 = character 1, slot 0x2 = character 2. Clears a support completely.
push { r4 - r7, lr }
ldr r0, =#0x0030004B8 @ Memory slot 0x0.
ldr r4, [ r0, #0x04 ] @ Character 1.
ldr r5, [ r0, #0x08 ] @ Character 2.
mov r0, r4
bl FindCharacter
mov r6, r0 @ Character 1's character struct.
mov r0, r5
bl FindCharacter
mov r7, r0 @ Character 2's character struct.

mov r0, r6
mov r1, r5
bl FindSupportData @ r0 has the location of this support.
mov r1, #0x00
mvn r2, r1
cmp r0, r2
beq EndCallClearSupport @ This support already doesn't exist... let's just end.
add r2, r6, r0
mov r3, #0x34
strb r1, [ r2, r3 ] @ Clears the character stored in the support data.
mov r1, #0x03
lsl r1, r1, #14
lsl r0, r0, #0x01 @ Multiply the location by 2.
lsr r1, r1, r0
mvn r1, r1
ldrh r0, [ r6, #0x34 ]
and r1, r0, r1 @ Clears the old support level.
strh r0, [ r6, #0x34 ]

mov r0, r7
mov r1, r4
bl FindSupportData @ r0 has the location of this support.
mov r1, #0x00
mvn r2, r1
cmp r0, r2
beq EndCallClearSupport @ This support already doesn't exist... let's just end.
add r2, r7, r0
mov r3, #0x34
strb r1, [ r2, r3 ] @ Clears the character stored in the support data.
mov r1, #0x03
lsl r1, r1, #14
lsl r0, r0, #0x01 @ Multiply the location by 2.
lsr r1, r1, r0
mvn r1, r1
ldrh r0, [ r7, #0x34 ]
and r0, r0, r1 @ Clears the old support level.
strh r0, [ r7, #0x34 ]
EndCallClearSupport:
pop { r4 - r7 }
pop { r0 }
bx r0

.global FixCUSA
.type FixCUSA, %function
FixCUSA: @ Autohook to 0x08018480. r4 = new ally character struct. This will ensure that when changing to an ally, the character's leader byte is set to 0.
beq VanillaCUSASkip
	ldr r1, =0x0859A5D0
	lsl r0, r0, #0x02
	add r0, r0, r1
	ldr r1, [ r0 ]
	ldrb r0, [ r4, #0x0B ]
	strb r0, [ r1, #0x1B ]
VanillaCUSASkip: @ Some weird vanilla shit about rescuing. All vanilla above here.
mov r0, #0x00
mov r1, #0x38
strb r0, [ r4, r1 ] @ Set the character leader byte to 0. (Interferes with support data)
pop { r4 - r6 }
pop { r0 }
bx r0

.align
.ltorg
