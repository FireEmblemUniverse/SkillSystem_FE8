@ hook at 8025180 
.thumb 
.align 4 
@push {r4, r14}
@mov r4, r0 
.global AddUnitToTargetListHack
.type AddUnitToTargetListHack, %function 

AddUnitToTargetListHack:
ldr r0, =0x2033F3C @ gUnitSubject 
ldr r0, [r0] 


@ldr r1, [r0]
@ldrb r1, [r1, #4] @Active Unit ID 

ldr r3, [r4]
ldrb r3, [r3, #4] @Target Unit ID 
@ We cannot target unit ids 0xE0-0xEF, 0xFA-0xFD 
cmp r3, #0xE0 
blt Continue 
cmp r3, #0xFA 
beq Skip 
cmp r3, #0xFB
beq Skip 
cmp r3, #0xFC
beq Skip 
cmp r3, #0xFD
beq Skip 

cmp r3, #0xF0 
bge Continue 

b Skip 
Continue:  

@mov r31, r31 
ldr r3, [r0, #0x0C] @ Unit State 
mov r0, #0x40 
lsl r0, #24 @ Capture bit 
@mvn r0, r0
and r0, r3 
@mov r31, r31 
cmp r0, #0 
beq WeCanTarget @ Not capturing, so any other unit ID is fine 
ldr r3, [r4] 
ldrb r3, [r3, #4] @ Target Unit ID 
cmp r3, #0xA0 
blt WeCanTarget @ we can only target unit IDs below 0xA0 whilst capturing 
b Skip @ We can never target units with IDs above 0xA0 whilst capturing 


WeCanTarget: 


ldr r0, =0x2033F3C @ gUnitSubject 
ldr r0, [r0] 
ldrb r0, [r0, #0x0B] 
lsl r0, #0x18 

ldr r3, =#0x8025189 @ Return address 
bx r3 


.align 4 
Skip:


mov r11, r11 
pop {r4} 
pop {r0}
bx r0 
@ldr r0, =0x80251AD @ Return address 
@bx r0 
@ pop {r0} 
@ bx {r0} 
