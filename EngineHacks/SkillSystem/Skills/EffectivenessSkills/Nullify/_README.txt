If ENABLE_SLAYER_AND_EFFECTIVENESS_REWORK is commented out (in Config.event), you can basically ignore the rest of this text.

If not commented, then this rework will come into play.
Each class weakness/weapon effectiveness is now a "class type", a bit in a bitfield.

Class weaknesses use a word at +0x50 (currently unused). This is set via the class data editor csv, or whatever way you edit tables. The definitions (ArmorType, HorseType, etc) are in Tables/Table Definitions.txt. Class weaknesses have been filled in for existing classes in the csv because that isn't used, while effectiveness data is set in Nullify EA.txt

Items have a "effectiveness pointer" at +0x10 that would normally point to a list of classes this weapon is effect against. Instead, it now points to a list of entries that use the macro SetWeaponEffectiveness(class types this weapon is effective against, (coefficient to multiply by)*2)), terminated with a WORD 0. The coefficient is multipled by 2 to allow half-integer coefficients (if you wanted to do 2.5x, for instance, you could).
Example: The rapier does 3x damage to armor and cavalry types. Therefore, the rapier list would look like SetWeaponEffectiveness(ArmorType|CavalryType, 6).
Example: Nidhogg does 3x damage to fliers as a bow, but only 2x damage to monsters as a sacred weapon. This is where the ability to have different coefficients for the same weapon comes in handy:
SetWeaponEffectiveness(FlierType, 6)
SetWeaponEffectiveness(MonsterType, 4)
If a class has multiple weaknesses, like the Gargoyle being both a flier and a monster, the first entry that qualifies will be used. Using the above example, Nidhogg would use the 3x multipler, since that's read first.

Protector items, such as the Fili Shield, also use the 'effectiveness pointer' at +0x10 to point to a list of class types that the item protects from effective damage, using the SetProtection(class types) macro.
Fili shield entry would be SetProtection(Fliers).
To distinguish them from effective items, bit 0x4000 is set in the Item Abilities word at +0x8 (called Negate Flying Weakness in the nightmare module). This means protector items can't be effective weapons, and vice versa.
NOTE: This will change one aspect from vanilla FE8: The fili shield protects gargoyles from Nidhogg, despite it being a sacred weapon as well as a bow. In this rework, the Shield would negate the flier weakness, but not the monster weakness, so Nidhogg would deal 2x damage.

Slayer works similarly to effective items, except the entries are gathered in a table, and entries are set with the SetSlayerTableEntry(Class id, class types this class has slayer against, coefficient*2).
Example: SetSlayerTableEntry(Bishop, MonsterType, 6)
Note that the class needs to have the Slayer skill to even read this table; if you just add an entry but don't give them the skill, nothing will happen. If you give them the skill and don't update the table, well, nothing happens either.
The Slayer Table can be found in Nullify EA.txt, NOT in Table Definitions, since it's not part of an existing table

If a class has both slayer and an effective weapon, and both affect the target, the higher coefficient will be used. This allows Bishops to do 3x damage with Ivaldi, rather than doing the conventional 2x damage.

The Nullify skill negates bonus damage from both effective weapons AND slayer. Protector items will negate bonus damage from effective weapons, but not Slayer.

If you're confused, look at the existing examples in Nullify EA.txt.