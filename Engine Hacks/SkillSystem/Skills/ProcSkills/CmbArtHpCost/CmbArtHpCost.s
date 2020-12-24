.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ d100Result, 0x802a52c
@ r0 is attacker, r1 is defender, r2 is current buffer, r3 is battle data

TakeDamage:

push {r4-r7,lr}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data


ldr     r0,[r2]           @r0 = battle buffer                @ 0802B40A 6800     
lsl     r0,r0,#0xD                @ 0802B40C 0340     
lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40    

mov r1, #0x86 @devil flag OR miss OR injured self already
tst r0, r1
bne End
@ @if another skill already activated, don't do anything

@only when attacker initiates
ldr r0, =0x203a4ec
cmp r4, r0
bne End

@b WeDamage

ldr r0,=#0x0203F101 	@cmb art checking?
ldrb r0,[r0]

cmp r0, #4
blt End

ldr r2, =ModularPreBattleTable
mov r3, #0x0		@counter


LoopStart:
mov r1, #0xFF		@70 entries in table
add r3, r3, #1 		@counter

cmp r3, r1		@counter too big so give up
bge End



mov r1, #64
mul r1, r3, r1		@counter times 64 bytes per entry to get the row
add r1, r1, r2		@pointer to correct row that we want in r1

ldrb r1,[r1, #2]		@r1 now holds cmb art id of the row
cmp r0, r1 		@exit if not combat art ID
bne LoopStart

@r2 is now the pointer to the CmbArtId in the correct row
mov r1, #64
mul r1, r3, r1		@counter times 64 bytes per entry to get the row
add r1, r1, r2		@pointer to correct row that we want in r1
ldrb r3, [r1, #3]		@actual hp cost 

@make sure damage > 0
mov r0, #4
ldrsh r0, [r7, r0]
cmp r0, #0
ble End

cmp r3, #0	@if hp cost is 0, don't make hp drain/reflect exactly 0
beq End		@lol

@if we proc, set the hp update flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0, #0x1
lsl     r0, #8           
add r0, #0x4		@0x100, hp drain/update, 0x04 injured self already
orr     r1, r0

@and unset the crit flag
@ mov r0, #1
@ mvn  r0, r0
@ and     r1,r0            @unset it

ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018   


mov r2, r3	@damage to take

mov r1, #0x13
ldrsb r1, [r4,r1] @curr hp

cmp r3, r1
blt NoKill
sub r2, r3, r1		@diff between dmg to take & curr hp 
add r2, r2, #1		@add 1
sub r3, r3, r2 		@leave at 1 hp

NoKill:

mov r0, #0
sub r0, r0, r3	@if dealt dmg is lower than taken dmg, the battle animation
		@will show the wrong amount of health
strb r0, [r6, #5] @set current hp change



@Update HP (post-battle hp)
mov r2, #0x13
ldrsb r2, [r4,r2] @curr hp
sub r1, r2, r3	@new hp
strb r1, [r4, #0x13]


@ [0203A4FF]!! //write to HP of attacker
@ [0203AAC5]!! //write to current hp change 



End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD CounterID
