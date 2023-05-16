.thumb 
.global InitDebuffs
.type InitDebuffs, %function 
InitDebuffs: 
push {lr}

mov r0,r5
bl ClearUnitDebuffs 


@Code that we replaced to jump here
ldrb    r0,[r6,#0x3]      @Level
lsr     r0,r0,#0x3
strb    r0,[r5,#0x8]
mov     r1,r5
add     r1,#0x10          @Hidden statuses (e.g. Afa's drops)
mov     r2,r5
pop {r3}
bx r3
.ltorg 

