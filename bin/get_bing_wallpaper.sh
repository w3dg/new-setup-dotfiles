#!/usr/bin/env bash

BING_WALLPAPER_URL="https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1"
# let jq pluck out the properties, remove wrapping quotes after
TODAYS_URL=$(curl -s "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1" | jq .images[0].url | tr -d '"')
wget https://bing.com$TODAYS_URL -O wallpaper_$(date --iso-8601).jpg
