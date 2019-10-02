#!/bin/bash

if [[ -z $DEVKITARM ]]; then
  echo "This requires DEVKITARM to be set!" 1>&2
  exit 1
fi

export as="$DEVKITARM/bin/arm-none-eabi-as"
export objcopy="$DEVKITARM/bin/arm-none-eabi-objcopy"

function build_file {
  source="$1"
  target="$2"

  if [[ "$target" -ot "$source" || -n $3 ]]; then
    tmp=$(mktemp --suffix=".elf")

    $as -g -mcpu=arm7tdmi -mthumb-interwork "$source" -o "$tmp" -I "$(dirname "$source")"
    $objcopy -S "$tmp" -O binary "$target"
    rm -f "$tmp"
  fi
}

function build_source_file {
  source="$1"
  target="${source%.*}.dmp"

  build_file "$source" "$target"
}

export -f build_file
export -f build_source_file

find -type f -name "*.s" \
  -exec bash -c 'build_source_file "$0"' '{}' \;

