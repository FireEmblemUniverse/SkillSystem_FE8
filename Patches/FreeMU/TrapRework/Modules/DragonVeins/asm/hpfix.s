.thumb
.include "header.h"

@hook at 808c360 with jumpToHack()

HPFix:
push {r4,lr}
mov r4, r1

ldr     r2, =0x202bcb0         @@ 0808CCCC 4A25        @@ Grabs character in RAM
mov     r1, #0x16           @@ 0808CCCE 2116        @@ at location
ldsh    r0, [r2, r1]        @@ 0808CCD0 5E50        @@ 
ldr     r1, =0x0202E4D8      @@ 0808CCD2 4925        @@ 
ldr     r1, [r1]            @@ 0808CCD4 6809        @@ 
lsl     r0, r0, #0x02       @@ 0808CCD6 0080        @@ 
add     r0, r0, r1          @@ 0808CCD8 1840        @@ 
mov     r3, #0x14           @@ 0808CCDA 2314        @@ 
ldsh    r1, [r2, r3]        @@ 0808CCDC 5ED1        @@ 
ldr     r0, [r0]            @@ 0808CCDE 6800        @@ 
add     r0, r0, r1          @@ 0808CCE0 1840        @@ 
ldrb    r0, [r0]            @@ 0808CCE2 7800        @@ 
cmp r0, #0
beq End

ldr r0, =0x2120
strh r0, [r4]
add r0, #1
strh r0, [r4, #2]
mov r2, #0
strh r2, [r4, #4]
strh r2, [r4, #6]
add r0, #0x1d
strh r0, [r4, #8]
strh r2, [r4, #0xA]
strh r2, [r4, #0xC]
End:
pop {r4, pc}
