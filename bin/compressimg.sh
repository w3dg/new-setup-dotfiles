#!/usr/bin/env bash

file="$1"

if [ -z file ]; then
    echo "no file specified"
    exit 1
fi

filename="${file%%.*}"
ext="${file##*.}"
output="${filename}_compressed.${ext}"

magick "$file" -quality 50 "$output"
