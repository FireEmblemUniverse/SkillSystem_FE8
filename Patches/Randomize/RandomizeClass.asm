.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.type RandomizeClassNow, %function 
.global RandomizeClassNow
RandomizeClassNow: 
push {r4-r7, lr} 


@ r0 as class id 
ldr r1, =0x9235364
mov r1, #1 @ clock time ? 
mov r2, #30 @ max 


bl HashByte_N 
@(u8 number, u8 noise, int max)



lsl r0, #24 
lsr r0, #24 @ byte only 



pop {r4-r7} 
pop {r1} 
bx r1 
.ltorg 


.equ ClassTablePOIN, 0x8017DBC
.global RandomizeClassHack_Load
.type RandomizeClassHack_Load, %function 
RandomizeClassHack_Load:
push {r4, lr} 
mov r4, r1 
@ r1 as class ID 

ldr r3, =RandomizeClassesFlagLabel 
ldr r0, [r3] 
blh CheckEventId 
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


