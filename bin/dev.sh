#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  # JS
  if [ -f "package.json" ]; then
    if [ -f "yarn.lock" ]; then
      yarn dev
    else
      npm run dev
    fi
    exit 0
  fi

  echo "Can't figure out how to start dev mode on $(pwd)"
fi
