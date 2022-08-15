#!/bin/bash

# Set resolution
xrandr -s 1920x1080
# Adding transparency and no fading
picom --no-fading-openclose &
# Restoring wallpaper
nitrogen --restore &
# Hiding mouse pointer when inactive
unclutter --jitter 10 --ignore-scrolling --start-hidden --fork
# Doom Emacs server
/usr/bin/emacs --daemon
