#!/bin/bash
# Give credit where credit is due
# Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>
# Copyright (C) 2014 Alexander Keller <github@nycroth.com>

# Use the provided interface, otherwise the device used for the default route.
if [[ -n $BLOCK_INSTANCE ]]; then
  IF=$BLOCK_INSTANCE
else
  IF=$(ip route | awk '/^default/ { print $5 ; exit }')
fi

# As per #36 -- It is transparent: e.g. if the machine has no battery or wireless
# connection (think desktop), the corresponding block should not be displayed.
[[ ! -d /sys/class/net/${IF} ]] && exit

if [[ "$(cat /sys/class/net/$IF/operstate)" = 'down' ]]; then
  echo !⧎ # full text
  echo !⧎ # short text
  echo \#D34388 # color
  exit
fi

echo "⧎" # full text
echo "⧎" # short text
