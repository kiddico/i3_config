#!/usr/bin/env python3

from subprocess import run

results=run(["/usr/bin/acpi", "-b"], capture_output=True).stdout.decode("utf-8").rstrip()

splits=results.split(' ')

status=splits[2][:-1]
percent=splits[3][0:2]

if 'Discharging' in status:
    pass

if 'Charging' in status:
    pass

if 'Not Charging' in status:
    pass
