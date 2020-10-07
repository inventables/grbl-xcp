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

See the same doc as above on the [Grbl wiki](https://github.com/gnea/grbl/wiki/Compiling-Grbl#via-the-arduino-ide-all-platforms-recommended-for-all-users)
for both flashing an compiling instructions.

## Releases

There are automated builds setup on CircleCI for this repo. Currently they are run on PR requests and when changes are merged to master. Upon success, the firmware binary (named `grbl.hex`) is uploaded as a CircleCI artifact. Here's an [example of the artifacts tab](https://app.circleci.com/pipelines/github/inventables/grbl-xcp/14/workflows/925d508a-5c7a-4c85-98ef-4215e30a4f6f/jobs/15/artifacts) from a `master` branch build

When preparing a release, we want to use this firmware binary (from the `master` branch build) for handing off to manufacturing. That means properly updating
the [build strings](https://github.com/inventables/grbl-xcp/blob/master/grbl/grbl.h#L26) and then creating a git tag of the same name. That tag should be the basis for a [GitHub release](https://github.com/inventables/grbl-xcp/releases) which includes the aforementioned hex file. See the [initial release](https://github.com/inventables/grbl-xcp/releases/tag/v1.1h-XCP.20200804) for an example.

## Differences

**TODO**
