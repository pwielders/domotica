################################################################################
#
# aml-mali
#
################################################################################
AML_MALI_DRIVER_VERSION = main
AML_MALI_DRIVER_SITE = git@github.com:Metrological/SDK_Platco_TV.git
AML_MALI_DRIVER_SITE_METHOD = git
AML_MALI_DRIVER_LICENSE = CLOSED
AML_MALI_DRIVER_INSTALL_STAGING = YES
AML_MALI_DRIVER_INSTALL_TARGET = YES
AML_MALI_DRIVER_DEPENDENCIES = libdrm wayland linux

AML_MALI_DRIVER_KO_DIR=lib/modules/4.9.113

define AML_MALI_DRIVER_AUTO_LOAD_MODULE_INSTALL
    $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modules-load.d
    echo "${1}" > "${TARGET_DIR}/etc/modules-load.d/${1}.conf"

    if [ ! -z "${2}" ]; then \
        $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modprobe.d ; \
        echo "${2}" > "${TARGET_DIR}/etc/modprobe.d/${1}.conf" ; \
    fi
endef

define AML_MALI_DRIVER_APPLY_PATCH
    if [ ! -f "${@D}/.${3}.applied" ]; then ($(APPLY_PATCHES) $(1) $(2) $(3) && touch "${@D}/.${3}.applied"); fi
endef

define AML_MALI_DRIVER_MODULE_LOAD_INIT_INSTALL
    $(INSTALL) -m 755 -d $(1)/etc/init.d/
    $(INSTALL) -m 755 $(@D)/init/modules $(1)/etc/init.d/S09modules
endef

###############################################################################
# Mali driver
###############################################################################

AML_MALI_DRIVER_MODULE_SUBDIRS += mali_driver/bifrost/r25p0/kernel/drivers/gpu/arm/midgard
AML_MALI_DRIVER_MODULE_MAKE_OPTS += \
	CONFIG_MALI_MIDGARD=m \
	CONFIG_MALI_PLATFORM_DEVICETREE=y \
	CONFIG_MALI_MIDGARD_DVFS=y \
	CONFIG_MALI_BACKEND=gpu

$(eval $(kernel-module))