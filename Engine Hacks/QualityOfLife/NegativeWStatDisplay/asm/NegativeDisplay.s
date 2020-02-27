@8004144 draws thing
@hook at 8004146
.thumb
.org 0
@[r0,2] contains x-pos
@r1 contains number

push {r4-r6}
mov r4, r0
cmp r1, #0xff
beq Null
    lsl r1, #0x18       @unsigned to signed byte conversion
    asr r1, #0x18
  cmp r1, #0
  bpl Normal
    ldrb r2,[r4,#2]
    mov r6,r2
    neg r1,r1
    mov r5,r1         @r5 = positive r1
    cmp r1, #0xA      @2 digit, need to move left
    blt OneDigit
      sub r2,#8
    OneDigit:
    sub r2,#8
    strb r2,[r4,#2]
    mov r1, #3
    neg r1,r1
    mov r0,r4
      ldr r3, Drawfunc @call the draw func with -3
      bl gotoR3
    strb r6,[r4,#2] @put the x pos back
    mov r1,r5
  Normal:
    mov r0,r4
      ldr r3, Drawfunc @draw the negative number
      bl gotoR3
    b End
  Null:
    mov r1,#8
    neg r1,r1
    mov r0,r4
    ldr r3,=0x8003e59
    bl gotoR3
    ldr r0,=0x535
    ldr r3,=0x800a241
    bl gotoR3
    mov r1,r0
    mov r0, r4
    ldr r3,=0x8004005
    bl gotoR3
End:
pop {r4-r6}
ldr r3,Return_to
gotoR3:
bx r3

.align
Drawfunc:
.long 0x8004075
Return_to:
.long 0x800417B
