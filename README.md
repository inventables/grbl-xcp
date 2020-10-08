# grbl-xcp

[Grbl](https://github.com/gnea/grbl) 1.1h fork for the X-Carve Pro machine.

## Prerequisites

### macOS

* Install the [Arduino IDE](https://www.arduino.cc/en/Main/Software).
  - Can also be installed via `brew cask install arduino`
* Install the `srecord` tools (`srec_cat` in particular)
  - `brew install srecord`
* Add the embedded AVR toolchain to your path
  - `export PATH=$PATH:/Applications/Arduino.app/Contents/Java/hardware/tools/avr/bin`

**TODO** Investigate [arduino-cli](https://github.com/arduino/arduino-cli) as simpler alternative

### Linux (Debian)

* Install the AVR toolchain packages and `srecord` tools
  - `apt install -y gcc-avr binutils-avr avr-libc srecord`

## Compiling

Run `make` from the root of the repo. This produces a `grbl.hex` firmware file that can be flashed. See the [original wiki](https://github.com/gnea/grbl/wiki/Compiling-Grbl) for more notes on building from source.

There's an additional `grbl.bootloader.hex` target which combines `grbl.hex` with a bootloader hex file for the ATmega2560. The bootloader is the one [embedded in the Arduino IDE](https://wspublishing.net/avr-c/restoring-arduino-mega-bootloader/). This combined hex file is what's flashed at the factory.

## Flashing

See the same doc as above on the [Grbl wiki](https://github.com/gnea/grbl/wiki/Compiling-Grbl#via-the-arduino-ide-all-platforms-recommended-for-all-users)
for both flashing (`grbl.hex`) and compiling instructions.

Flashing the `grbl.bootloader.hex` is more invovled as you need to setup an ISP to erase and write the full program memory. One relatively easy approach is to use another [Arduino as an ISP](https://www.arduino.cc/en/Tutorial/BuiltInExamples/ArduinoISP) but this does require a small bit of wiring and uploading an custom ISP program to said Arduino.

There's also `flash-grbl.sh` and `flash-combined.sh` that wrap the appropriate `avrdude` command for the respective hex file.

## Releases

There are automated builds setup on CircleCI for this repo. Currently they are run on PR requests and when changes are merged to master. Upon success, the firmware binaries (`grbl.hex` and `grbl.bootloader.hex`) are uploaded as a CircleCI artifact. Here's an [example of the artifacts tab](https://app.circleci.com/pipelines/github/inventables/grbl-xcp/14/workflows/925d508a-5c7a-4c85-98ef-4215e30a4f6f/jobs/15/artifacts) from a `master` branch build

When preparing a release, we want to use the Grbl+bootloader firmware (from the `master` branch build) for handing off to manufacturing. That means properly updating
the [build strings](https://github.com/inventables/grbl-xcp/blob/master/grbl/grbl.h#L26) and then creating a git tag of the same name. That tag should be the basis for a [GitHub release](https://github.com/inventables/grbl-xcp/releases) which includes the aforementioned hex file. See the [initial release](https://github.com/inventables/grbl-xcp/releases/tag/v1.1h-XCP.20200804) for an example.

## Differences

Differences from the stock version of Grbl

* Self-squaring
* Custom motor drivers

