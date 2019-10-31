.thumb
.align

@hook at 0x727FE using r0
@relevant person's char struct is in r7
@if we do the thing, return to 0x8072806
@if we don't do the thing, return to 0x8072822

.equ DancerMusicReturn, 0x8072807
.equ NormalMusicReturn, 0x8072823


@start by doing what our hook overwrites
mov r4,#0
ldr r0,[r7,#4]
ldrb r0,[r0,#4]

@now we do our loop for the list
ldr r2,DancerMusicList
LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq False
cmp r0,r1
beq True
add r2,#1
b LoopStart

True:
ldr r0, =DancerMusicReturn
bx r0

False:
ldr r0, =NormalMusicReturn
bx r0

.ltorg
.align
DancerMusicList:
@POIN DancerMusicList
