#!/bin/bash
set -e

BOARD_DIR="$(dirname $0)"
BINARIES_DIR="$2"
IMAGES_DIR="$BINARIES_DIR"

echo "[post-image] Copying Lichee Pi 4A boot binaries..."
mkdir -p "$IMAGES_DIR/bootbins"
cp -v $BINARIES_DIR/bootbins/* "$IMAGES_DIR/" 2>/dev/null || true

echo "[post-image] Generating bootable image..."
genimage --rootpath "$TARGET_DIR" \
         --tmppath "$BUILD_DIR/genimage.tmp" \
         --inputpath "$BINARIES_DIR" \
         --outputpath "$BINARIES_DIR" \
         --config "$BOARD_DIR/genimage.cfg"

echo "[post-image] Done. Images in $BINARIES_DIR"

