This file is a modified version of sme's StatusWeapons.
There are three advantages over the original.

1. Does not depend on the item table address
2. Do not use Item+0x22.
   Only use Item+0x1f
     Item+0x1f 6 Sleep
               7 Bersak
               8 Silence
3. If the enemy sleeps or confused, they will not counter.


How to use?
#include "StatusWeapons2.event"

And add it to ProcLoopParent as follows.

```
ProcLoopParent:
#incbin "ProcLoop/proc_loop.dmp"
POIN Proc_Start	//start

POIN Proc_Devil	//devil effect
POIN Proc_Sureshot Proc_Luna Proc_Moonbow Proc_Adept Proc_DragonFang Proc_Eclipse	//skills that do damage and all that
POIN Proc_Impale Proc_Colossus Proc_Ignis Proc_AetherDamage Proc_Corona Proc_Flare Proc_Glacies Proc_Vengeance //more damage
POIN Proc_Astra	//astra should be the last one before the ones that set damage
POIN Proc_Bane DownWithArch Proc_Lethality	//skills that set damage to max
POIN Proc_CapDamage	//check that damage is not over cap
POIN Proc_Foresight Proc_Miracle Proc_Mercy Proc_Aegis Proc_Pavise Proc_GreatShield 	//skills that set damage to 0 or lower it
POIN Proc_StealHP Proc_Sol Proc_AetherHeal	//skills that heal based on final damage
POIN Proc_BlackMagic Proc_Petrify Proc_Enrage Proc_Deadeye //skills that apply a status effect
POIN Proc_Corrosion //skills that don't affect damage

#ifdef __Proc_StatusWeapons2__  //<<<<<<<<<<<<<<<
POIN Proc_StatusWeapons2        //<<<<<<<<<<<<<<<
#endif                          //<<<<<<<<<<<<<<<

POIN Proc_Counter Proc_CounterMagic	//counters are last
POIN Proc_FlashyMode
POIN Proc_Finish 0	//end
```

Known issues:
No chase attack when enemies are in bad status.
