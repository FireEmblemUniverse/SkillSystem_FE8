@echo off

@set "AnimationAssembler=%~dp0/../../Tools/AA/AA"

@cd %~dp0/bin

@dir *.bin /b > bin.txt

@for /f "tokens=*" %%m in (bin.txt) do ("%AnimationAssembler%" "%%m")

@del bin.txt

@cd %~dp0

echo n | @copy /-y "%~dp0bin\*.event" "%~dp0Event" > nul

@del "%~dp0bin\*.event"

echo Done!

pause