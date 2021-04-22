.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


@壊すコードの再送
ldsh r3, [r0, r2] @pointer:0203A54C (BattleUnit@gBattleActor 戦闘アニメで右側.battleHitRate )
mov r0 ,r4
mov r1, #0x24
mov r2, r9

Start:
push {r4,r5,r6}
mov r4 ,r0
mov r5 ,r2
mov r6 ,r3
blh 0x08003e54   @Text_SetXCursor
mov r0 ,r4
mov r1 ,r5
blh 0x08003e60   @Text_SetColorId
mov r0 ,r4
mov r1 ,r6
bl Text_AppendNumberOr2Dashes_Unisngned
pop {r4,r5,r6}

ldr r3,=0x0801E98C+1
bx r3

Text_AppendNumberOr2Dashes_Unisngned:
push {r4,lr}
mov r4 ,r0
cmp r1, #0xff
beq Text_AppendNumberOr2Dashes_Unisngned_def
    mov r0, #0x1
    neg r0 ,r0
    cmp r1 ,r0
    bne Text_AppendNumberOr2Dashes_Unisngned_def
    mov r1, #0x8
    neg r1 ,r1
    mov r0 ,r4
    blh 0x08003e58   @Text_Advance
ldr r0, =0x535
blh 0x0800a240   @GetStringFromIndex
mov r1 ,r0
mov r0 ,r4
blh 0x08004004   @Text_AppendString
b exit

Text_AppendNumberOr2Dashes_Unisngned_def:
mov r0 ,r4
blh 0x08004074   @Text_AppendDecNumber

exit:
pop {r4}
pop {r0}
bx r0
