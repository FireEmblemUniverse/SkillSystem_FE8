INSTALL
  Install by using Event Assembler to apply "FogDR.event" to an FE8U ROM, or include 
  "FogDR.event" in your buildfile.
  
  I've PROTECTed some areas that SkillSystem at least overwrites. If any of these PROTECT triggers you can 
  either #include FogDR.event after the thing that triggers the PROTECT, put a don't-do-this-if-FogDR-exists 
  condition on the areas that are trying to overwrite PROTECTed stuff, or remove the stuff that's overwriting 
  PROTECTed addresses entirely. There are three likely things that could conflict:
    - HP bars overwrites a pointer to system icons. I've prepared an HP bars version of system icons as well.
    - Capture hooks in 0x18400. I implemented the thing Capture wants to do in my hooked routine.
    - ItemRangeFix has reserved r12 and changed MapAddInRange to store stuff on the stack instead of in r12. As 
    a result 0x1AB12 and 0x1AB16 are overwritten. I hook here. I've made sure not to use r12 in the hooked 
    routine here.
  
  I haven't tried inserting this in FEBuilder, but feel free to. I don't know if it'll work due to certain 
  things relying on #ifdefs. If something doesn't work (whether that'd be when inserting through FEBuilder, 
  buildfiles, cheese, w/e, feel free to tell me. If you're installing the latest version of FogDR over a
  previous version of FogDR, there are a few hooks that could break. Keep an eye on the hooks for "ClearDR1", 
  "DRHook", "RefreshFog" and "UpdateDRMove" and see if there's anything happening there that wasn't specified
  in the "FogDR/ASM/ASM.event" or "FogDR/ASM/ClearDR/ClearDR.event", yet differs from vanilla. These files
  insert the relevant hooks.

  If you're using Modular Stat Getters, be sure to set MSG to True in FogDR.event. The SkillSystem build I'm 
  using, from January 2021, iIrc, does use Modular Stat Getters. Likewise, if you're not using Modular Stat 
  Getters, set MSG to False.


CUSTOMIZE
  These variables can be changed in FogDR.event
  
  DRCountByte. Pick a byte in RAM which is unused. This value should not be saved on regular or suspend save.
  By default DRCountByte is set to 0x300 0006, which is unused by vanilla.
  
  DRUnitByte and DRUnitBit indicate which bit of which byte in RAM Unit Struct (entries of these start at
  0x202 BE4C) is to be reserved. This bit will indicate the unit should display their Danger Radius. This will 
  only affect enemies. Ally and NPC Unit Structs aren't altered. By default, bit 7 of byte 0x39 is reserved.
  
  NearbyTiles defines when an enemy is nearby. an Enemy is nearby if there's an ally or NPC within NearbyTiles 
  tiles of that enemy.
  
  NonEnemySELECT can be defined as either NoDR, AllDR or NearbyDR. When pressing select whilst hovering over an 
  empty tile or a unit who is not of enemy allegiance and no Danger Radius is active, the following happens:
    - if NonEnemySelect is set to NoDR, nothing happens.
    - if NonEnemySelect is set to AllDR, every enemy's Danger Radius will activate.
    - if NonEnemySelect is set to NearbyDR, every nearby enemy's Danger Radius will activate.
  

WHATITDO?
  This patch implements Danger Radius. Unlike Danger Zone, the danger radius of individual enemy units can be 
  viewed by pressing the select button when hovering over their map sprite. Pressing select again will disable
  their danger radius.

  I also made some macros for some ASMCs:

    - CheckDangerRadius(charID): Returns 1 if true - currently displaying the Danger Radius for charID.

    - CheckDangerRadius(X, Y): Returns 1 if true - currently displaying the Danger Radius for unit at 
      coordinates X, Y.

    - SetDangerRadius(charID): Sets the Danger Radius for charID.

    - SetDangerRadius(X, Y): Sets the Danger Radius for unit at coordinates X, Y.

    - UnsetDangerRadius(charID): Unsets the Danger Radius for charID.

    - UnsetDangerRadius(X, Y): Unsets the Danger Radius for unit at coordinates X, Y.

    - SetAllDangerRadius: Sets every enemy’s Danger Radius.

    - UnsetAllDangerRadius: Unsets every enemy’s Danger Radius.
    
    - SetNearbyDangerRadius: Sets the Danger Radius for all nearby enemies.


LIMITATIONS
  The Fog of War palette is used to display danger radius. To avoid conflicts, If Fog of War is active during 
  a map, Danger Radius is replaced by the more standard Danger Zone as was originally implemented (but not 
  available) in vanilla FE8U. I’d recommend not using the custom ASMCs during FOW.
  
  Depending on the size of a map, calculation of multiple units’ danger radii could slow down the game 
  considerably. Make sure not to have too many units’ danger radii active, if you want to avoid lag. Fewer 
  than a dozen should be safe.
  
  Danger Radius automatically disables itself when the current phase is not player phase. It can, of course, be 
  re-enabled during player phase.

  As mentioned in CUSTOMIZE, a byte in RAM and a bit in RAM enemy unit structs are reserved. Make sure these 
  are available.

  I've also repurposed a bit in the GameState bitfield. 0x202BCB0 +0x4, bit 3 is used to indicate to SetFog 
  that FogMap should be filled in instead of SubjectMap. It's set by InitializeDR before MapAddInRange is 
  called, and unset after. I didn't run into any issues with this yet. This bit seems to originally have been 
  used to indicate dangerzone is active.

FOW PALETTE
  I created this Python program which you can use to change the FOW palette of a tileset. It's in the Graphics 
  directory. Simply run:
  
  Python TilesetFogFilter -i <inputTilesetPalette.dmp> -o <outputTilesetPalette.dmp> -r <redModifier> -g <greenModifier> -b <blueModifier>
  
  Python3 works too.
  
  The way this works is as such: The program will copy the first five palettes of the input to the output. 
  Then it'll go over the first five palettes of the input again, but change each colour's R, G and B values by 
  adding the respective <colour>Modifier to it, before writing it to the output. This way you can apply a 
  primitive colour filter to the non-fog palettes for your fog palettes.
  
  By default redModifier = 4, greenModifier = blueModifier = -16. This gives it a red hue which seemed 
  familiar to me. Feel free to pick your own colours, of course.
    
    
CONCLUDING
  Here's what I wrote back in Fall 2020:
  
    So, Danger Area got a lot of feedback, and it seems that for a number of people, not being able to use Fog 
    of War as a result of the Danger Area patch was a dealbreaker. Allowing both Danger Area/Radius and FOW on 
    a map wouldn’t be possible due to certain limitations, but giving people the choice between either on a 
    map-by-map basis was certainly doable. Personally, and I’m sure others would have this issue too, I 
    couldn’t stand the lag that came with Danger Zone as soon as not even two-dozen enemies were present on a 
    semi-big map.

    Danger Radius aims to fix these two issues. Unlike Danger Area, Danger Radius is implementable on vanilla 
    FE8U. I’ve made a version for the SkillSystems as well. Hopefully it won’t get deprecated any time soon.

    I’m also planning, somewhere further in the future, probably within the next year, to come back to this 
    and add and rework a few more things; I’d like to remove a certain piece of hard-coding and I intend to 
    implement some option in the in-game options menu to let the player limit the max amount of active DR.

  It's May 3rd 2021 and I've finally done this rework I had been thinking about since (although there's no 
  option in the in-game options menu, boo!) Not much changed above-the-hood, but underneath it:
    - Danger Radius now has variables that can be changed simply in FogDR.event, instead of having to 
    re-assemble .asm files into .dmp files.
    - I tried to stick to certain conventions this time around (we're also using lyn now!)
    - There's just one version now, instead of separate versions based on whether you're using SkillSys or not 
    (although it's actually more related to Modular Stat Getters, curse my previous ignorance).
    - Some really specific and easily broken dependency is now removed (check whether value on user stack+0x44 
    is this specific return address to know whether you were called by some function, because if so your 
    behaviour changes).
  I won't have to lose sleep over knowing there're people using my poorly implemented patch anymore.
  
  July 23rd 2021.
    - Turns out there was still a visual error when hovering over a player unit and activating DangerZone 
    during FOW. Considering the exact circumstances that need to happen for this bug to display (I mean, I 
    don't even use FOW), I can see how it slipped under the radar. That's fixed now.
    - Vesly pointed out to me that danger radius was being recalculated unnecessarily. That's rectified now. 
    Hopefully this'll reduce lag, although it'll be by a factor of two, maybe three, at most.
    - I was considering buffering the fogmap when units take partial actions, but decided against it, 
    considering I'd have to allocate about 0x800 bytes in RAM to fit a map, and it'd only save a 
    recalculation when cancelling a partial action.
    - Changed ClearDR2. It no longer replaces the entire routine it hooks in. This should make it compatible 
    with Gamma's CasualModeMenu, https://feuniverse.us/t/hypergammaspaces-assorted-asm/4085/10


CREDITS
  - I took some of Vesly's SetNearbyDangerRadius asm. 
  https://github.com/Veslyquix/ASM/blob/main/DangerRadius/evro/SetNearbyDangerRadius.asm#L35
  - Mkol made the custom DR mark icon. I made it blue, figured it'd contrast better against red.
  - circleseverywhere made the HpBars hack which shows where the systemicons are stored. They also made the 
  DangerZone patch which I took parts of to make Danger Radius work.
  - Many thanks to Snek's tmx2tsa for working as an argparse example.
  - Huichelaar. C'est moi.