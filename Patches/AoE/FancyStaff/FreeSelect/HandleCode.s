.thumb
.include "_FE8Definitions.h.s"

@ Arguments: r0 = Free Select 6C Struct, r1 = Code
FreeSelect_HandleCode:
	push {r4-r5, lr}
	
	mov r4, r0 @ var r4 = Free Select 6C Struct
	mov r5, r1 @ var r5 = Code
	
	mov r0, #2
	tst r5, r0
	beq NoDelete
	
	@ Breaking loop
	mov r0, r4
	_blh Break6CLoop
	
	ldr r3, [r4, #0x2C] @ routine array pointer
	ldr r3, [r3, #0x04] @ routine 0x04 = OnEnd
	
	cmp r3, #0
	beq NoCall
	
	mov r0, r4 @ arg r0 = 6C
	bl BXR3
	
NoCall:
	@ Return 1 (aka "end now")
	mov r0, #1
	b End
	
NoDelete:
	ldr  r0, =pChapterDataStruct
	add  r0, #0x41
	ldrb r0, [r0]
	
	@ Options set to "no sound effect"
	lsl r0, #0x1E
	blt NoSound
	
	mov r0, #4
	tst r5, r0
	beq NoBeep
	
	mov r0, #0x6A
	_blh prPlaySound
	
NoBeep:
	mov r0, #8
	tst r5, r0
	beq NoBoop
	
	mov r0, #0x6B
	_blh prPlaySound
	
NoBoop:
	mov r0, #0x10
	tst r5, r0
	beq NoGurr

	mov r0, #0x6C
	_blh prPlaySound
	
NoGurr:
NoSound:
	mov r0, #0x20
	tst r5, r0
	beq NoSetValid
	
	ldr r0, [r0, #0x30] @ TCS
	mov r1, #0
	
	_blh TCS_SetAnim
	
	b ReturnZero
	
	mov r0, #0x40
	tst r5, r0
	beq NoSetInvalid
	
	ldr r0, [r0, #0x30]
	mov r1, #1
	
	_blh TCS_SetAnim
	
NoSetInvalid:
ReturnZero:
	mov r0, #0
	
End:
	pop {r4-r5}
	pop {r3}
	BXR3:
	bx r3

.ltorg
.align

EALiterals:
	@ nothing
	