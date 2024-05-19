#!/usr/bin/env bash

if [ -z $1 ]; then
	read -p "Enter subreddit" subname
else
	subname=$1
fi

baseUrl=https://old.reddit.com
json=$(curl -s  $baseUrl/r/$subname/new.json)

selectedPost=`echo $json | jq -r '.data.children | .[] | "\(.data.title)\t\(.data.permalink)"' | fzf --delimiter='\t' --with-nth=1 |cut -f2`
explorer $baseUrl$selectedPost 
