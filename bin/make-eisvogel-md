#!/usr/bin/env bash

filename="$1"
if [ -z "$filename" ]; then
    filename="doc.md"
fi
eisvogel_header='---
geometry: "left=2cm,right=2cm,top=2cm,bottom=3cm"
disable-header-and-footer: true
---

# Heading
'

echo "$eisvogel_header" >> "$filename"
