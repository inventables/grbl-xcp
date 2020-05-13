# grbl-xcp

[Grbl](https://github.com/gnea/grbl) 1.1h fork for the X-Carve Pro machine.

## Prerequisites

### macOS

* Install the [Arduino IDE](https://www.arduino.cc/en/Main/Software).
  - Can also be installed via `brew cask install arduino`
* Add the embedded AVR toolchain to your path
  - `export PATH=$PATH:/Applications/Arduino.app/Contents/Java/hardware/tools/avr/bin`

**TODO** Investigate [arduino-cli](https://github.com/arduino/arduino-cli) as simpler alternative

### Linux (Debian)

* Install the AVR toolchain packages
  - `apt install -y gcc-avr binutils-avr avr-libc`

## Compiling

Run `make` from the root of the repo. This produces a `grbl.hex` firmware file that can be flashed. See the [original wiki](https://github.com/gnea/grbl/wiki/Compiling-Grbl) for more notes on building from source.

## Flashing

**TODO** Need a board to properly test this.

## Differences

**TODO**
