AI4 as Group AI - Works for FE8 Skill System ONLY!
By Phantom Sentine

Installation:
1) #include "GroupAI.event" somewhere in your buildfile
2) Add "GroupAI" to the Post Battle Calc Loop at "SkillSystem_FE8-master\Engine Hacks\Necessary\CalcLoops\PostBattleCalcLoop\PostBattleCalcLoop.event"
(I've found that the higher up in the order you add it, the better)

How to Use:
You can either use one of the pre-defined AIs when adding units to your chapter events file, like so:

Enemies4:
UNIT 0x80 Fighter 0x00 Level(10, Enemy, 1) [8,26] 0x00 0x00 0x0 0x00 [IronAxe] GroupOneAI
UNIT 0x80 Fighter 0x00 Level(10, Enemy, 1) [9,26] 0x00 0x00 0x0 0x00 [IronAxe] GroupOneAI
UNIT 0x80 Fighter 0x00 Level(10, Enemy, 1) [9,23] 0x00 0x00 0x0 0x00 [IronAxe] GroupOneAI
UNIT 0x80 Archer 0x00 Level(10, Enemy, 1) [7,24] 0x00 0x00 0x0 0x00 [IronBow] GroupOneAI
UNIT 0x80 Archer 0x00 Level(10, Enemy, 1) [6,25] 0x00 0x00 0x0 0x00 [IronBow] GroupOneAI
UNIT

You can also asign groups manually, if you want more fine precision over AI1-3. The first five bits (0x01-0x1F) of AI4 are used to designate unit groups (AI Groups ignore bits 6-8, so an AI4 of 0x02 is treated as being in the same group as an AI4 of 0x22).

After ANY unit in an AI Group is in combat (regardless of whether the player or enemy initiated) all other red units in that AI Group have their AI2 set to 0x0, i.e. move towards enemy units. All units in that group also have their AI Group scrubbed from AI4, so that the AI Group code won't run again every time they are in combat. It also adds all those units to the end of the AI activation queue, otherwise units that the enemy AI has already checked that enemy phase won't move. This creates a bit of a quirk where some enemy units in a group won't activate until most every other enemy unit has moved, but in practice this doesn't have much of a practical impact.