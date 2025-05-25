#!/usr/bin/env bash

# move brew's bin temporarily to the end so that system python gets picked up first
BREW_PREFIX=$(brew --prefix)

PATH=$(echo $PATH | sed -e "s|:${BREW_PREFIX}/bin||g" -e "s|:${BREW_PREFIX}/sbin||g")
PATH=$PATH:$BREW_PREFIX/bin:$BREW_PREFIX/sbin

PREFIX="installs/"
GOGH_REPO="$HOME/Gogh"
TERMINAL="terminator"
SELECTED=""
if [ $# -eq 1 ]; then
  if [ $1 = "random" -o $1 = "r" ]; then
    SELECTED=$(ls $GOGH_REPO/installs | shuf -n 1)
    echo "Selected random theme ${SELECTED}"
  else
    SELECTED="$1.sh"
  fi
  echo default | $GOGH_REPO/$PREFIX$SELECTED
else
  SELECTED=$(ls $GOGH_REPO/installs | fzf)
  if [[ $? == 0 ]]; then
    echo default | $GOGH_REPO/$PREFIX$SELECTED
  fi
fi
