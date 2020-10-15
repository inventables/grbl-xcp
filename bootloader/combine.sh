#/usr/bin/env bash

set -eu

ELF=$1
GRBL=$2
BOOT=$3
OUT=$4

# Creates a combined bootloader, tweaking the version identifer. The last
# byte of the GRBL_VERSION_BUILD macro is tweaked to differentiate hex
# files with and w/out a bootloader based on the `$I` output.
#
# Lookup the address of the `build_info_ver` symbol
#
#   avr-objdump -t build/main.elf | grep build_info_ver
#   00000246 l     O .text	00000019 build_info_ver
#
# With the address (column 1) and size (column 5) we can find the target
# byte of our string which is formatted as such:
#
#   build_info_ver = "[VER:" GRBL_VERSION "." GRBL_VERSION_BUILD ":"
#
# The `base+len-3` skips the implied null terminator and final colon
#
ADDR=$(avr-objdump -t $ELF | grep build_info_ver |
    awk '{ base= ("0x" $1) + 0; len = ("0x" $5) + 0; print base+len-3; }')

START=$(printf "0x%X\n" $ADDR)
END=$(printf "0x%X\n" $(($ADDR+1)))

# 98 is `b` in ASCII (`a` for standalone Grbl)
srec_cat -Output $OUT -Intel \
    -generate $START $END -constant 98 \
    $GRBL -Intel -exclude $START $END \
    $BOOT -Intel

# Check the before/after version with adress and size from avr-objdump
#
# > srec_cat -Output - -Hex_Dump grbl.hex -Intel -crop 0x246 0x25e
# 00000240:                   5B 56 45 52 3A 31 2E 31 68 2D  #      [VER:1.1h-
# 00000250: 58 43 50 2E 32 30 32 30 31 30 31 34 61 3A        #XCP.20201014a:
# > srec_cat -Output - -Hex_Dump grbl.bootloader.hex -Intel -crop 0x246 0x25e
# 00000240:                   5B 56 45 52 3A 31 2E 31 68 2D  #      [VER:1.1h-
# 00000250: 58 43 50 2E 32 30 32 30 31 30 31 34 62 3A        #XCP.20201014b:
