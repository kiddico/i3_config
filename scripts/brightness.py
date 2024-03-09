#!/usr/bin/env python3
from sys import argv
from os import system

# 0 - 96000


def main():

    if '+' in argv[1] or '-' in argv[1]:
        with open('/sys/class/backlight/intel_backlight/brightness') as current_brightness:
            current=int(current_brightness.readline())
            current_percent=int((current/96000)*100)

        if len(argv) == 2:
            change_by = int(argv[1])
        elif len(argv) == 3:
            change_by = int(argv[1]+argv[2])

        to_set = int((current_percent+change_by)/100*96000)

    else:
            to_set = int( (float(argv[1])/100) * 96000 )
    try:
        command_string = f"echo {to_set} | sudo tee /sys/class/backlight/intel_backlight/brightness"
        system(command_string)
    except: pass


if __name__ == "__main__":
    main()
