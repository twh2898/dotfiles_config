#!/bin/bash

CONFIG="$(dirname $0)"
cd $CONFIG

git add ./nvim/spell/
git commit -m "Added words to NeoVim English dictionary"

git add ./Code/User/settings.json
git commit -m "Added words to VSCode dictionary"
