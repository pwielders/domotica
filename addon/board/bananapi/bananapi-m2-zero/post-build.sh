#!/bin/sh
BOARD_DIR="$(dirname $0)"

cp $BOARD_DIR/uboot.txt $BINARIES_DIR/uboot.txt
cp -rp $BOARD_DIR/firmware $TARGET_DIR/lib/firmware

$HOST_DIR/bin/mkimage -C none -A arm -T script -d $BOARD_DIR/boot.cmd $BINARIES_DIR/boot.scr
