.thumb
.align

.global FixDurabilityChestPopupASMC
.type FixDurabilityChestPopupASMC, %function

.global PreBattle_UnsetDurabilityFlag
.type PreBattle_UnsetDurabilityFlag, %function

.equ gEventQueue,0x30004F0
.equ MemorySlot3,0x30004B8+0xC
.equ MemorySlot7,0x30004D4
.equ IsThereClosedChestAt,0x80831AD
.equ GetChapterEventDataPointer,0x80346B1
.equ gChapterData,0x202BCF0
.equ CheckEventDefinition,0x8082ec5

.macro blh to,reg=r3
	push {\reg}
	ldr \reg,=\to
	mov r14,\reg
	pop {\reg}
	.short 0xF800
.endm

FixDurabilityChestPopupASMC: @this is now an ASMC

@item or gold value is in s3
@if the value we have is >0xFF and came from the item part and not the gold part of a chest, then strip the durability; otherwise, use it verbatim
@return whether or not it's a gold chest in s7


push {r4-r7,r14}

ldr r0,=MemorySlot3
ldr r4,[r0] @r4 = item or gold amount
cmp r4,#0xFF
ble RetIsItem

@now we have to get the event stuff
ldr r0,=gChapterData
ldrb r0,[r0,#0xE]
blh GetChapterEventDataPointer
ldr r3,[r0,#8] @LocationBasedEvents

@cycle through LocationBasedEvents until we find a chest at active unit's current position
@!!! this may break an unlock staff that works on chests if the chest has durability set !!!

ldr r0,=#0x3004E50
ldr r0,[r0]
ldrb r5,[r0,#0x10] @active unit x coord
ldrb r6,[r0,#0x11] @active unit y coord

LoopStart:
ldrb r0,[r3,#0xA]
cmp r0,#0
beq RetIsItem @if we've reached the end of the list then assume it's an item
cmp r0,#0x14 @ID of chest
bne LoopRestart @if not chest, restart
ldrb r0,[r3,#0x8] @x coord
cmp r0,r5
bne LoopRestart
ldrb r0,[r3,#0x9] @y coord
cmp r0,r6
bne LoopRestart
ldrh r0,[r3,#0x4] @item area
cmp r0,#0x77
beq RetIsGold @is a gold chest if this is empty
b RetIsItem

LoopRestart:
add r3,#12
b LoopStart


RetIsItem:
ldr r1,=MemorySlot7
mov r0,#0
str r0,[r1]
b GoBack

RetIsGold:
ldr r1,=MemorySlot7
mov r0,#1
str r0,[r1]

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align



PreBattle_UnsetDurabilityFlag:
ldr r1, = #0x203FFF7 // end of RAM
mov r0, #0x0
strb r0, [r1] // zero it back out
bx r14

.ltorg
.align

