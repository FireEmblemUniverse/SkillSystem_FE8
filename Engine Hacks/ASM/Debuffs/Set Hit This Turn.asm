.thumb
.org 0x2B422

cmp     r0,#0x0             @22
bne     newHit              @24
ldr     r3,[r5]             @26
ldr r1, [r3]                @28
mov     r0,#0x2             @2A
orr r0, r1                  @2C
str     r0,[r3]             @2E
b       end    @end         @30
newHit:
mov r0, #0x7C               @32
ldrb r1, [r6, r0]           @34
mov r2, #0x2                @36
orr r1, r2                  @38
strb r1, [r6, r0]           @3A
b onHit                     @3C

lsl r0, #0x0                @3E

.long 0x0203A4D4            @40
.long 0x0203A608            @44
.long 0xFFF80000            @4C

.org 0x2B44C
onHit:

.org 0x2B55E
end:

