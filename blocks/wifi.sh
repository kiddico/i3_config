#!/bin/bash
# Copyright (C) 2014 Alexander Keller <github@nycroth.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#------------------------------------------------------------------------

INTERFACE="${BLOCK_INSTANCE:-wlan0}"

#------------------------------------------------------------------------

# As per #36 -- It is transparent: e.g. if the machine has no battery or wireless
# connection (think desktop), the corresponding block should not be displayed.
[[ ! -d /sys/class/net/${INTERFACE}/wireless ]] ||
    [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]] && exit

#------------------------------------------------------------------------

QUALITY=$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

#------------------------------------------------------------------------
# old way with signal strength.
#echo $QUALITY% # full text
#echo $QUALITY% # short text


echo  # full text
echo  # short text

# Mouse Events
case $BLOCK_BUTTON in
	1) i3-msg "exec gnome-terminal --class floater -e 'nmtui'";; # l click
	2) ;; # middle clock click
	3) ;; # right click, mute/unmute
	4) ;; # scroll up, increase
	5) ;; # scroll down, decrease
esac


# color
if [[ $QUALITY -ge 80 ]]; then
    echo "#9FD84F"
elif [[ $QUALITY -lt 80 ]]; then
    echo "#E6E854"
elif [[ $QUALITY -lt 60 ]]; then
    echo "#E8BE54"
elif [[ $QUALITY -lt 40 ]]; then
    echo "#E89254"
fi
