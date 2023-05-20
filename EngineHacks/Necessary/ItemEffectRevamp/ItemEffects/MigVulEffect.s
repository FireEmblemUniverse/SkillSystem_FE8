.thumb
@r4 has action struct pointer
.equ Return, OffsetList
.equ VulnRoutine, OffsetList + 4
.equ GetCharPointer, OffsetList + 8
.equ ItemMightGetter, OffsetList + 12

ldrb 	r0, [r4, #0xC]
ldr 	r3, GetCharPointer
bl	Jump
ldrb 	r1, [r4, #0x12]
lsl 	r1, r1, #0x1
add 	r1, #0x1E
add 	r0, r0, r1
push {r0} @ Vesly added 
ldrh 	r0, [r0]
ldr 	r3, ItemMightGetter
bl Jump
mov 	r1, r0
mov 	r0, r6
ldr 	r3, VulnRoutine
bl	Jump
pop {r0} 
ldrh r1, [r0] 
lsr r1, r1, #8 
cmp r1, #0x80 
bne DoNothing 
mov r1, #0 
strh r1, [r0] @ Berry to have 0 uses 
@ .equ GetItemAfterUse, 0x08016AEC+1
DoNothing:

ldr 	r3, Return
Jump:
bx	r3
.align
OffsetList:
