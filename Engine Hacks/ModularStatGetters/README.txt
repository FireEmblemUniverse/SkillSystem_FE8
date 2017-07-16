Modular Stat Getters allows you to customize the stat computation "pipeline" (no actual pipelining involved because lol multitasking on gba). In other words, you can specify a list of "modifier" routines to allow you to easily add on the stat calculation.

This was originally made allow the adding of stat boosts coming from held items or skils (see circles' skill system) without having to rewrite the entire stat getters.

Main.event is the example file. It contains definitions for Vanilla Stat Getter Behaviour.

To Install, include InstallBLRange.event while EA is in BL Range, and Install.event wherever else. You also need to specify your stat getter modifier arrays, see Main.event for an example (Ask me (StanH_) about it on the forum or the Discord if you don't understand it).

STAT GETTER MODIFIER ARRAY:
	The Stat Getter Modifier Array is an null terminated array of routine pointers that returns the modified stat given its arguments (see below for specific details).
	Ex: POIN pGetUnitPow pGetEquipPow p

THE THUMB MACRO:
	"thumb(routinePtr)" is equivalent to "(routinePtr | 1)", it is used to specify that a pointer is of a thumb routine (most if not all routines here are thumb, so in doubt add it). I may change this is the future (routines would be considered thumb by default).

*** WARNING: TECHNICAL ASM STUFF ***

STAT MODIFIERS ROUTINES:
	Arguments: r0 = current stat value, r1 = unit struct ptr
	Returns: r0 = modified stat value

CONDITIONAL MODIFIER TEMPLATE: (Helper)
	The Macro "ConditionalExecRoutine(checkRoutine, execRoutine)" Will generate routine that will exectute the routine "execRoutine" only if "checkRoutine" returns r0 != 0.

OTHER HELPER MODIFIER TEMPLATES:
	"AddUnitStatRoutine(stat)": Loads byte #stat in char struct and adds it to the result

	"SubstractValueRoutine(amount)": Substract (fixed) amount to the result
	"AddValueRoutine(amount)": Add (fixed) amount to the result
	
HELPER CHECK TEMPLATES: (For use with ConditionalExecRoutine)
	"NegatedCheckRoutine(checkRoutine)": Returns the opposite result of checkRoutine (checkRoutine is a pointer to a routine, don't forget the thumb macro!)
	
	"CheckAttribueRoutine(attribute)": Returns true if the unit has given attribute (Attributes: orred WORD at 0x28 in ROM char & class structs)
	"CheckStateFlagRoutine(stateFlag)": Returns true if the unit has given state flag set (State Flags: WORD at 0xC in RAM char struct)
