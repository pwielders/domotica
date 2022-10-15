export BR2_EXTERNAL="${PWD}/addon"
find ./addon -type f -exec sed -i 's/BR2_EXTERNAL_ML_CSS_PATH/BR2_EXTERNAL_ADDON_PACKAGES_PATH/g' {} \;
find ./addon -type f -exec sed -i 's/BR2_EXTERNAL_ML_OSS_PATH/BR2_EXTERNAL_ADDON_PACKAGES_PATH/g' {} \;

