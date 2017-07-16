@echo off

SET startDir=C:\devkitPro\devkitARM\bin\

@rem Assemble into an elf
SET as="%startDir%arm-none-eabi-as"
%as% -g -mcpu=arm7tdmi -mthumb-interwork %1 -o "%~n1.elf"

@rem Extract raw assembly binary (text section) from elf
SET objcopy="%startDir%arm-none-eabi-objcopy"
%objcopy% -S "%~n1.elf" -O binary "%~n1.bin"

echo y | del "%~n1.elf"
pause
