#/usr/bin/env sh

# Block's script's name minus extension
block_name=$1

# Mouse mutton/action to emulate
# 1 : Left Click
# 2 : Right Click 
# 3 : Middle Click
# 4 : Scroll Up
# 5 : Scroll Down
export BLOCK_BUTTON="$2"

./$block_name.*
