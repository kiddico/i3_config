#!/bin/bash
# I mostly just use 'default'
# Ya kinda figure 'pulse' would work on a pulseaudio system... nope.
MIXER="default"
[ -n "$(lsmod | grep pulse)" ] && MIXER="pulse"
[ -n "$(lsmod | grep jack)" ] && MIXER="jackplug"
MIXER="${2:-$MIXER}"

# The instance option sets the control to report and configure
# This defaults to the first control of your selected mixer
# For a list of the available, use `amixer -D $Your_Mixer scontrols`
SCONTROL="${BLOCK_INSTANCE:-$(amixer -D $MIXER scontrols |
                  sed -n "s/Simple mixer control '\([A-Za-z ]*\)',0/\1/p" |
                  head -n1
                )}"

# The first parameter sets the step to change the volume by (and units to display)
# This may be in in % or dB (eg. 5% or 3dB)
STEP="${1:-5%}"

#------------------------------------------------------------------------

capability() { # Return "Capture" if the device is a capture device
  amixer -D $MIXER get $SCONTROL |
    sed -n "s/  Capabilities:.*cvolume.*/Capture/p"
}

volume() {
  amixer -D $MIXER get $SCONTROL $(capability)
}
# So my new goal in life is to keep only the bits that leave us with a number for our volume.
format() {
  # No idea what a perl filter is, or even how to read perl.
  # With that in mind....

  perl_filter='if (/.*\[(\d+%)\] (\[(-?\d+.\d+dB)\] )?\[(on|off)\]/)'
  perl_filter+='{CORE::say $4 eq "off" ? " 0" : "'
  # If dB was selected, print that instead
  perl_filter+=$([[ $STEP = *dB ]] && echo '$3' || echo '$1')
  perl_filter+='"; exit}'
  perl -ne "$perl_filter"
  # Stop inserting a freaking percentage sign! Geezuz
}

#------------------------------------------------------------------------

case $BLOCK_BUTTON in
  1) pavucontrol --class floater;; # ? click
  2) ;; # ? click
  3) amixer -q -D $MIXER sset $SCONTROL $(capability) toggle ;;  # right click, mute/unmute
  4) amixer -q -D $MIXER sset $SCONTROL $(capability) ${STEP}+ unmute ;; # scroll up, increase
  5) amixer -q -D $MIXER sset $SCONTROL $(capability) ${STEP}- unmute ;; # scroll down, decrease
esac

#volume
volume | format
