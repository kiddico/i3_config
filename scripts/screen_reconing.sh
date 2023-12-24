#!/bin/bash

external_display="$(xrandr --listmonitors | egrep -o '( DP-[1-4])')"
if [ "$external_display" == " DP-4" ]
then
	echo "1"
	xrandr --output eDP-1 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --mode 3840x2160 --pos 0x0 --rotate inverted --primary
	# 31.5" @ 3840x2160 = 139.87 PPI
	xrandr --dpi 120

elif [ "$external_display" == " DP-3" ]
then
	echo "2"
	xrandr --output eDP-1 --off --output DP-1 --off --output DP-2 --off --output DP-3 --mode 3840x2160 --pos 0x0 --rotate inverted --primary --output DP-4 --off
	# 31.5" @ 3840x2160 = 139.87 PPI
	xrandr --dpi 120

else
	echo "3"
	xrandr --output eDP-1 --primary --mode 2256x1504 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off
	# I think the DPI for the framework is 200?
	# 13.5" diagonal @ 2256x1504 = 200.84 PPI
	xrandr --dpi 160

fi
