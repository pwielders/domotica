#!/bin/sh
BOARD_DIR="$(dirname $0)"

cp $BOARD_DIR/uboot.txt $BINARIES_DIR/uboot.txt

$HOST_DIR/bin/mkimage -C none -A arm -T script -d $BOARD_DIR/boot.cmd $BINARIES_DIR/boot.scr
