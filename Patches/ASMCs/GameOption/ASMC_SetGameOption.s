@
@ゲームオプションの設定
@
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb
.global SetGameOption
.type SetGameOption, function

SetGameOption:
push {lr}
ldr r3, =0x030004B8 @MemorySlot {U}
ldr r0, [r3, #4*1] @ slot 1 as game option 
ldr r1, [r3, #4*3] @ slot 3 as new value 
blh 0x080B1F64	@SetGameOption	r0=OptionIndex	r1=OptionValue	{U}

pop {r0}
bx r0
.ltorg
.align 
