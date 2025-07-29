#!/usr/bin/env python3

import os
import json
import requests
from subprocess import run


# Fontawesome weather related glyphs
# https://fontawesome.com/cheatsheet
conditions = {
        'cloud'      : '',
        'sun'        : '',
        'rain'       : '',
        'showers'    : '',
        'thunder'    : '',
        'lightning'  : '',
        'snow'       : '',
        'hail'       : '',
        }

moon = ''
sun  = ''

def c_to_f(c):
    return int((c * 1.8) + 32)

# Primary and Backup Data Sources Fallback "Logic"
def get_with_fallback(pri, bup):
    used_fallback = False

    # I <3 dict.setdefault()
    p_temp = pri['temperature'].setdefault('value')
    b_temp = bup['temperature'].setdefault('value')

    try:
        temp = c_to_f( p_temp if p_temp else b_temp)
    except:
        # Handle the exception? Nah.
        temp = '?'

    # Description and Present Weather used to generate icons
    # None of this is pretty, but it works.
    try:
        # Don't use fallback source for weather conditions.
        desc = pri['textDescription'].lower()
    except:
        desc = None
    try:
        weather = pri['presentWeather']
        if len(weather) > 0:
             weather = ' '.join( item for item in weather if 'weather' in item ).lower()
    except:
        weather = None

    return temp, desc, weather, used_fallback
   


def main():

    # PLEASE PAUSE FOR STATION IDENTIFICATION.
    # Mansfield / Cleveland
    primary = 'KMFD'
    backup  = 'KCLE'

    url  = f'https://api.weather.gov/stations/{primary}/observations/latest'
    primary_data = json.loads(requests.get(url).content)['properties']

    url   = f'https://api.weather.gov/stations/{backup}/observations/latest'
    backup_data  = json.loads(requests.get(url).content)['properties']

    temp, desc, weather, used_fallback = get_with_fallback(primary_data, backup_data)

    icons = ''
    for condition, icon in conditions.items():
        if condition in desc or weather:
            icons += icon

    icons = set(icons)
    full_text  = f'{temp}°{" ".join(icons)}'
    short_text = f'{temp}°'

    # Use a scawwy color if we had to use the fallback source
    color = '#EABD6F' if used_fallback else '#6CA8AC'
    print(f'{full_text}\n{short_text}\n{color}')


    # Handle mouse actions
    try:
        env_str = 'BLOCK_BUTTON'
        with open("/home/nick/block_out.log",'a') as logfile:
            logfile.write(str(os.environ))
        mouse_action = os.environ[env_str] if env_str in os.environ else None
        handle_action(mouse_action)
    except Exception as e:
        print(e)


def handle_action(mouse_action):
    if mouse_action:
        # Left Click
        if mouse_action == '1':
            run(['i3-msg "exec gnome-weather"'], shell=True )
            #run(['gnome-weather'], shell=True )



if __name__ == '__main__':
    main()
