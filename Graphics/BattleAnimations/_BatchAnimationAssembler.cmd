@echo off

@set "AnimationAssembler=%~dp0/../../Tools/AA/AA"

@cd %~dp0/Bin

@dir *.bin /b > bin.txt

@for /f "tokens=*" %%m in (bin.txt) do ("%AnimationAssembler%" "%%m")

@del bin.txt

@cd %~dp0

echo n | @copy /-y "%~dp0Bin\*.event" "%~dp0Event" > nul

@del "%~dp0Bin\*.event"

echo Done!

pause