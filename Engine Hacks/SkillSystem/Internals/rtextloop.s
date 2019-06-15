@loop for r-text
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

push {r4-r7,lr}
mov r4,r0
ldr r5, =0x2003bfc
ldr r0, [r5, #0xc]
ldr r1, SkillGetter
mov lr,r1
.short 0xf800
mov r6, r0 @save skill buffer
mov r7, r1 @save number of skills 
ldrb r2, [r0] @first skill
cmp r2, #0
bne HasSkills
mov r0, r4
blh      0x80893B4  @change to next one left
cmp r0, #1 @can it loop again?
beq End

HasSkills:
mov r1, r6
ldr     r0,[r4,#0x2C]     @current position           @ 08088B56 6AE0     
ldrh    r0,[r0,#0x12]     @slot number           @ 08088B58 8A40  
cmp r7, r0 @skill number vs total skills
ble CheckDir

add     r1,r1,r0                @ 08088B5E 1809     
ldrb    r0,[r1]           @skill number     @ 08088B60 8808     
cmp     r0,#0x0                @ 08088B62 2800     
bne     End       @has item, we're done here         @ 08088B64 D113     
CheckDir:
mov     r0,r4                @ 08088B66 1C20     
add     r0,#0x50                @ 08088B68 3050     
ldrh    r0,[r0]        @direction        @ 08088B6A 8800     
cmp     r0,#0x0                @ 08088B6C 2800     
beq     GoLeft                @ 08088B6E D003     
cmp     r0,#0x10    @right            @ 08088B70 2810     
beq     GoUp                @ 08088B72 D001     
cmp     r0,#0x40    @up            @ 08088B74 2840     
bne     GoLeft                @ 08088B76 D105

GoUp:
mov r0,r4
blh      #0x8089354    @change to next one up           @ 08088B7A F000FBEB 
b       End                @ 08088B7E E006     

GoLeft:     
mov     r0,r4                @ 08088B78 1C20     
blh 0x80893b4 @goes left
b End

@ loc_0x8088B84:
@ cmp     r0,#0x80   @down             @ 08088B84 2880     
@ bne     End                @ 08088B86 D102     
@ mov     r0,r4                @ 08088B88 1C20     
@ blh      0x8089384    @change to next one down            @ 08088B8A F000FBFB 
End:
pop     {r4-r7}                @ 08088B8E BC30     
pop     {r0}                @ 08088B90 BC01     
bx      r0                @ 08088B92 4700     

.ltorg
SkillGetter:
@POIN SkillGetter
