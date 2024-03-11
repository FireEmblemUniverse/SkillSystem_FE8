.thumb
.org 0x0
push {lr} 
mov r0, r4 @ unit 
bl UnitRandomizeStatCaps

@ cap movement 
mov		r2,#0x1D
ldsb	r2,[r4,r2]
mov		r1,#0x12
ldsb	r1,[r7,r1]
mov		r0,#0xF
sub		r0,r0,r1
cmp		r2,r0
pop {r3} 
bx r3 
.ltorg 
.align
MagClassCap:
