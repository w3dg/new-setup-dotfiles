#!/usr/bin/env bash

deps=(http fzf jq)

for dep in ${deps[*]}; do
    if ! type -fP $dep > /dev/null 2>&1; then
        printf "ERROR: Dependency ${dep} not met." >&2
        exit 1
    fi
done

if [ -z $1 ]; then
	read -p "Enter subreddit: " subname
else
	subname=$1
fi

baseUrl=https://www.reddit.com

# use http for making requests until figure out why reddit blocks me programmatically

selectedPost=$(http get ${baseUrl}/r/${subname}/new.json | jq -r '.data.children | .[] | "\(.data.title)\t\(.data.permalink)"' | fzf --delimiter='\t' --with-nth=1 | cut -f2)

if [ -z $selectedPost ]; then
    exit
fi

xdg-open $baseUrl$selectedPost > /dev/null
