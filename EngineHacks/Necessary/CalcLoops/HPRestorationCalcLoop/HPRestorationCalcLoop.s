.thumb
.align


.global HPRestorationLoopFunc
.type HPRestorationLoopFunc, %function


HPRestorationLoopFunc: @r5 = current unit
push {r4-r7,r14}

ldr r1,=#0x880C744 	@terrain heal data
add r0,r1		
ldrb r4,[r0]		@r4 = % to heal from terrain

ldr r6,=HPRestorationLoop

LoopStart:
ldr r0,[r6]
cmp r0,#0
beq LoopExit

mov r14,r0
mov r0,r5 @r0 = unit
mov r1,r4 @r1 = heal amount
.short 0xF800
mov r4,r0

add r6,#4
b LoopStart

LoopExit:
mov r0,r4 @return the amount healed
pop {r4-r7}
pop {r1}
bx r1

