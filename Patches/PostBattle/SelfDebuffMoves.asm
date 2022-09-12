
.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ Attacker, 0x203A4EC 
.equ Defender, 0x203A56C 
.equ GetUnit, 0x8019430
.type SelfDebuffMoves, %function 
.global SelfDebuffMoves
 
SelfDebuffMoves: 
push {r4-r7, lr}
@normally r4 = attacker, r5 = defender, r6 = action struct 
ldr r4, =Attacker 
ldr r5, =Defender 
@ r6 = actiondata

@check if the action was an attack
ldrb  r0, [r6,#0x11]  @action taken this turn
cmp r0, #0x2 @attack
bne End

ldrb  r0, [r5,#0x13] @ if defender is dead, do nothing to attacker 
cmp r0, #0x00
beq End

mov r6, #0 
@if attacker is dead but defender is alive, do nothing to defender 
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
beq	End 

SelfDebuff: @ both units are alive 
mov r0, r4 
add r0, #0x4A 
ldrh r0, [r0] @ item|durb 
ldr r3, =SelfDebuffTable 
mov r1, #0xFF @ itemID 
and r0, r1 
lsl r0, #2 @ 4 bytes per entry 
add r3, r0 
ldr r7, [r3] @ amount to debuff by 

cmp r7, #0 
beq CheckDefender @ skip GetUnit etc. if no debuff 

ldrb r0, [r4, #0x0B] @ deployment byte 
blh GetUnit 


blh GetDebuffs
mov r2, #0xFF 
lsl r2, #24 @ 0xFF000000 
mov r3, r7 
bic r3, r2 @ 0xFFFFFF @ don't include Mag right now 

@ I dunno if this will work as intended if you already have a debuff 
@ they may or may not stack depending on which bits are already set and which new ones will be set 
@ oh well 

ldr r2, [r0] 
mvn r1, r3 
and r2, r1 
orr r2, r3 
@ldr r1, =0xFEDCBA98 @ Empty Mag, Luck Res, Def Spd, Skl Str 
@0-2: Debuffs, 4 bits each (str/skl/spd/def/res/luk)
@3: Rallys (bit 7 = rally move, bit 8 = rally spectrum)
@5: (RallyMag<<4)||MagDebuff

str r2, [r0] 
ldrb r2, [r0, #5] @ RallyMag|MagDebuff 
mov r3, #0xF 
bic r2, r3 @ remove whatever mag debuff exists 
lsl r3, #24 @ 0xF000000 
and r3, r7 @ 0xF000000 
lsr r3, #24 @ 0x-F 
orr r2, r3 
strb r2, [r0, #5] @ RallyMag|MagDebuff 

cmp r6, #0 
beq CheckDefender 
b End 

CheckDefender:
mov r6, #1 
mov r4, r5 
b SelfDebuff 






End: 


pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 


