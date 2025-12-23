#! /usr/bin/env bash

set -euo pipefail

FOLDER_NAME=$@

echo "Cloning starter..."
echo ""

git clone https://github.com/w3dg/express-api-starter.git $FOLDER_NAME &> /dev/null
rm -rf "$FOLDER_NAME/.git/"
cd $FOLDER_NAME

echo "Installing dependencies..."
echo ""

if [ -f "yarn.lock" ]; then
  yarn &> /dev/null
else
  npm install &> /dev/null
fi

echo "Done! ✨"
echo ""
cd ..
echo "Run the following to get started"
echo "cd $FOLDER_NAME"
echo "npm run dev OR yarn run dev (depending on the package manager)"
