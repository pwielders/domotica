################################################################################
#
# drivers
#
################################################################################

$(eval $(virtual-package))

include $(sort $(wildcard $(BR2_EXTERNAL_ML_CSS_PATH)/package/drivers/*/*.mk))
