.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ GetGameClock, 0x8000D28 
.type SaveGameSeed, %function 
.global SaveGameSeed 
SaveGameSeed: 
push {lr} 
blh GetGameClock 
ldr r3, =StartTimeSeedRamLabel
ldr r3, [r3] 
bl HashSeed
ldr r3, =StartTimeSeedRamLabel
ldr r3, [r3] 
str r0, [r3] 
pop {r0} 
bx r0 
.ltorg 


.type RandomizeClassNow, %function 
.global RandomizeClassNow
RandomizeClassNow: 
push {r4-r7, lr} 
mov r4, r0 @ class id 
ldr r3, =ClassRandomizerBalanceTable 
add r3, r4 @ entry 
ldrb r5, [r3] 
cmp r5, #0 
beq DoNotRandomize 
ldrb r1, [r3] 

ldr r6, =StagePoinTable 
lsl r0, r5, #2 @ 4 bytes per entry 
add r6, r0 @ which list to use? 
ldr r6, [r6] 

mov r0, r6 @ list 
mov r1, #0 @ terminator  
bl CountListSize_Byte 
mov r1, r0 @ max 
mov r0, r4 @ class id 

bl HashByte_Ch 
@(u8 number, int max)
lsl r0, #24 
lsr r0, #24 @ byte only 

ldrb r0, [r6, r0] @ class ID from the balanced list to use 
mov r4, r0 @ result 

DoNotRandomize: 
mov r0, r4 


pop {r4-r7} 
pop {r1} 
bx r1 
.ltorg 

CountListSize_Byte:
@ given list in r0 and terminator in r1, count the size 
mov r2, #0 
sub r2, #1 
Loop_CountListSize: 
add r2, #1 
ldrb r3, [r0, r2] 
cmp r3, r1 
bne Loop_CountListSize
mov r0, r2 
bx lr 
.ltorg 

.equ ClassTablePOIN, 0x8017DBC
.global RandomizeClassHack_Load
.type RandomizeClassHack_Load, %function 
RandomizeClassHack_Load:
push {r4, lr} 
mov r4, r1 
@ r1 as class ID 

mov r0, r5 @ unit struct (contains very little right now as it is just being made) 
bl ShouldUnitBeRandomized 
cmp r0, #0 
beq VanillaLoadBehaviour 



mov r0, r4 @ class id 
bl RandomizeClassNow 
mov r4, r0 


VanillaLoadBehaviour: 
mov r1, r4 

mov r0, #0x54 @ class table entry size 
mul r1, r0 
ldr r0, =ClassTablePOIN
ldr r0, [r0] 
add r1, r0 
str r1, [r5, #0x4] 

pop {r4}
pop {r3} 
ldr r3, =0x8017D7D 
bx r3 
.ltorg 


.equ CheckEventId,0x8083da8
.equ GenerateMonsterClass, 0x8078324 
@ ORG $17AD8 callHackNew 
.type RandomizeClassHack_Monster, %function 
.global RandomizeClassHack_Monster
RandomizeClassHack_Monster: 
push {r4-r5, lr} 

ldr r3, =RandomizeClassesFlagLabel 
ldr r0, [r3] 
blh CheckEventId 
mov r4, r0 

ldrb r0, [r6, #1] 
blh GenerateMonsterClass 
lsl r0, #0x10 
lsr r7, r0, #0x10 


cmp r4, #0 
beq VanillaBehaviour 

mov r0, r7 
bl RandomizeClassNow 
mov r7, r0 

b Exit 

VanillaBehaviour: 
Exit:
@ put resulting class into r7 
pop {r4-r5} 
pop {r3} 
mov r1, sp 
mov r0, r6 
bx r3 
.ltorg 

.global RandomizeStatsHook
.type RandomizeStatsHook, %function 
RandomizeStatsHook:
push {lr} 
add r0, r2 
strb r0, [r4, #0x18] 
ldrb r0, [r1, #0x12] 
strb r0, [r4, #0x19] 
mov r0, #0 
strb r0, [r4, #0x1A] @ con bonus 

mov r0, r4 
bl RandomizeStats 
mov r1, #0 @ vanilla expects this 
pop {r0} 
bx r0 
.ltorg 




