.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.ltorg
.align
.equ MemorySlot,0x30004B8
.equ GetUnit, 0x8019430
.global RegisterPokemon
.type RegisterPokemon, %function 

RegisterPokemon: @ make the class saved as seen (just in case) & caught 
push {r4, lr} 
@ given class in r0
@ given class in Memory slot 1, save 
@ldr r3, =MemorySlot
@ldrh r0, [r3, #4*1] @ slot 1 as class ID 

mov r4, r0 
mov r2, #0x4 
lsl r2, #8 @ 0x400 / 1024 as max 
cmp r0, r2 
bgt ExitRegisterPokemon

ldr r1, =PokedexCaughtFlagOffset
lsl r1, #3 @8 flags per byte 
add r0, r1 

bl SetNewFlag @ caught 

mov r0, r4 
ldr r1, =PokedexSeenFlagOffset
lsl r1, #3 @8 flags per byte 
add r0, r1 

bl SetNewFlag @ seen 

ExitRegisterPokemon:
pop {r4} 
pop {r0}
bx r0 
.ltorg 

.global SeeAllDeployedPokemon // this is used as 
.type SeeAllDeployedPokemon, %function 
SeeAllDeployedPokemon:
push {r4, lr} 
mov r4, #0 
LoopThroughUnits:
add r4, #1 
cmp r4, #0xC0 
bge ExitSeePokemon
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq LoopThroughUnits
ldr r3,[r0]
cmp r3,#0
beq LoopThroughUnits
ldr r3,[r0,#0xC] @ condition word
ldr r2, =#0x1000C @ escaped, benched/dead
tst r3,r2
bne LoopThroughUnits
ldr r1, [r0, #4] @ class pointer 
cmp r1, #0 
beq LoopThroughUnits 
ldrb r0, [r1, #4] @ unit id 
bl SeePokemon
b LoopThroughUnits
ExitSeePokemon:

pop {r4}
pop {r0}
bx r0 


SeePokemon: @ make the class saved as seen 
push {lr}
ldr r1, =PokedexSeenFlagOffset
lsl r1, #3 @8 flags per byte 
add r0, r1 
bl SetNewFlag 
pop {r0}
bx r0 
.ltorg 



@CheckIfSeen: 
@
@bl CheckNewFlag
@
@CheckIfCaught:






