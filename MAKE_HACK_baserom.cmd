@echo off

@rem USAGE: "MAKE HACK_full.cmd" [quick]
@rem If first argument is "quick", then this will not update text, tables, maps, or generate a patch
@rem "MACK HACK_quick.cmd" simply calls this but with the quick argument, for convenience

@rem defining buildfile config

set "source_rom=%~dp0FE8_clean.gba"
set "main_event=%~dp0baserom.event"
set "target_rom=%~dp0baserom.gba"
set "target_sym=%~dp0baserom.sym"

@rem defining tools

set "c2ea=%~dp0Tools\C2EA\c2ea.exe"
set "textprocess=%~dp0Tools\TextProcess\text-process-classic.exe"
set "ups=%~dp0Tools\ups\ups.exe"
set "parsefile=%~dp0EventAssembler\Tools\ParseFile.exe"
set "tmx2ea=%~dp0Tools\tmx2ea\tmx2ea.exe"
set "symcombo=%~dp0Tools\sym\SymCombo.exe"

@rem set %~dp0 into a variable because batch is stupid and messes with it when using conditionals?

set "base_dir=%~dp0"

@rem do the actual building

echo Copying ROM

copy "%source_rom%" "%target_rom%"

echo:
echo Assembling

cd "%base_dir%EventAssembler"
ColorzCore A FE8 "-output:%target_rom%" "-input:%main_event%" "--nocash-sym:%~dp0FE8Hack.sym" "--build-times" "--warnings:no-nonportable-pathnames"
@rem type "%~dp0FE8_clean.sym" >> "%~dp0baserom.sym"

echo:
echo Generating sym file

echo: | ( "%symcombo%" "%target_sym%" "%target_sym%" "%base_dir%\Tools\sym\VanillaOffsets.sym" )


echo:
echo Done!

pause
