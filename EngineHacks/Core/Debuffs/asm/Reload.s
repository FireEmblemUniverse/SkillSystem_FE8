.thumb
@r4 = the unit struct
.global ReloadDebuffs 
.type ReloadDebuffs, %function 
ReloadDebuffs: 
push    {lr}

push    {r0-r1}
mov     r0,r4
bl 		ClearUnitDebuffs
pop     {r0-r1}

@ vanilla stuff 
lsr     r1,r1,#0x4
ldrb    r0,[r0,#0x8]
mov     r5,#0x1
and     r0,r5
lsl     r0,r0,#0x4
orr     r0,r1
pop     {r2}
bx r2
.ltorg 
