#!/bin/bash
cd $(dirname "$1")
name=$(echo "$1" | cut -f 1 -d '.')
echo "Assemble into an elf"
/opt/devkitpro/devkitARM/bin/arm-none-eabi-as -g -mcpu=arm7tdmi -mthumb-interwork $1 -o "$name.elf"
echo "Assemble into a .lyn.event"
/opt/devkitpro/lyn "$name.elf" > "$name.lyn.event"
rm "$name.elf"
