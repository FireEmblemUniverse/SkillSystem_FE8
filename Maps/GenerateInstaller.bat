@echo off

echo Assembling "GeneratedInstaller.event"
py GenerateIncbinInstaller.py

@cd "%~dp0/Defs"

setlocal enabledelayedexpansion
set FILE_MATCH=*.txt

for /R "%~dp0/Defs" %%F in (%FILE_MATCH%) do (
  set OUT_FILE=%%~nF.enu.event
  echo Assembling "Defs/%%~nxF"...
  py Enumerate.py "%%~nxF" "!OUT_FILE!"
)

pause