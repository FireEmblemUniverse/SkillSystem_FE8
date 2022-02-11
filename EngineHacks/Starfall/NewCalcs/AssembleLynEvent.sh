echo off

startDir=$DEVKITARM/bin
as=$DEVKITARM/bin/arm-none-eabi-as
lyn=$DEVKITPRO/lyn

echo $as

filename=${1%.s}

$as -g -mcpu=arm7tdmi -mthumb-interwork $1 -o "$filename.elf"

$lyn "$filename.elf" > "$filename.lyn.event"

echo y | rm "$filename.elf"
