################################################################################
#
# aml-mali-driver
#
################################################################################
AML_MALI_DRIVER_VERSION = ad08f6978ce2be1353fb2e0f37206576cb1dca8f
AML_MALI_DRIVER_SITE = git@github.com:Metrological/amlogic-mali-driver.git
AML_MALI_DRIVER_SITE_METHOD = git
AML_MALI_DRIVER_LICENSE = CLOSED
AML_MALI_DRIVER_INSTALL_STAGING = YES
AML_MALI_DRIVER_INSTALL_TARGET = YES
AML_MALI_DRIVER_DEPENDENCIES = linux

AML_MALI_DRIVER_KO_DIR=lib/modules/4.9.113

###############################################################################
# Mali driver
###############################################################################

AML_MALI_DRIVER_MODULE_SUBDIRS = bifrost/r25p0/kernel/drivers/gpu/arm/midgard
AML_MALI_DRIVER_MODULE_MAKE_OPTS = \
	EXTRA_CFLAGS="-I$(@D)/bifrost/r25p0/kernel/include \
                -DCONFIG_MALI_PLATFORM_DEVICETREE \
                -DCONFIG_MALI_MIDGARD_DVFS \
                -DCONFIG_MALI_BACKEND=gpu" \
	CONFIG_MALI_MIDGARD=m \
	CONFIG_MALI_PLATFORM_DEVICETREE=y \
	CONFIG_MALI_MIDGARD_DVFS=y \
	CONFIG_MALI_BACKEND=gpu

# define AML_MALI_DRIVER_BUILD_CMDS
#     ln -sf $(@D)/bifrost/r25p0/kernel/include/linux $(@D)/bifrost/r25p0/kernel/drivers/gpu/arm/midgard/linux
#     $(call AML_MAL_DRIVER_LINUX_FUSION_COMPILE)
# endef

$(eval $(kernel-module))
$(eval $(generic-package))
