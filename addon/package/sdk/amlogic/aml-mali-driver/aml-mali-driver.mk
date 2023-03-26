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

define AML_MALI_DRIVER_AUTO_LOAD_MODULE_INSTALL
    $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modules-load.d
    echo "${1}" > "${TARGET_DIR}/etc/modules-load.d/${1}.conf"

    if [ ! -z "${2}" ]; then \
        $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modprobe.d ; \
        echo "${2}" > "${TARGET_DIR}/etc/modprobe.d/${1}.conf" ; \
    fi
endef

define AML_MALI_DRIVER_MODULE_LOAD_INIT_INSTALL
    $(INSTALL) -m 755 -d $(1)/etc/init.d/
    $(INSTALL) -m 755 $(@D)/init/modules $(1)/etc/init.d/S09modules
endef

###############################################################################
# Mali driver
###############################################################################

AML_MALI_DRIVER_MODULE_SUBDIRS += bifrost/r25p0/kernel/drivers/gpu/arm/midgard
AML_MALI_DRIVER_MODULE_MAKE_OPTS += \
	CONFIG_MALI_MIDGARD=m \
	CONFIG_MALI_PLATFORM_DEVICETREE=y \
	CONFIG_MALI_MIDGARD_DVFS=y \
	CONFIG_MALI_BACKEND=gpu

define AML_MALI_DRIVER_BUILD_CMDS
    ln -sf $(@D)/bifrost/r25p0/kernel/include/linux $(@D)/bifrost/r25p0/kernel/drivers/gpu/arm/midgard/linux
    $(call AML_MAL_DRIVER_LINUX_FUSION_COMPILE)
endef


$(eval $(kernel-module))
$(eval $(generic-package))
