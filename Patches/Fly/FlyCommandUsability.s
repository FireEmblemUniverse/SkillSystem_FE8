.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ EventEngine, 0x800D07C
	.equ CheckEventId,0x8083da8
	
.macro TestFlyingType
ldr r1, [r0, #4] @ Class pointer 
add r1, #0x50 @ class type offset  
ldr r1, [r1] @ Class type 
ldr r2, =FlyingTypeLink
ldr r2, [r2] 
tst r1, r2 
.endm

.global FlyCommandUsability
.type FlyCommandUsability, function 
FlyCommandUsability: 
	push {lr}


ldr r0, =FlyFlag
lsl r0, #16
lsr r0, #16 @ Flags are shorts 
blh CheckEventId
cmp r0, #1 
@ bne RetFalse

@ check if indoors 
ldr r3, =IndoorMapsList
ldr r1, =0x0202BCF0 @ gChapterData
ldrb r1, [r1, #0x0E] @ chapter ID 
sub r3, #1 
IndoorMapLoop:
add r3, #1 
ldrb r0, [r3] 
cmp r0, #0 
beq WeAreOutdoors
cmp r0, r1 
beq RetFalse 
b IndoorMapLoop

WeAreOutdoors:

b HasFlyingPokemon @ always allow Fly even without a flier 'cause QoL I guess 

bl Get1stUnit
cmp r0, #0 
beq Skip_1
TestFlyingType
bne HasFlyingPokemon
Skip_1:
bl Get2ndUnit
cmp r0, #0 
beq Skip_2
TestFlyingType
bne HasFlyingPokemon
Skip_2:
bl Get3rdUnit
cmp r0, #0 
beq Skip_3
TestFlyingType
bne HasFlyingPokemon
Skip_3:
bl Get4thUnit
cmp r0, #0 
beq Skip_4
TestFlyingType
bne HasFlyingPokemon
Skip_4:
bl Get5thUnit
cmp r0, #0 
beq Skip_5
TestFlyingType
bne HasFlyingPokemon
Skip_5:
bl Get6thUnit
cmp r0, #0 
beq Skip_6
TestFlyingType
bne HasFlyingPokemon
Skip_6:
b RetFalse


HasFlyingPokemon:


mov r0, #1 
b Exit

RetFalse:
mov r0, #3 
Exit:

pop {r1}
bx r1

.ltorg 
.align 
