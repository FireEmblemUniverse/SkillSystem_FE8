@80188e4 decreases status, jumptohack from there
@prevents decrease on enemy phase
.thumb

ldrb r3, [r1] @status
mov r0, #0xF
and r0, r3
cmp r0, #0x9 @freeze
bne Normal

@if freeze, only reduce on player phase
ldr r2, =0x202bcff @current phase
cmp r2, #0x0 @if player phase, reduce as usual
beq Normal
@otherwise do nothing.
ldr r2, =0x801891c|1
bx r2

Normal:
mov r0, r12
and r0, r3
cmp r0, #0
ldr r2, =0x80188ec|1 @go back
bx r2
