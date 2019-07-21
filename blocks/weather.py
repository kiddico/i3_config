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
    resp = requests.get(url)
    data = json.loads(requests.get(url).content)['properties']




    # icon code is the pretty picture used to make the icon/phrase combo
    #   f'https://icons.wxug.com/i/c/v4/{data["icon_code"]}.svg'
    c_temp = data['temperature']['value']
    f_temp = int((c_temp * 1.8) + 32)

    description = data['textDescription'].lower()
    icons = ''
    for condition, icon in conditions.items():
        if condition in description:
            icons += icon

    full_text  = f'{f_temp}°{" ".join(icons)}\u200B'
    #full_text  = f'{f_temp}°{" ".join(icons)}'
    short_text = f'{f_temp}°'

    print(full_text)
    print(short_text)











if __name__ == '__main__':
    main()
# Notes and other bits
# Example of asking for a specific collection location.
# Will only return what that station collects.
#url = f'https://api.weather.com/v2/pws/observations/current?apiKey={api_key}&units=e&stationId=KOHMANSF49&format=json'

# also 5 day pred
#url='https://api.weather.com/v3/wx/almanac/daily/5day?apiKey=6532d6454b8aa370768e63d6ba5a832e&icaoCode=KCMH&units=e&startMonth=07&startDay=21&format=json'
