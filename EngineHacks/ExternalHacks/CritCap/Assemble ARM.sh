echo off

startDir=$DEVKITARM/bin

filename=${1%.s}

#rem Assemble into an elf
as=$startDir"/arm-none-eabi-as"
$as -g -mcpu=arm7tdmi -mthumb-interwork $1 -o "$filename.elf"

#rem Print symbol table
readelf=$startDir"/arm-none-eabi-readelf"
$readelf -s "$filename.elf" > "$filename.symbols.log"

#rem Extract raw assembly binary (text section) from elf
objcopy=$startDir"/arm-none-eabi-objcopy"
$objcopy -S "$filename.elf" -O binary "$filename.dmp"

echo y | rm "$filename.elf"

echo y | rm "$filename.symbols.log"
