.thumb		
.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global GetAverageStat
.type GetAverageStat, %function
GetAverageStat:
push {r4-r7, lr}
@ calculate what the average should be 
@ r0 = growths function 
mov r6, r1 @ stat 
mov r7, r2 @ given unit pointer 
mov r5, r3 @ levels gained 

mov r14, r0 
mov r0, r7 @ unit 
.short 0xF800 
mov r4, r0 @ Growths
ldr r3, [r7] @ unit table entry 
ldr r2, [r7, #4] @ class table 
cmp r5, #0
bge NoCapLevel
mov r5, #0 @ if someone was dumb we just make their gained levels as 0 
NoCapLevel:
cmp r6, #0 @ Hp 
beq Hp 
cmp r6, #1 @ Str 
beq Str 
cmp r6, #2 
beq Skl 
cmp r6, #3 
beq Spd 
cmp r6, #4 
beq Def 
cmp r6, #5 
beq Res 
cmp r6, #6 
beq Luk 
cmp r6, #7 
beq Mag 
mov r0, #0xFF @ -1 if we error 
b Exit 

Hp:
ldrb r0, [r3, #0x0C] @ Unit Base Hp
ldrb r1, [r2, #0x0B] @ Class Base Hp
add r0, r1 
b Continue

Str:
ldrb r0, [r3, #0x0D]
ldrb r1, [r2, #0x0C]
add r0, r1 
b Continue

Skl:
ldrb r0, [r3, #0x0E]
ldrb r1, [r2, #0x0D]
add r0, r1 
b Continue

Spd:
ldrb r0, [r3, #0x0F]
ldrb r1, [r2, #0x0E]
add r0, r1 
b Continue

Def:
ldrb r0, [r3, #0x10]
ldrb r1, [r2, #0x0F]
add r0, r1 
b Continue

Res:
ldrb r0, [r3, #0x11]
ldrb r1, [r2, #0x10]
add r0, r1 
b Continue

Luk:
ldrb r0, [r3, #0x12]
@ no base luck for classes 
b Continue

Mag: 
ldrb r0, [r3, #4] @ unit id 
lsl r0, #1 @ 2 bytes per entry 
ldr r3, =MagCharTable
ldrb r0, [r3, r0] @ Unit's base magic 
ldrb r1, [r2, #4] @ Class id 
lsl r1, #2 @ 4 bytes per entry 
ldr r2, =MagClassTable 
ldrb r1, [r2, r1] @ unit's class base magic 
add r0, r1 


Continue:
mov r6, r0 @ Base stat 
mov r0, r4 @ Growth 
mul r0, r5 @ Growth * Levels gained 
mov r1, #100 
swi 6 @ div 
add r0, r6 @ Average stat 


Exit: 


pop {r4-r7}
pop {r1} 
bx r1 



.align 
.global TieredLevelUp
.type TieredLevelUp, %function

TieredLevelUp:
push {r4-r7, lr}

@ r0 = average stat 
@ r1 = stat byte 
@ r2 = atkr/dfdr/unit 
@ r3 = growth function 
mov r7, r2 
mov r6, r3 @ growth function 
mov r4, r1
ldrb r2, [r7, r1] 



cmp r2, r0  
bgt SkipLowerCheck

ldr r3, =LowerTierForcedStatGain
ldrb r1, [r3] 
cmp r0, r1 
blt DoneTieredPart @ If the average stat is lower than the lower boundary, we do regular growths 
sub r0, r1 @ this is the minimum stat they should have 
cmp r2, r0
bge DoneTieredPart @ They have at least the minimum stat we expect 
mov r0, #1 @ Forcibly gain this stat 
b End 

SkipLowerCheck:
ldr r3, =UpperTierPreventStatGain 
ldrb r1, [r3] 
add r0, r1 @ this is the maximum level in this stat they should have at their level 
cmp r2, r0 
blt DoneTieredPart @ They have less than the max, so continue 
mov r0, #0 @ Forcibly prevent this stat from gaining if they were at the max level or higher 
b End 

DoneTieredPart:
mov r14, r6 @ funtion 
mov r0, r7 
.short 0xf800 @ blh Get__x__Growth
@r0 = growth 
blh 0x802B9A0 @ CalcLevelUp

End:
@ return t/f 
pop {r4-r7}
pop {r1} 
bx r1 

.align 
.ltorg 














