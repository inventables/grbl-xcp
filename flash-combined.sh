#!/bin/sh

HEX_FILE=grbl.bootloader.hex
PORT=$(ls /dev/cu.usb*) # This is just a heuristic

ARDUINO_TOOLS=/Applications/Arduino.app/Contents/Java/hardware/tools/avr
# Alternatively if installed per-user
#ARDUINO_TOOLS=${HOME}/Applications/Arduino.app/Contents/Java/hardware/tools/avr

${ARDUINO_TOOLS}/bin/avrdude -v \
 -C ${ARDUINO_TOOLS}/etc/avrdude.conf \
 -p atmega2560 \
 -c stk500v1 \
 -P ${PORT} \
 -b 19200 \
 -U flash:w:${HEX_FILE}:i

