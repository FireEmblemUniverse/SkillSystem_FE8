
# FE8 Skill System

[Main discussion on Fire Emblem Universe](https://feuniverse.us/t/fe8-skill-system-v1-0-254-skills-done-more-on-the-way/2312)

## What is this?

This is a fully-functional system for implementing modern FE skills into Fire
Emblem 8.

This repository is intended to be installed via Event Assembler. Other methods
of installation, such as FEBuilderGBA, are not officially supported.

## Installation

1. Download or clone this repository onto your device.
2. Get a clean FE8U ROM, name it "FE8_clean.gba" and put it in the extracted folder.
3. Run `MAKE_HACK_full` to generate SkillsTest.gba, an edited copy of FE8_clean with skills added.
4. `MAKE_HACK_full` should be run whenever changes are intended to be made to the ROM. `MAKE_HACK_quick` can be run instead if not inserting any new text or tables.

## Basic Usage Notes

- Only 254 skills can be used at a time. To configure which skills are in use, use `EngineHacks/SkillSystem/skill_definitions.event`. This also doubles as a list of all skills and their effects.
- Skill effects themselves are sorted by skill type and located in `EngineHacks/SkillSystem/Skills`. To customize their effects, change the skill's corresponding .s file and drag it over `AssembleARM.bat`.
- Several optional toggles for other assembly hacks (such as the STR/MAG split, save expansion, etc) as well as the configuration of the effects of various skills can be found in `EngineHacks/Config.event`.
- To customize skill learnsets (what skills learned, at what level), see `EngineHacks/SkillSystem/Skill_lists.event`.
- To customize things like personal skills, class skills, and other miscellaneous things, see the CSVs in `Tables/NightmareModules`.
- For a more in-depth guide on using the Skill System, refer to [this topic](https://feuniverse.us/t/the-skill-system-and-you-maximizing-your-usage-of-fe8s-most-prolific-bundle-of-wizardry/8232).

## I found a bug! What can I do about it?

Check out our [issue tracker](https://github.com/FireEmblemUniverse/SkillSystem_FE8/issues) on Github.

## Contributing

We accept and review pull requests! If you don't know what that is, see [this guide](https://docs.github.com/en/get-started/quickstart/contributing-to-projects)!

## Credits

See `CREDITS.md` for a more detailed list.

Special thanks go to:
  - Circleseverywhere, for creating and releasing the original system.
  - Crazycolorz5, for debuffs, freeze and Dragon's Veins.
  - Primefusion, for the test map.
  - Kirb, for implementing the Str/Mag split into FE8 based off Tequila's original FE7 version.

