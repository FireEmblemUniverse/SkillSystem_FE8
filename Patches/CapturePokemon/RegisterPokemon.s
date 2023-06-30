.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global FillPokedex
.type FillPokedex, %function 
FillPokedex:
push {r4, lr}
mov r4, #0
FillLoop:
add r4, #1 
cmp r4, #255 
bgt BreakLoop
mov r0, r4 
bl RegisterPokemon
b FillLoop
BreakLoop:
pop {r4}
pop {r0}
bx r0 

.ltorg 

.global SeePokedex
.type SeePokedex, %function 
SeePokedex:
push {r4, lr}
mov r4, #0
FillLoop2:
add r4, #1 
cmp r4, #120
bgt BreakLoop2
mov r0, r4 
bl SeePokemon
b FillLoop2
BreakLoop2:
pop {r4}
pop {r0}
bx r0 

.ltorg
.align
.equ MemorySlot,0x30004B8
.equ GetUnit, 0x8019430
.global RegisterPokemon
.type RegisterPokemon, %function 

RegisterPokemon: @ make the class saved as seen (just in case) & caught 
push {r4, lr} 
@ given class id in r0
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


.global RegisterAllOwnedPokemon 
.type RegisterAllOwnedPokemon, %function 
RegisterAllOwnedPokemon:
push {r4, lr} 
mov r4, #0 
LoopThroughOwnedUnits:
add r4, #1 
cmp r4, #0x40
bge ExitRegisterAllPokemon
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq LoopThroughOwnedUnits
ldr r3,[r0]
cmp r3,#0
beq LoopThroughOwnedUnits
ldr r3,[r0,#0xC] @ condition word
ldr r2, =#0x4 @ dead
tst r3,r2
bne LoopThroughOwnedUnits
ldr r1, [r0, #4] @ class pointer 
cmp r1, #0 
beq LoopThroughOwnedUnits 
ldrb r0, [r1, #4] @ class id 
bl RegisterPokemon
b LoopThroughOwnedUnits
ExitRegisterAllPokemon:

pop {r4}
pop {r0}
bx r0 


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
ldrb r0, [r1, #4] @ class id 
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


.global CheckIfSeen
.type CheckIfSeen, %function 
CheckIfSeen: 
push {lr}
@ given class ID in r0 
ldr r1, =PokedexSeenFlagOffset
lsl r1, #3 @8 flags per byte 
add r0, r1 
bl CheckNewFlag 
pop {r1}
bx r1 
.ltorg 


.global CheckIfCaughtASMC
.type CheckIfCaughtASMC, %function 
CheckIfCaughtASMC: 
push {r4, lr} 
ldr r4, =MemorySlot 
ldr r0, [r4, #4] @ slot 1 as class ID 
bl CheckIfCaught 
str r0, [r4, #4*0x0C] 
pop {r4} 
pop {r1} 
bx r1 
.ltorg 


.global CheckIfCaught
.type CheckIfCaught, %function 
CheckIfCaught: 
push {lr}
@ given class ID in r0 
ldr r1, =PokedexCaughtFlagOffset
lsl r1, #3 @8 flags per byte 
add r0, r1 
bl CheckNewFlag 
pop {r1}
bx r1 
.ltorg 

.global CountSeen
.type CountSeen, %function 
CountSeen:
push {r4-r6, lr}

mov r6, #0 @ counter 
ldr r5, =PokedexTable
mov r4, #0 

SeenCountLoop:
add r4, #1 
cmp r4, #0xFF 
bgt ExitCountSeen
lsl r0, r4, #2 @ 4 bytes per entry 
ldrb r0, [r5, r0] @ 1 if to display 
cmp r0, #0 
beq SeenCountLoop
mov r0, r4 
bl CheckIfSeen 
cmp r0, #1 
bne SeenCountLoop
add r6, #1 
b SeenCountLoop

ExitCountSeen:
mov r0, r6 


pop {r4-r6}
pop {r1}
bx r1 

.global CountCaught
.type CountCaught, %function 
CountCaught:
push {r4-r6, lr}

mov r6, #0 @ counter 
ldr r5, =PokedexTable
mov r4, #0 

CaughtCountLoop:
add r4, #1 
cmp r4, #0xFF 
bgt ExitCountCaught
lsl r0, r4, #2 @ 4 bytes per entry 
ldrb r0, [r5, r0] @ 0 if not to display 
cmp r0, #0
beq CaughtCountLoop
mov r0, r4 
bl CheckIfCaught 
cmp r0, #1 
bne CaughtCountLoop
add r6, #1 
b CaughtCountLoop

ExitCountCaught:
mov r0, r6 

pop {r4-r6}
pop {r1}
bx r1 



.ltorg 
.align 




