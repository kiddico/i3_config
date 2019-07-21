#!/usr/bin/env python3

import json
import pprint
import requests
pp = pprint.PrettyPrinter(indent=4).pprint



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


def main():
    station = 'KMFD'

    url = f'https://api.weather.gov/stations/{station}/observations/latest'
    data = json.loads(requests.get(url).content)['properties']



    # For some reason temperature can be missing.
    try:
        c_temp = data['temperature']['value']
        f_temp = int((c_temp * 1.8) + 32)
    except:
        f_temp = '?'


    description = data['textDescription'].lower()
    weather = data['presentWeather'][0]['weather'].lower()

    icons = ''
    for condition, icon in conditions.items():
        if condition in description:
            icons += icon

    full_text  = f'{f_temp}°{" ".join(icons)}\u200B'
    short_text = f'{f_temp}°'

    print(full_text)
    print(short_text)











if __name__ == '__main__':
    main()
