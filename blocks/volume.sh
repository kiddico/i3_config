#!/bin/bash

percent="$(amixer -c 1 -M -D default get Master | grep -o -E [[:digit:]]+% | head -n 1)"
percent=${percent::-1}
if [ "$(amixer -c 1 -M -D default get Master | grep off)" != "" ]; then
	echo " 0"
	echo""
	echo "#D7582B"
else
	echo " $percent"
	echo""
	echo "#c3b2a8"
fi

# First Linene : FULL_TEXT
# Second Line : SHORT_TEXT
# Third Line : COLOR


case $BLOCK_BUTTON in
  1) pavucontrol --class floater;; # l click
  2) ;; # middle clock click
  3) amixer -q sset Master,0 toggle ;;  # right click, mute/unmute
  4) amixer -q sset Master,0 5%+ unmute;; # scroll up, increase
  5) amixer -q sset Master,0 5%- unmute;; # scroll down, decrease
esac

