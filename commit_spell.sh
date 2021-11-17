#!/bin/bash

CONFIG="$(dirname $0)"
cd $CONFIG

git add ./nvim/spell/
git commit -m "Added words to NeoVim English dictionary"
