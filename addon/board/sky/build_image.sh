rm -rf $BUILD_DIR/ImageBuilder 
result=$(git clone git@github.com:Metrological/amlogic-image-builder.git $BUILD_DIR/ImageBuilder)

if [[ "$result" != "" ]]; then
	echo "Failed to checkout the Image Deployment creation repository"
else
	echo "Ready to create the deployment images from input [$2]...."
	"$BUILD_DIR/ImageBuilder/create_images.sh" "$2" "$TARGET_DIR" "$BINARIES_DIR"
fi
