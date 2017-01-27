#!/bin/bash

# Getting a terminal window to float and execute something
#   after going through the dock is not going so well.
case $BLOCK_BUTTON in
1) ;; # left   click
2) ;; # middle click
3) ;; # right  click
4) ;; # scroll up
5) ;; # scroll down
esac

echo " $(date '+%R') "
