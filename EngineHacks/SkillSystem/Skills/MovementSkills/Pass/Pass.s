.thumb
.org 0x0
.equ PassID, SkillTester+4
@Bx'd to from 3003D28
@This function sets the Z flag if the moving unit can cross the other unit's tile, either because they're either both allied/npcs or enemies, or because the mover has Pass
push  {r0-r6,r14}   @actually necessary to push the scratch registers in this case
ldrb  r4,[r3,#0xA]  @allegiance byte of current unit
eor   r4,r7     @r7 is allegiance byte of unit on tile we are looking at
mov   r0,#0x80
tst   r0,r4
beq   GoBack      @if non-zero, then one character is an enemy and one is not. If zero, the z flag is set
ldr   r0,GetUnit
mov   r14,r0
ldrb  r0,[r3,#0xA]
.short  0xF800      @returns char struct of moving unit


@ allow walking through trainers / trainers walking through anyone 
push {r0} 
mov r0, r7 @ target unit allegiance byte 
ldr r1, GetUnit 
mov r14, r1 
.short 0xF800 
pop {r1} @ actor 
@ r0 = target 
cmp r0, #0 
beq ReturnTrue 
ldr r0, [r0] @ char pointer 
cmp r0, #0 
beq ReturnTrue @ unit has died 
ldrb r0, [r0, #4] @ unit ID 
ldr r2, [r1] @ char pointer 
cmp r2, #0 
beq ReturnTrue 

ldrb r2, [r2, #4] @ unit ID 
cmp r0, #0xE0 
bge MaybeTrainer1 
cmp r2, #0xE0 
blt NotTrainer
b MaybeTrainer2 
MaybeTrainer1: 
cmp r0, #0xEF 
ble ReturnTrue 
MaybeTrainer2: 
@b NotTrainer @ for now trainers cannot walk through players 

@ allow trainers to walk through players 
cmp r2, #0xE0 
blt NotTrainer 
cmp r2, #0xEF 
bgt NotTrainer 
b ReturnTrue 

NotTrainer: 
mov r0, r1 @ actor 
ldr   r1,SkillTester
mov   r14,r1
ldr   r1,PassID
.short  0xF800
cmp   r0,#0x1     @set z flag if unit has Pass
beq ReturnTrue 
b GoBack 
ReturnFalse: 
mov r0, #0 
cmp r0, #1 
b GoBack 

ReturnTrue: 
mov r0, #1 
cmp r0, #1 
b GoBack 

GoBack:
pop   {r0-r6}
pop   {r4}
mov   r14,r4
ldr   r4,GoBackAddress
bx    r4

.align
GetUnit:
.long 0x08019430
GoBackAddress:
.long 0x03003D34    @note that we need to switch back to arm
SkillTester:
@POIN SkillTester
@WORD PassID
