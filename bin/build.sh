#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  # JS
  if [ -f "package.json" ]; then
    if [ -f "yarn.lock" ]; then
      yarn build
    else
      npm run build
    fi
    exit 0
  fi

  echo "Can't figure out how to build $(pwd)"
fi
