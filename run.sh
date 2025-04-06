#!/bin/sh
set -e

# Create required directories
mkdir -p /config/klipper
mkdir -p /config/moonraker
mkdir -p /tmp/klippy_uds
mkdir -p /tmp/klipper_logs

# Fix permissions for devices
[ -e /dev/ttyAMA0 ] && chmod 777 /dev/ttyAMA0 || true
[ -e /dev/ttyUSB0 ] && chmod 777 /dev/ttyUSB0 || true
[ -e /dev/ttyACM0 ] && chmod 777 /dev/ttyACM0 || true

# Generate default configs if missing
if [ ! -f /config/moonraker/moonraker.conf ]; then
  cp /defaults/moonraker.conf /config/moonraker/moonraker.conf
fi

if [ ! -f /config/klipper/printer.cfg ]; then
  cp /defaults/printer.cfg /config/klipper/printer.cfg
fi

# Start services with logging
exec supervisord -n -c /etc/supervisord.conf
