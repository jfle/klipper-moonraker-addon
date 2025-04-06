#!/bin/bash

# Start Klipper
cd /klipper
./klippy/klippy.py /data/printer.cfg &

# Start Moonraker
cd /moonraker
./moonraker/moonraker.py -c /data/moonraker.conf