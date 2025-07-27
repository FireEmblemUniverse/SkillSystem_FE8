@echo off

SET startDir="C:\devkitPro\devkitARM\bin\"
SET as="%startDir%arm-none-eabi-as"
SET LYN="C:\devkitPro\lyn.exe"


@rem Assemble into an elf
%as% -g -mcpu=arm7tdmi -mthumb-interwork "AsmHooks.asm" -o "%~dp0Data\%~n1.elf"
if exist "%~dp0Data\FE6_defs.s" (
	
	@rem Assemble definitions into a .elf if exists	
	%as% -g -mcpu=arm7tdmi -mthumb-interwork "%~dp0Data\FE6_defs.s" -o "%~dp0Data\FE6_defs.elf"

	@rem Assebmle into a .lyn.event with definitions
	%LYN% "%~dp0Data\%~n1.elf" "%~dp0Data\FE6_defs.elf" > "%~dp0Data\FE6_AsmHooks.lyn.event"

	@cd %~dp0/Data
	echo y | del "FE6_defs.elf"

) 

@cd %~dp0

if exist "%~dp0Data\FE7_defs.s" (
	
	@rem Assemble definitions into a .elf if exists	
	%as% -g -mcpu=arm7tdmi -mthumb-interwork "%~dp0Data\FE7_defs.s" -o "%~dp0Data\FE7_defs.elf"

	@rem Assebmle into a .lyn.event with definitions
	%LYN% "%~dp0Data\%~n1.elf" "%~dp0Data\FE7_defs.elf" > "%~dp0Data\FE7_AsmHooks.lyn.event"

	@cd %~dp0/Data
	echo y | del "FE7_defs.elf"

) 

@cd %~dp0
if exist "%~dp0Data\FE8_defs.s" (
	
	@rem Assemble definitions into a .elf if exists	
	%as% -g -mcpu=arm7tdmi -mthumb-interwork "%~dp0Data\FE8_defs.s" -o "%~dp0Data\FE8_defs.elf"

	@rem Assebmle into a .lyn.event with definitions
	%LYN% "%~dp0Data\%~n1.elf" "%~dp0Data\FE8_defs.elf" > "%~dp0Data\FE8_AsmHooks.lyn.event"

	@cd %~dp0/Data
	echo y | del "FE8_defs.elf"

) 


echo y | del "%~n1.elf"

pause