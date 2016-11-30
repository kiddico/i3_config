#!/bin/bash

# Inside of .bashrc there needs to be a line like:
# export PCTYPE="laptop"
# or 
# export PCTYPE="desktop"
# Depending on which machine we're on.

# Alternatively it may be best to be a little tricky with it.
# like maybe look through the system for a battery.
# if we find one, then we can assume it's a laptop,
# and a laptop modifier can be used.

if [ -d /sys/class/power_supply/BAT0 ];
then
	PCTYPE="laptop"
else
	PCTYPE="desktop"
fi

cd ~/.config/i3
make $PCTYPE theme=$1
