################################################################################
#
# amlogic-mali-driver
#
################################################################################
AMLOGIC_MALI_DRIVER_VERSION = ad08f6978ce2be1353fb2e0f37206576cb1dca8f
AMLOGIC_MALI_DRIVER_SITE = git@github.com:Metrological/amlogic-mali-drivers.git
AMLOGIC_MALI_DRIVER_SITE_METHOD = git
AMLOGIC_MALI_DRIVER_LICENSE = CLOSED

AMLOGIC_MALI_DRIVER_MODULE_SUBDIRS = bifrost/r25p0/kernel/drivers/gpu/arm/midgard
AMLOGIC_MALI_DRIVER_MODULE_MAKE_OPTS = \
	EXTRA_CFLAGS="-I$(@D)/bifrost/r25p0/kernel/include \
		-DCONFIG_MALI_PLATFORM_DEVICETREE \
		-DCONFIG_MALI_MIDGARD_DVFS \
		-DCONFIG_MALI_BACKEND=gpu" \
	CONFIG_MALI_MIDGARD=m \
	CONFIG_MALI_PLATFORM_DEVICETREE=y \
	CONFIG_MALI_MIDGARD_DVFS=y \
	CONFIG_MALI_BACKEND=gpu

$(eval $(kernel-module))
$(eval $(generic-package))
