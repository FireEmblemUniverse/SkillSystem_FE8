#!/bin/bash

base_dir=$(dirname "$(readlink -f "$0")")

# finding correct python version

if hash python 2> /dev/null && [[ $(python -c 'import sys; print(int(sys.version_info[0] > 2))') -eq 1 ]]; then
  python3="python"
elif hash python3; then
  python3="python3"
else
  echo "MakeHack.sh requires python 3 to be installed!" 1>&2
  exit 1
fi

ea_tools="$base_dir/Event Assembler/Tools"

source_rom="$base_dir/FE8_clean.gba"
target_rom="$base_dir/SkillsTest.gba"

source_event="$base_dir/ROM Buildfile.event"

cd "$base_dir"

echo "Copying clean ROM to target"
cp -f $source_rom $target_rom || exit 2

if [[ $1 != quick ]]; then
  # make hack full

  # TABLES

  cd "$base_dir/Tables"

  echo "Processing tables"

  echo | $python3 "$base_dir/Tools/C2EA/c2ea.py" \
    "$source_rom"

  # TEXT

  cd "$base_dir/Text"

  echo "Processing text"

  echo | $python3 "$base_dir/Tools/TextProcess/text-process-classic.py" \
    "text_buildfile.txt" --parser-exe "$ea_tools/ParseFile"
fi

echo "Assembling"

cd "$base_dir/Event Assembler"
mono Core.exe A FE8 "-output:$target_rom" "-input:$source_event"
