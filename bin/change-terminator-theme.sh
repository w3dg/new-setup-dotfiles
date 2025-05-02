#!/usr/bin/env bash
PATH="/home/dg/.nvm/versions/node/v22.5.1/bin:/home/dg/bin:/usr/local/bin:/home/dg/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/dg/.fzf/bin:/usr/lib/jvm/jdk-21-oracle-x64//bin"
PREFIX="installs/"
GOGH_REPO="$HOME/Gogh"
export TERMINAL="terminator"
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
