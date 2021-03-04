.thumb 

push {lr}

mov r0,r5
ldr r3,GetDebuffs
mov lr,r3
.short 0xF800
@ ldr r0, AdditionalDataTable
@ ldrb r1, [r5, #0xB]         @Deployment number
@ lsl r1, #0x3                @*8
@ add r0, r1
@ mov r1, #0x00
mov r1, #0x0
str r1, [r0]                @Clear out the first eight bytes
str r1, [r0, #0x4]

@Code that we replaced to jump here
ldrb    r0,[r6,#0x3]      @Level
lsr     r0,r0,#0x3
strb    r0,[r5,#0x8]
mov     r1,r5
add     r1,#0x10          @Hidden statuses (e.g. Afa's drops)
mov     r2,r5
pop {r3}
bx r3
.align
@ AdditionalDataTable:
GetDebuffs:
    @Handled in installer
