.thumb
push {r4-r5,lr}
ldr r1, =0x30004BC @slot 1 location
@instead to this

ldr r0,[r1]
ldr r3,=0x8037841
bl goto_r3

@ ldr r4,[r1] @pointer to trap data
@ Loop:
@ ldrb r2, [r4]           @Yay dynamic
@ cmp r2, #0 @is it the end?
@ beq End
@ mov r0, #0x1
@ mov r1, #0x2
@ ldsb r0, [r4, r0]
@ ldsb r1, [r4, r1]
@ ldr r3, =0x0802E2B9   @spawn trap
@ bl goto_r3              @returns pointer to the trap data allocated
@ ldrb r1, [r4, #0x3]
@ strb r1, [r0, #0x3]

@ @Need to copy more than just this
@ ldrh r1, [r4, #0x4]
@ strh r1, [r0, #0x4]
@ add r4, #6
@ b Loop

End:
pop {r4-r5}
pop {r3}
goto_r3:
bx r3
