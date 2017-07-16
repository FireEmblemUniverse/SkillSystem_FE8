.thumb
.org 0
@at 8004bf0, jump here

push {r4-r6,r14}
mov r5,r0
mov r4,r1
cmp r5,#0
beq NoBoost
bgt Boost
mov r0,r4
ldr	r1,Const_2028E70
ldr	r1,[r1]
ldrh r6,[r1,#0x10]	@usual tile id or something
mov r2,#9
lsl r2,#0xC
orr r2,r6
strh r2,[r1,#0x10]	@makes it use a different palette bank so we can have red debuffs
mov r1,#4    @grey
mov r2,#0x14 @minus
ldr r3, DrawSymbol
mov lr,r3
.short 0xf800
add r0,r4,#2
mov r2,r5
neg r2,r2
cmp r2,#9
ble notSure
add r0,r4,#4
notSure:
mov r1, #4
b Merge

Boost:
mov	r6,#0	@use this as a flag so we don't overwrite the original tile id if we don't have to
mov r0,r4
mov r1,#4
mov r2,#0x15
ldr r3, DrawSymbol
mov lr,r3
.short 0xf800
add r0,r4,#2
cmp r5,#9
ble notSure2
add r0,r4,#4
notSure2:
mov r1, #4
mov r2,r5

Merge:
ldr r3,DrawNumber
mov lr,r3
.short 0xf800
cmp r6,#0
beq NoBoost		@only need to do this for negative buffs
ldr r1,Const_2028E70
ldr r1,[r1]
strh r6,[r1,#0x10] @restored original tile id
NoBoost:
pop	{r4-r6}
pop {r0}
bx	r0

.align
DrawSymbol:
.long 0x8004b0c
DrawNumber:
.long 0x8004be4
Const_2028E70:
.long 0x02028E70
