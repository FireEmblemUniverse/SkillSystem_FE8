@echo off

@rem USAGE: "MAKE HACK_full.cmd" [quick]
@rem If first argument is "quick", then this will not update text, tables, or generate a patch
@rem "MACK HACK_quick.cmd" simply calls this but with the quick argument, for convenience

@rem defining buildfile config

set "source_rom=%~dp0FE8_clean.gba"

set "main_event=%~dp0ROM Buildfile.event"

set "target_rom=%~dp0SkillsTest.gba"
set "target_ups=%~dp0SkillsTest.ups"

@rem defining tools

set "c2ea=%~dp0Tools\C2EA\c2ea"
set "texp=%~dp0Tools\TextProcess\textprocess_v2"
set "ups=%~dp0Tools\ups\ups"

@rem do the actual building

copy "%source_rom%" "%target_rom%"

if /I NOT "%1"==quick (

  @rem only do the following if this isn't a make hack quick

  echo "Processing tables"

  cd "%~dp0Tables"
  echo: | ("%c2ea%" "%source_rom%")

  echo "Processing text"

  cd "%~dp0Text"
  echo: | ("%texp%" text_buildfile.txt)

)

echo "Assembling"

cd "%~dp0Event Assembler"
Core A FE8 "-output:%target_rom%" "-input:%~dp0ROM Buildfile.event"

if /I NOT "%1"==quick (

  @rem only do the following if this isn't a make hack quick

  echo "Generating patch"

  cd "%~dp0"
  %ups% diff -b "%source_rom%" -m "%target_rom%" -o "%target_ups%"

)

echo "Done!"
pause
