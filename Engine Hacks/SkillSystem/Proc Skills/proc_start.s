.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ proc_truehit, 0x802A558
.equ d100Result, 0x802a52c
.global Proc_Start
.type Proc_Start, %function
Proc_Start: @ r0 is attacker, r1 is defender, r2 is current buffer, r3 is battle data
push {r4-r7,lr}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data

ldr     r0,[r6]           @r0 = battle buffer                @ 0802B40A 6800     
lsl     r0,r0,#0xD                @ 0802B40C 0340     
lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40     
mov r1, #2 @miss flag
tst r0, r1
bne EndLadder
@if we missed, don't bother doing anything
@removed sure shot check, just unset the miss flag if needed.
ldrh    r0,[r7,#0xA]      @final hit rate                @ 0802B41A 8960     
mov     r1,#0x1           @Default depending on where battle is called, leave it alone             @ 0802B41C 2101     
blh     proc_truehit        @Proc hit rate                @ 0802B41E F7FFF89B     
cmp     r0,#0x0                @ 0802B424 2800     
bne     SuccessfulHit        @If we hit, branch                @ 0802B426 D111   
@if we missed, set the miss flag  
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0,#0x2           @miss flag     @ 0802B430 2002  
orr     r1,r0                @ 0802B432 4301     
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]    @store the new battle buffer   
b End

EndLadder:
b End

SuccessfulHit:
@now calculate normal damage
ldrh r0, [r7, #6] @final mt
lsl r0, #0x10
asr r0, #0x10
ldrh r1, [r7, #8] @final def
lsl r1, #0x10
asr r1, #0x10
sub r0, r1

@ Cool. Time to check for BarricadePlus. r0 has the damage to write. r9 has a counter of times struck this combat. r4 = inflicter of this strike, r5 = defender of this strike.
cmp r0, #0x00
beq StoreDamage2 @ We don't want any of this shit if the damage is 0.
push { r0 }
mov r0, r5
ldr r1, =BarricadePlusIDLink
ldrb r1, [ r1 ]
blh SkillTester, r3
cmp r0, #0x00
pop { r0 }
beq SkipBarricadePlus
@ Okay in case both units have this skill, the counter will use the first byte of r11 for 0x0203A4EC and the second byte for 0x0203A56C.
@ I mean it really doesn't matter which it is as long as it's consistent.

mov r1, r11
ldr r2, =#0x0203A56C
cmp r2, r4
beq Attacker
	@ Defender
	lsl r1, r1, #0x10
	lsr r1, r1, #0x18
	lsr r0, r0, r1 @ r0 has corrected damage.
	cmp r0, #0x00
	bne NotZero1
	mov r0, #0x01
	NotZero1:
	
	add r1, r1, #1 @ r1 has the counter to write (to be corrected to the second byte)
	lsl r1, r1, #0x08 @ Shifted to the second byte
	mov r2, r11	@ r2 has the previous counter (including all bytes)
	ldr r3, =#0xFFFF00FF
	and r2, r2, r3 @ Eliminates previous counter
	orr r1, r1, r2
	mov r11, r1 @ Store new counter to r11
	b StoreDamage2
Attacker:
	lsl r1, r1, #0x18
	lsr r1, r1, #0x18 @ r1 has isolated first byte
	lsr r0, r0, r1 @ r0 has corrected damage.
	cmp r0, #0x00
	bne NotZero2
	mov r0, #0x01
	NotZero2:
	
	add r1, r1, #1 @ r1 has the counter to write (in the first byte)
	mov r2, r11 @ r2 has the previous counter (including all bytes)
	ldr r3, =#0xFFFFFF00
	and r2, r2, r3 @ Eliminates previous counter.
	orr r1, r1, r2
	mov r11, r1 @ Store new counter to r11
	b StoreDamage2

SkipBarricadePlus: @ Well now I need to check for regular barricade. Let's use the third byte of r11 as a boolean for the attacker on whether do use it and the fourth for the defender.
push { r0 }
mov r0, r5
ldr r1, =BarricadeIDLink
ldrb r1, [ r1 ]
blh SkillTester, r3
cmp r0, #0x00
pop { r0 }
beq StoreDamage2

mov r1, r11
ldr r2, =#0x0203A56C
cmp r2, r4
beq Attacker2
	@ Defender2
	lsr r1, r1, #0x18
	cmp r1, #0x00
	beq SkipDefenderDamage
	lsr r0, r0, #0x01 @ r0 has the corrected damage.
	cmp r0, #0x00
	bne SkipDefenderDamage @ In case the damage has been reduced to 0
	mov r0, #0x01
	SkipDefenderDamage:
	mov r1, #0x01
	lsl r1, r1, #0x18
	mov r2, r11
	orr r1, r1, r2
	mov r11, r1
	b StoreDamage2
Attacker2:
	lsl r1, r1, #0x08
	lsr r1, r1, #0x18
	cmp r1, #0x00
	beq SkipAttackerDamage
	lsr r0, r0, #0x01 @ r0 has the corrected damage.
	cmp r0, #0x00
	bne SkipAttackerDamage @ In case the damage has been reduced to 0
	mov r0, #0x01
	SkipAttackerDamage:
	mov r1, #0x01
	lsl r1, r1, #0x10
	mov r2, r11
	orr r1, r1, r2
	mov r11, r1

StoreDamage2:
strh r0, [r7, #4] @final damage

@now to check for a crit
ldrh r0, [r7, #0xc] @crit rate
mov r1, #0
blh d100Result
cmp r0, #1
bne End

@if crit:
mov r0,r5		@defender
ldr r1, =ExpertiseIDLink
ldrb r1, [ r1 ]
blh SkillTester, r3

mov r1, #4
ldrsh r1, [r7, r1]
lsl r2, r1, #1
cmp r0,#0
bne StoreDamage
add r2, r1 @damagex3
StoreDamage:
strh r2, [r7, #4] @final damage

@set crit flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov r0, #1
orr r1, r0
ldr     r0,=#0x7FFFF                @ 0802B516 4815     
and     r1,r0                @ 0802B518 4001
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018   

End:
pop {r4-r7}
pop {r15}

@.equ ExpertiseID, SkillTester+4
@.ltorg
@SkillTester:
@
