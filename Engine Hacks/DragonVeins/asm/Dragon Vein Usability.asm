.thumb
.equ SkillTester, DVTrapID+4
.equ DragonsBloodID, SkillTester+4
push    {r14}
ldr     r0, CurrentUnit     @Active unit
ldr     r2,[r0]
@ ldr     r0,[r2]
@ ldr     r1,[r2,#0x4]
@ ldr     r0,[r0,#0x28]       @Skills
@ ldr     r1,[r1,#0x28]
@ orr     r0,r1
@ mov     r1,#0x20
@ lsl r1, #0x8
@ and     r0,r1               @Lord skill
@ cmp     r0,#0x0

@check for DragonsBlood skill
ldr r0, SkillTester
mov lr, r0
mov r0, r2
ldr r1, DragonsBloodID
.short 0xF800
cmp r0, #0

beq     retFalse            @No
ldr     r0, CurrentUnit     @Active unit
ldr     r2,[r0]
ldr     r0,[r2,#0xC]        @Turn status
mov     r1,#0x60            @0x60 - being rescued, has moved
and     r0,r1
cmp     r0,#0x0
bne     retFalse            @No
@080248E8 480A     ldr     r0,=#0x202BCB0    @Something about current/selected unit data? Map state? Skirmish?
@080248EA 303D     add     r0,#0x3D          
@080248EC 7801     ldrb    r1,[r0]           
@080248EE 2008     mov     r0,#0x8
@080248F0 4008     and     r0,r1
@080248F2 2800     cmp     r0,#0x0
@080248F4 D110     bne     #0x8024918
mov     r0,#0x10            @X
ldsb    r0,[r2,r0]
mov     r1,#0x11            @Y
ldsb    r1,[r2,r1]
ldr r3, GetTrap             @Gets the (first) trap that is on the same XY as this unit.
bl goto_r3
@mov lr, r3
@.short 0xF800               @bl lr
cmp     r0,#0x0
beq     retFalse            @If no trap
ldrb    r0,[r0,#0x2]        @trap type
ldr r1, DVTrapID
cmp     r0,r1             @DV
bne     retFalse            @
mov     r0,#0x1
b       end

.align
CurrentUnit:
    .long 0x03004E50
GetTrap:
    .long 0x0802E1F1

retFalse:
mov     r0,#0x3
end:
pop     {r3}
goto_r3:
bx r3

.align
.ltorg
DVTrapID:
@WORD DVTrapID
@POIN SkillTester
@WORD DragonsBloodID
