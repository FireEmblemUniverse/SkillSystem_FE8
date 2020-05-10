.thumb
@.global IE_InflictStatusEffect
@.type IE_InflictStatusEffect, %function

IE_InflictStatusEffect:
bl Item_GetStat_EPV_Jump	@get effect value byte
mov r1, #0xF
and r1,r0	@get status effect
lsr r2,r0,#0x4	@get status duration

