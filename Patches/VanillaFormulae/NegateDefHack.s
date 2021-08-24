@bx'd to from 0x802AE54
 @ r4 = Attacker 
 @ r5 = Attacker's weapon's attributes 
 @ r6 = Defender 

@ldr r0, [r4, #0x4C] @ Equipped wep abilities 
@mov r1, #0x80 
@lsl r1, #0xA @ 0x020000 / Negate Def bitflag 
@and r0, r1 @ does the wep have it?
@cmp r0, #0 @ 
@beq Skip 
.thumb 
@ now we negate def 


 @ r4 = Attacker 
 @ r5 = also attacker? 
 @ r6 = Defender 
mov r0, r4 
mov r2, r6 

@ probably don't actually need to push lr 
push {r4-r6, lr}
mov r4, r0 
mov r6, r2 @ Dunno if this is necessary tbh 


mov r0, #0x48 
ldrb r1, [r4, r0] @ Item ID ? 
ldr r3, =NegateDefAmountTable @ Indexed by item ID 
ldrb r0, [r3, r1] @ PERCENT
cmp r0, #0 
beq NegateAllDef
cmp r0, #100 
bge NegateAllDef 


mov r2, #0x5C 
ldrh r2, [r6, r2] @ def to negate part of  
mul r0, r2 @ times the percentage 
mov r3, #0x63 @ For friendly rounding - always up
add r0, r3 @ always ceiling up, so negating 51% of 2 def will negate all 2 def 
			@ but negating 1-50% of 2 def will negate 1 def 
mov r1, #100 @ always divide by 100 
@mov r11, r11  @ break point test 
mov r2, #0x5A
ldrh r3, [r4, r2] @ Battle attack 
@mov r11, r11 

swi 6 @ Div function 
@ subtract their def by this number 
mov r3, #0x5C 
ldrh r2, [r6, r3] @ def to negate part of  
cmp r2, r0 
bge NoCapNeeded
mov r2, #0 
b StoreBackIn
NoCapNeeded: 
sub r2, r0 
StoreBackIn:
strh r2, [r6, r3] @ ignored some 
b End 

NegateAllDef:
mov r1, #0x5C 
ldrh r2, [r6, r1] @ User's def 
mov r0, #0 
strh r0, [r6, r1] @ Store back def 

End:
pop {r4-r6}
pop {r0}
ldr r0, =0x802AE5D @ Return address 
bx r0 

.align 


