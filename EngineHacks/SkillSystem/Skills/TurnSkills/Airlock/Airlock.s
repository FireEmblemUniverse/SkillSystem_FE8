.thumb
.org 0x0
.equ AirlockID, SkillTester+4
.equ ChapterData, 0x202BCF0

@The way this skill is set up is that depending on where the skill holder is, we could end up making a maximum of 191 skill tester calls
@However, even with over 100 skill tester calls, we're unlikely to go above 150,000 cycles (half a frame)
@And once the first turn is over, this skill barely consumes 30 cycles on subsequent runs 

push {r4-r7, lr}

@check to see if this is the first turn
ldr r0, =ChapterData
ldrh r1,[r0,#0x10]   @load the turn short
mov r2,#1            @value to compare against
cmp r1,r2            @compare to see if this is the first turn
bne End              @if not, we branch to the end

@Start looping through all deployed units
ldr r6, Unit_Pointers
mov r7, #0x0
look_for_unit__asdfgh:			@Name mangling for copy-pasta-bility
	lsl r2, r7, #0x2
	ldr r3, [r6, r2]
	cmp r3, #0x0 				@Is the slot valid?
	beq loop__asdfgh 			@Nope
	ldr r2, [r3] 				@is there a character here?
	cmp r2, #0x0
	beq loop__asdfgh @Nope
	@Perform skill tester check
    ldr r0, SkillTester
    mov lr, r0
    mov r0, r3 @attacker data
    ldr r1, AirlockID
    .short 0xf800
    cmp r0, #0
    beq loop__asdfgh

    @change weather to clear
    Airlock:
    ldr  r0, =ChapterData
    mov  r1, #0x0               @weather byte - clear
    strb r1, [r0,#0x15]         @store the weather byte
    b    End

loop__asdfgh:
	add r7, #0x1
	cmp r7, #0xBF 				@Have we checked 0xBF units?
	bgt End						@The unit we were looking for is not deployed.
	b look_for_unit__asdfgh

End:
pop {r4-r7, r15}

.align
Unit_Pointers:
	.long 0x0859A5D0
.ltorg
SkillTester:
@Poin SkillTester
@WORD AirlockID
