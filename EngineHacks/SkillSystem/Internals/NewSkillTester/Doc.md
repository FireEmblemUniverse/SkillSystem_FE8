## Structs
SkillBuffer:
```c
struct SkillBuffer {
/*00*/  u8 lastUnitChecked;
/*01*/  u8 skills[11];
};
```

AuraSkillBuffer:
```c
struct AuraSkillBuffer {
/*00*/  u8 skillID;
/*01*/  u8 distance : 6; //Relative to main unit
/*01*/  u8 faction  : 2;
};
```

```c
struct SkillTestConfig {
/*00*/  u16 auraSkillBufferLimit;
/*02*/  u8 genericLearnedSkillLimit;
/*03*/  u8 passiveSkillStack;
/*04*/  u8 roofUnitAuras;
};
```

## Functions

### IsUnitOnField(Unit* unit)
Checks if a unit is currently on the field.  

Whether or not units under roofs are considered to be on the field can be configured at `Root/EngineHacks/Config.event` with the `ROOF_UNIT_AURAS` option.  

Returns true if unit is none of the following:
- Rescued.
- Not Deployed.
- Dead.
- Hidden with REMU.
- Under a roof if units under roofs are considered not on the field.

Returns false otherwise.

### IsSkillInBuffer (SkillBuffer* buffer, u8 skillID)
Loops through a given buffer to find the given skillID.  

### NihilTester (Unit* unit, u8 skillID)
Checks if unit's opponent has Nihil and if the skill in question is negated by it.  
Negated skills are found by indexing `NegatedSkills` by skillID.  

`NegatedSkills` can be found in
`Root/EngineHacks/SkillSystem/Internals/SkillSystem.event`

Returns true if opponent has Nihil and skillID is negated.  
Returns false otherwise.  

### MakeSkillBuffer (Unit* unit, SkillBuffer* buffer)
Checks a unit for skills, stores found skills in the given buffer, then returns that buffer's address.  
If the unit is in battle, the equipped weapon data is gotten from the battle unit struct.  
Stores the RAM unitID of the last unit checked in `SkillBuffer.lastUnitChecked` for future reference.  

If a unit does not have BWL data (And is thus considered generic), their learned skills will be collected from the learned skills lists.  
The limit of learned generic skills can be configred in `Root/EngineHacks/SkillSystem/Internals/Skillsystem.event`.  

Passive item skills stacking can be configured in `Root/EngineHacks/Config.event` with the `PASSIVE_SKILLS_STACK` option.  

Returns the `SkillBuffer` pointer passed to it.  


### MakeAuraSkillBuffer (Unit* unit)
For each alive, deployed unit, calls `MakeSkillBuffer` and loops through the returned buffer to find aura skills.  
For each skill in the buffer, `AuraSkillTable` is referenced by skillID to decide if the skill is an aura skill or not.  
If an aura skill is found, a new entry in `AuraSkillBuffer` is made to save relevant information on the skill holder.  

Returns a pointer to `AuraSkillBuffer`.  

`AuraSkillTable` can be found in  
`Root/EngineHacks/Necessary/CalcLoops/PreBattleCalcLoop/PreBattleCalcLoop.event`  

The maximum number of `AuraSkillBuffer` entries can be set in `Root/EngineHacks/SkillSystem/Internals/Skillsystem.event`.

`MakeAuraSkillBuffer` can be called directly from any calcloop.  

### SkillTester (Unit* unit, int skillID)
Checks if unit has the given skill.  
If the unit is the defender, the defender skill buffer is used.    
If a different unit was checked last time, a new skill buffer is made  
If the skill is found, a check for Nihil is done on the opponent.  

Returns true if a match is found or skillID is 0.  
Returns false if no match is found, skillID is 255 or skill is negated by nihil.  


### CheckSkillBuffer (Unit* unit, int skillID)
Called by the weapon usability loop to check the skill buffer in progress for a specified skill.  
Used in order to prevent an infinite loop of `SkillTester` -> `CanUnitUseItem` -> `SkillTester`  

Returns true if a match is found or skillID is 0.  
Returns false if no match is found or skillID is 255.  


### NewAuraSkillCheck (Unit* unit, int skillID, int allyOption, int maxRange)
Loops through the AuraSkillBuffer to find a matching skill holder who matches the specified requirements.  

allyOption options are:
```
Bit 0x1:
    If set, check if allied (Matches blue and green units)
    If not set, check if in same faction

Bit 0x2:
    If set, reverse the outcome of the previous check (Mainly for checking enemies)

Bit 0x4:
    If set, the faction check is ignored and all units pass the faction test
```

Returns true if a match is found or skillID is 0.  
Returns false if no match is found or skillID is 255.  


### InitializePreBattleLoop(Unit* attacker, Unit* defender)
Calls `AuraSkillBuffer` and `MakeSkillBuffer` for the attacker. If a real battle is happening, it calls `MakeSkillBuffer` for the defender as well.  

This function is used to initialize the PreBattle loop and not have to rely on MSG calling `SkillTester` on the defender.  

Does not return a value.

### GetUnitsInRange (Unit* unit, int allyOption, int range)
Loops through each unit and checks if they meet the given requirements, and if so, their RAM unitID gets added to the `UnitRangeBuffer`.  

allyOption options are:
```
Bit 0x1:
    If set, check if allied (Matches blue and green units)
    If not set, check if in same faction

Bit 0x2:
    If set, reverse the outcome of the previous check (Mainly for checking enemies)

Bit 0x4:
    If set, all units within range are added to UnitRangeBuffer
```

Returns a pointer to `UnitRangeBuffer` if at least one matching unit is found.  
Returns 0 if no matching units are found.  


## Limitations
`NewAuraSkillCheck` only works if `MakeAuraSkillBuffer` was called prior for that unit and no units have moved since then.  
Ideally, it should be used at the beginning of calcloops.  

If a function that's not in a calcloop needs to find an aura skill, use the old `AuraSkillCheck` function.  


## New Conventions
When adding or removing an aura skill, `AuraSkillTable` must be edited accordingly.  

If a function needs to find an aura skill, use `NewAuraSkillCheck` or `AuraSkillCheck`.  

If a function needs a list of units within a certain range, use `GetUnitsInRange`.  
