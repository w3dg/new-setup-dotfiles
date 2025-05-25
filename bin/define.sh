#!/usr/bin/env bash

BASE_API_URL="https://api.dictionaryapi.dev/api/v2/entries/en_US/"

WORD="$1"

URL=${BASE_API_URL}${WORD}

query=$(curl -s --connect-timeout 5 --max-time 10 $URL)

[[ "$query" == *"No Definitions Found"* ]] && echo "No Definitions Found" && exit 0

# get all definitions line by line
echo $query | jq -r -M '.[] .meanings[].definitions[].definition'
