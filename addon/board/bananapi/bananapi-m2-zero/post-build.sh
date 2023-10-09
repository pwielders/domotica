#!/bin/sh
BOARD_DIR="$(dirname $0)"

cp $BOARD_DIR/uboot.txt $BINARIES_DIR/uboot.txt
cp -rp $BOARD_DIR/firmware $TARGET_DIR/lib/firmware
mkdir $BINARIES_DIR/overlays

for entry in $BOARD_DIR/overlays/*.dts ; do 
	filename=$(basename -- "$entry")
	base="${filename%.*}"

	$HOST_DIR/bin/dtc -@ -O dtb -o $BINARIES_DIR/overlays/$base.dtb $entry
done

if [ -f $BINARIES_DIR/sun8i-h2-plus-bananapi-eth0.dtb ]; then
	mv $BINARIES_DIR/sun8i-h2-plus-bananapi-eth0.dtb $BINARIES_DIR/overlays/ethernet.dtb
else
	echo "Did not move the Ethernet Overlay file, assume it is already moved or it is missing :-)"
fi

$HOST_DIR/bin/mkimage -C none -A arm -T script -d $BOARD_DIR/boot.cmd $BINARIES_DIR/boot.scr
