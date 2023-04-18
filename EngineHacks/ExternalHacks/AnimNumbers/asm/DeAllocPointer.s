@ Hooked at 0x6C70C.
@ Nulls [DamageMoji+0x60] pointer to subAnimeEmulator
@ procstate when subAnimeEmulator proc gets killed.
@ BAN_KillDigits uses this NULLed pointer so it won't
@ kill [DamageMoji+0x60] which can otherwise be a
@ re-allocated procstate (an unrelated procstate).
.thumb

@ Vanilla, overwritten by hook.
@ Deletes the subAnimeEmulator proc.
ldr   r3, =EndProc
bl    GOTO_R3

mov   r0, #0x0
str   r0, [r4, #0x60]         @ NULL [DamageMoji+0x60], pointer to subAnimeEmulator procstate.

@ Vanilla, overwritten by hook.
mov   r0, r4
ldr   r3, =BreakProcLoop
bl    GOTO_R3

ldr   r3, =0x806C717
GOTO_R3:
bx    r3
