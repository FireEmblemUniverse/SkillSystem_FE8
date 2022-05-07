@
@ゲームオプションの取得
@
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb
.global GetGameOption
.type GetGameOption, function

GetGameOption:
push {lr}
ldr r3, =0x030004B8 @MemorySlot {U}
ldr r0, [r3, #4*1] @ slot 1 as game option 
blh 0x080B1DE8	@GetGameOption	RET=OptionValue	r0=OptionIndex	{U}

ldr r3, =0x030004B8 @MemorySlot {U}
str	r0, [r3, #4*0x0C]	@SlotCに結果を書き込む

pop {r0}
bx r0
.ltorg
.align 
