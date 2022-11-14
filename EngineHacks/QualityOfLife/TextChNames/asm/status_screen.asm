.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ LoadChapterTitleGfx, 0x8089624 
.global status_screen_ch_name
.type status_screen_ch_name, %function 
status_screen_ch_name: 
push {lr} 
mov r1, r0 
mov r0, r4 
ldr r2, =0x8012345
blh LoadChapterTitleGfx
pop {r3}  
ldr r3, =0x808E7FD 
bx r3 
.ltorg 

