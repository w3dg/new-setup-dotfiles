#!/usr/bin/env bash

selected=$(ghostty +list-themes | sed s/\(resources\)// | fzf)
if [[ $? -ne 0 ]]; then exit 0; fi
echo "changing theme to $selected in config"

GHOSTTY_CONFIG_FILE_PATH="$HOME/.config/ghostty/config"

sed -i -E "s|theme = .*|theme = $selected|" $GHOSTTY_CONFIG_FILE_PATH
