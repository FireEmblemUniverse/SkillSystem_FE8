#!/bin/bash
cd $(dirname "$1")
input=$(basename -- "$1")
name=$(echo "$input" | cut -f 1 -d '.')
echo "Assemble into an elf"
/opt/devkitpro/devkitARM/bin/arm-none-eabi-as -g -mcpu=arm7tdmi -mthumb-interwork $input -o "$name.elf"
echo "Print symbol table"
/opt/devkitpro/devkitARM/bin/arm-none-eabi-readelf -s "$name.elf" > "$name.symbols.log"
echo "Extract raw assembly binary (text section) from elf"
/opt/devkitpro/devkitARM/bin/arm-none-eabi-objcopy -S "$name.elf" -O binary "$name.dmp"
rm "$name.elf"
rm "$name.symbols.log"
echo "Done!"