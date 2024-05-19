#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

TOKEN="0000000:TOKEN_HERE"
CHAT_ID="1234567890"

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  MESSAGE=$(cat < "${*:-/dev/stdin}")
  curl -s -d "chat_id=$CHAT_ID&disable_web_page_preview=1&text=$MESSAGE" "https://api.telegram.org/bot$TOKEN/sendMessage"
fi
