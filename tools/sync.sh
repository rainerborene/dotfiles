#!/bin/bash
cd ~/.dotfiles
git reset --hard
git submodule foreach git clean -f
git pull origin master
