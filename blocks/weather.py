#!/usr/bin/env python3

import json
import pprint
import requests
pp = pprint.PrettyPrinter(indent=4).pprint

from sys import exit


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

def c_to_f(c):
    return int((c * 1.8) + 32)

def get_with_fallback(pri, bup):
    try:
        temp =pri['temperature']['value'] if 'value' in pri['temperature'] else bup['temperature']['value']
        temp = c_to_f(temp)
    except:
        temp = '?'

    # No fallback for the actual weather.
    # I don't care if it's raining in cleveland, but I can use it to estimate our temperature.
    try:
        desc = pri['textDescription'].lower()
    except:
        desc = None

    try:
        weather = pri['presentWeather']
        if len(weather) > 0:
             weather = ' '.join( item for item in weather if 'weather' in item ).lower()
    except:
        weather = None
    return temp, desc, weather
   


def main():

    # PLEASE PAUSE FOR STATION IDENTIFICATION.
    primary = 'KMFD'
    backup  = 'KCLE'

    url  = f'https://api.weather.gov/stations/{primary}/observations/latest'
    primary_data = json.loads(requests.get(url).content)['properties']

    url   = f'https://api.weather.gov/stations/{backup}/observations/latest'
    backup_data  = json.loads(requests.get(url).content)['properties']

    temp, desc, weather = get_with_fallback(primary_data, backup_data)

    icons = ''
    for condition, icon in conditions.items():
        if condition in desc or weather:
            icons += icon
    icons = set(icons)
    full_text  = f'{temp}°{" ".join(icons)}'
    #full_text  = f'{temp}°{" ".join(icons)}\u2028'
    short_text = f'{temp}°'

    print(full_text)
    print(short_text)











if __name__ == '__main__':
    main()
