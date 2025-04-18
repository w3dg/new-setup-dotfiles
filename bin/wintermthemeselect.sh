#!/usr/bin/env bash

settings_file="$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

selected=$(jq '.schemes[].name' < $settings_file | fzf)

if [ -z $selected ]; then
	echo "Aborting"
	exit
else 
	echo $selected is the selected theme
fi

tempFile=`mktemp`

# TODO: Doesnt work when it has spaces 
jq `echo .profiles.defaults.colorScheme=${selected}` < $settings_file > $tempFile

if [ $? -ne 0 ]; then
	echo "******************"
	echo "JQ failed. Exiting"
	echo "******************"
	exit
else 
	cat $tempFile > $settings_file
	rm $tempFile
fi
