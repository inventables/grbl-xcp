#!/bin/sh

HEX_FILE=grbl.hex
PORT=$(ls /dev/cu.usb*) # This is just a heuristic

ARDUINO_TOOLS=/Applications/Arduino.app/Contents/Java/hardware/tools/avr
# Alternatively if installed per-user
#ARDUINO_TOOLS=${HOME}/Applications/Arduino.app/Contents/Java/hardware/tools/avr

${ARDUINO_TOOLS}/bin/avrdude -v \
 -C ${ARDUINO_TOOLS}/etc/avrdude.conf \
 -p atmega2560 \
 -c wiring -D \
 -P ${PORT} \
 -U flash:w:${HEX_FILE}:i

