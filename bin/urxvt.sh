#!/usr/bin/env bash
export LANG=en_US.UTF-8
xrdb -merge ~/.Xresources
pkill xcape
xcape
exec urxvt
