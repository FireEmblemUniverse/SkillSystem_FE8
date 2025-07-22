@echo off

@rem USAGE: "MAKE HACK_full.cmd" [quick]
@rem If first argument is "quick", then this will not update text, tables, maps, or generate a patch
@rem "MACK HACK_quick.cmd" simply calls this but with the quick argument, for convenience

@rem defining buildfile config

set "vanilla_rom=%~dp0FE8_Clean.gba"
set "source_rom=%~dp0baserom.gba"
set "main_event=%~dp0ROMBuildfile.event"
set "target_rom=%~dp0FE8Hack.gba"
set "target_ups=%~dp0Pokemblem.ups"
set "target_sym=%~dp0FE8Hack.sym"

@rem defining tools

set "c2ea=%~dp0Tools\C2EA\c2ea.exe"
set "textprocess=%~dp0Tools\TextProcess\text-process-classic.exe"
set "ups=%~dp0Tools\ups\ups.exe"
set "parsefile=%~dp0EventAssembler\Tools\ParseFileUTF8.exe"
set "tmx2ea=%~dp0Tools\tmx2ea\tmx2ea.exe"
set "symcombo=%~dp0Tools\sym\SymCombo.exe"

@rem set %~dp0 into a variable because batch is stupid and messes with it when using conditionals?

set "base_dir=%~dp0"

@rem do the actual building

echo Copying ROM

copy "%source_rom%" "%target_rom%"

if /I not [%1]==[quick] (

  @rem only do the following if this isn't a make hack quick

  echo:
  echo Processing tables

  cd "%base_dir%Tables"
  echo: | ("%c2ea%" "%source_rom%" -installer "%base_dir%Tables/TableInstaller.event")

  echo:
  echo Processing text

  cd "%base_dir%Text"
  echo: | ("%textprocess%" text_buildfile.txt --parser-exe "%parsefile%" --installer "InstallTextData.event" --definitions "TextDefinitions.event")

)

echo:
echo Assembling

cd "%base_dir%EventAssembler"
ColorzCore A FE8 "-output:%target_rom%" "-input:%main_event%" "--nocash-sym" "--build-times" "--warnings:no-nonportable-pathnames"
rem type "%~dp0baserom.sym" >> "%~dp0FE8Hack.sym"




echo:
echo Generating patch

cd "%base_dir%"
"%ups%" diff -b "%vanilla_rom%" -m "%target_rom%" -o "%target_ups%"

echo:
echo Generating sym file

echo: | ( "%symcombo%" "%target_sym%" "%target_sym%" "%base_dir%\Tools\sym\VanillaOffsets.sym" )

SET destDir="C:\Users\David\Desktop\FEBuilderGBA\config\etc\FE8Hack"
copy /y "%~dp0FE8Hack.sym" %destDir%\comment_.txt

echo:
echo Done!

pause
