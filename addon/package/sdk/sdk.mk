################################################################################
#
# sdk
#
################################################################################

$(eval $(virtual-package))

include $(sort $(wildcard $(BR2_EXTERNAL_ADDON_PACKAGES_PATH)/package/sdk/*/*.mk))
