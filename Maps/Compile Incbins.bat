@echo off

echo Assembling "GeneratedInstaller.event"
py GenerateIncbinInstaller.py

@cd "%~dp0/Defs"

setlocal enabledelayedexpansion
set FILE_MATCH=*.txt

for /R "%~dp0/Defs" %%F in (%FILE_MATCH%) do (
  set OUT_FILE=%%~dF%%~pF%%~nF%.enu.event
  echo Assembling "Defs/%%~nxF"...
  enumerate "%%~nxF" "!OUT_FILE!"
)

pause