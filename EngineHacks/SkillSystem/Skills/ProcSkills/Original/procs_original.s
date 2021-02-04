push    {r4-r7,r14}                @ 0802B3EC B5F0     
mov     r7,r10                @ 0802B3EE 4657     
mov     r6,r9                @ 0802B3F0 464E     
mov     r5,r8                @ 0802B3F2 4645     
push    {r5-r7}                @ 0802B3F4 B4E0     
mov     r6,r0             @Attacker                @ 0802B3F6 1C06     
mov     r8,r1             @Defender                @ 0802B3F8 4688     
ldr     r4,=#0x203A4D4    @Battle Stats Data?                @ 0802B3FA 4C11
@ 203A4D4 (FE8)
@ 0x00  Short Seems to be a bitfield (0x2 seems to be 'battle hasn't started yet')
@ 0x02  Short Type of animation? No idea, really.
@ 0x04  Short Damage (Attack - defense)
@ 0x06  Short Attack
@ 0x08  Short Defense
@ 0x0A  Short Battle hit
@ 0x0C  Short Battle hit
@ 0x0E  Short Lethality chance     
mov     r0,#0x0                @ 0802B3FC 2000     
strh    r0,[r4,#0x4]      @Clear out damage dealt               @ 0802B3FE 80A0     
mov     r0,r6                @ attacker data   
bl      #0x802B1F4        @sure shot check              @ 0802B402 F7FFFEF7 
  @checks for sure shot, pierce, great shield and skip if set
  @skip if not a sniper - ah this must be sure shot then.
  @skip if ballista equipped
  @sets 0x4000 bit in battle buffer if it procd
ldr     r5,=#0x203A608                @ current buffer position pointer   
ldr     r0,[r5]                @ 0802B408 6828     
ldr     r0,[r0]           @r0 = battle buffer                @ 0802B40A 6800     
lsl     r0,r0,#0xD                @ 0802B40C 0340     
lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40     
mov     r1,#0x80                @ 0802B410 2180     
lsl     r1,r1,#0x7        @sure shot 0x4000               @ 0802B412 01C9     
and     r0,r1                @ 0802B414 4008     
cmp     r0,#0x0                @ 0802B416 2800     
bne     Successful_Hit        @If sure shot, branch                @ 0802B418 D118     
ldrh    r0,[r4,#0xA]      @final hit rate                @ 0802B41A 8960     
mov     r1,#0x1           @Default depending on where battle is called, leave it along             @ 0802B41C 2101     
bl      #0x802A558        @Proc hit rate                @ 0802B41E F7FFF89B 
lsl     r0,r0,#0x18                @ 0802B422 0600     
cmp     r0,#0x0                @ 0802B424 2800     
bne     Successful_Hit        @If we hit, branch                @ 0802B426 D111     
ldr     r3,[r5]                @ 0802B428 682B     
ldr     r2,[r3]                @ 0802B42A 681A     
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0,#0x2           @miss flag     @ 0802B430 2002  
orr     r1,r0                @ 0802B432 4301     
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r3]                @ 0802B43A 6018     
b       Proc_End        @if you missed, just skip to Branch end.                @ 0802B43C E08F     
.ltorg  
Successful_Hit: 
ldr     r5,=#0x203A4D4    @We hit. r5 = battle stats data.                @ 0802B44C 4D2B     
ldrh    r0,[r5,#0x6]      @Final might.                @ 0802B44E 88E8     
mov     r9,r0                @ 0802B450 4681     
ldrh    r4,[r5,#0x8]      @final defense.                @ 0802B452 892C     
mov     r0,r6                @ 0802B454 1C30     
mov     r1,r8                @ 0802B456 4641     
bl      #0x802B2E8        @Checks for battle buffer things and not-poison effect? Then checks for classes 0xB and 0xC? Generals. Great Shield proc?                @ 0802B458 F7FFFF46 
ldr     r7,=#0x203A608                @ 0802B45C 4F28     
ldr     r0,[r7]                @ 0802B45E 6838     
ldr     r0,[r0]                @ 0802B460 6800     
lsl     r0,r0,#0xD                @ 0802B462 0340     
lsr     r0,r0,#0xD                @ 0802B464 0B40     
mov     r1,#0x80                @ 0802B466 2180     
lsl     r1,r1,#0x8                @ 0802B468 0209     
mov     r10,r1                @ 0802B46A 468A     
and     r0,r1                @ 0802B46C 4008     
cmp     r0,#0x0                @ 0802B46E 2800     
bne     #0x802B47A        @If it proc'd                @ 0802B470 D103     
mov     r0,r6                @ 0802B472 1C30     
mov     r1,r8                @ 0802B474 4641     
bl      #0x802B278        @Checks for classes 0x23 and 0x24 (Wyvern Knights). Pierce proc?                @ 0802B476 F7FFFEFF 
ldr     r2,[r7]                @ 0802B47A 683A     
ldr     r0,[r2]                @ 0802B47C 6810     
lsl     r0,r0,#0xD                @ 0802B47E 0340     
lsr     r0,r0,#0xD                @ 0802B480 0B40     
mov     r1,#0x80                @ 0802B482 2180     
lsl     r1,r1,#0x9                @ 0802B484 0249     
and     r0,r1                @ 0802B486 4008     
cmp     r0,#0x0                @ 0802B488 2800     
beq     #0x802B48E                @ 0802B48A D000     
mov     r4,#0x0           @If pierce use 0 as defense.                @ 0802B48C 2400     
mov     r0,r9                @ 0802B48E 4648     
lsl     r1,r0,#0x10                @ 0802B490 0401     
asr     r1,r1,#0x10                @ 0802B492 1409     
lsl     r0,r4,#0x10                @ 0802B494 0420     
asr     r0,r0,#0x10                @ 0802B496 1400     
sub     r1,r1,r0          @Damage = might - def                @ 0802B498 1A09     
strh    r1,[r5,#0x4]                @ 0802B49A 80A9     
ldr     r0,[r2]                @ 0802B49C 6810     
lsl     r0,r0,#0xD                @ 0802B49E 0340     
lsr     r0,r0,#0xD                @ 0802B4A0 0B40     
mov     r1,r10                @ 0802B4A2 4651     
and     r0,r1                @ 0802B4A4 4008     
cmp     r0,#0x0                @ 0802B4A6 2800     
beq     #0x802B4AE        @If no great shield, jump                @ 0802B4A8 D001     
mov     r0,#0x0                @ 0802B4AA 2000     
strh    r0,[r5,#0x4]                @ 0802B4AC 80A8     
ldrh    r0,[r5,#0xC]      @Final crit                @ 0802B4AE 89A8     
mov     r1,#0x0                @ 0802B4B0 2100     
bl      #0x802A52C                @ 0802B4B2 F7FFF83B 
lsl     r0,r0,#0x18                @ 0802B4B6 0600     
asr     r4,r0,#0x18                @ 0802B4B8 1604     
cmp     r4,#0x1                @ 0802B4BA 2C01     
bne     #0x802B52C        @If no critical, jump.                @ 0802B4BC D136     
      mov     r0,r6                @ 0802B4BE 1C30     
      mov     r1,r8                @ 0802B4C0 4641     
      bl      #0x802B38C        @Necromancer and demon king checks. Lethality proc.                @ 0802B4C2 F7FFFF63 
      lsl     r0,r0,#0x18                @ 0802B4C6 0600     
      cmp     r0,#0x0                @ 0802B4C8 2800     
      beq     #0x802B50C        @If no lethality jump.                @ 0802B4CA D01F     
            ldr     r4,[r7]                @ 0802B4CC 683C     
            ldr     r3,[r4]                @ 0802B4CE 6823     
            lsl     r1,r3,#0xD                @ 0802B4D0 0359     
            lsr     r1,r1,#0xD                @ 0802B4D2 0B49     
            mov     r0,#0x80                @ 0802B4D4 2080     
            lsl     r0,r0,#0x4                @ 0802B4D6 0100     
            orr     r1,r0                @ 0802B4D8 4301     
            ldr     r2,=#0xFFF80000                @ 0802B4DA 4A0A     
            mov     r0,r2                @ 0802B4DC 1C10     
            and     r0,r3                @ 0802B4DE 4018     
            orr     r0,r1                @ 0802B4E0 4308     
            str     r0,[r4]                @ 0802B4E2 6020     
            mov     r0,#0x7F                @ 0802B4E4 207F     
            strh    r0,[r5,#0x4]                @ 0802B4E6 80A8     
            ldr     r3,[r4]                @ 0802B4E8 6823     
            lsl     r0,r3,#0xD                @ 0802B4EA 0358     
            lsr     r0,r0,#0xD                @ 0802B4EC 0B40     
            ldr     r1,=#0xFFFF7FFF                @ 0802B4EE 4906     
            and     r0,r1                @ 0802B4F0 4008     
            and     r2,r3                @ 0802B4F2 401A     
            orr     r2,r0                @ 0802B4F4 4302     
            str     r2,[r4]                @ 0802B4F6 6022     
            b       #0x802B52C                @ 0802B4F8 E018      
      ldr     r3,[r7]           @Critical but no lethality.                @ 0802B50C 683B     
      ldr     r2,[r3]                @ 0802B50E 681A     
      lsl     r1,r2,#0xD                @ 0802B510 0351     
      lsr     r1,r1,#0xD                @ 0802B512 0B49     
      orr     r1,r4                @ 0802B514 4321     
      ldr     r0,=#0x7FFFF                @ 0802B516 4815     
      and     r1,r0                @ 0802B518 4001     
      ldr     r0,=#0xFFF80000                @ 0802B51A 4815     
      and     r0,r2                @ 0802B51C 4010     
      orr     r0,r1                @ 0802B51E 4308     
      str     r0,[r3]                @ 0802B520 6018     

      mov     r0,#0x4                @ 0802B522 2004     
      ldsh    r1,[r5,r0]        @Load damage                @ 0802B524 5E29     
      lsl     r0,r1,#0x1                @ 0802B526 0048     
      add     r0,r0,r1                @ 0802B528 1840     
      strh    r0,[r5,#0x4]      @Store back.                @ 0802B52A 80A8     

ldr     r4,=#0x203A4D4                @ 0802B52C 4C11     
mov     r1,#0x4                @ 0802B52E 2104     
ldsh    r0,[r4,r1]                @ 0802B530 5E60     
cmp     r0,#0x7F                @ 0802B532 287F     
ble     #0x802B53A                @ 0802B534 DD01     
mov     r0,#0x7F                @ 0802B536 207F     
strh    r0,[r4,#0x4]                @ 0802B538 80A0     
mov     r1,#0x4                @ 0802B53A 2104     
ldsh    r0,[r4,r1]                @ 0802B53C 5E60     
cmp     r0,#0x0                @ 0802B53E 2800     
bge     #0x802B546                @ 0802B540 DA01     
mov     r0,#0x0                @ 0802B542 2000     
strh    r0,[r4,#0x4]                @ 0802B544 80A0    
@damage kept between 0-127 
mov     r0,r6                @ 0802B546 1C30     
mov     r1,r8                @ 0802B548 4641     
bl      #0x802B3D0                @ 0802B54A F7FFFF41 
mov     r1,#0x4                @ 0802B54E 2104     
ldsh    r0,[r4,r1]                @ 0802B550 5E60     
cmp     r0,#0x0                @ 0802B552 2800     
beq     Proc_End     @did you tink?  (need to also check for miss flag tbh)      @ 0802B554 D003     
mov     r1,r6                @ 0802B556 1C31     
add     r1,#0x7C     @set zero damage flag (for exp)           @ 0802B558 317C     
mov     r0,#0x1                @ 0802B55A 2001     
strb    r0,[r1]                @ 0802B55C 7008
Proc_End:   
pop     {r3-r5}                @ 0802B55E BC38     
mov     r8,r3                @ 0802B560 4698     
mov     r9,r4                @ 0802B562 46A1     
mov     r10,r5                @ 0802B564 46AA     
pop     {r4-r7}                @ 0802B566 BCF0     
pop     {r0}                @ 0802B568 BC01     
bx      r0                @ 0802B56A 4700     
bl      lr+#0xFFE                @ 0802B56C FFFF     
lsl     r7,r0,#0x0                @ 0802B56E 0007     
lsl     r0,r0,#0x0                @ 0802B570 0000     
bl      lr+#0xFF0                @ 0802B572 FFF8     
add     r4,=#0x802B8C8                @ 0802B574 A4D4     
lsl     r3,r0,#0x8                @ 0802B576 0203     