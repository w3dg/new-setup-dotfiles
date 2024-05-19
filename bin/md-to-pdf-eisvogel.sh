#!/usr/bin/env bash

if [ $# -ne 1 ]; then
	echo "Correct number of arguments not specified"
	echo "Usage: $0 <markdown-file>"
	exit
fi

outfile=$(basename $1 .md)

echo "Converting file using pandoc and eisvogel template"

pandoc $1 -o $outfile-generated.pdf --from markdown+yaml_metadata_block+raw_html --template eisvogel --highlight-style  pygments

if [ $? -eq 0 ]; then
	echo "Generated file $outfile-generated.pdf"
else
	echo "Failed to generate pdf"
fi
