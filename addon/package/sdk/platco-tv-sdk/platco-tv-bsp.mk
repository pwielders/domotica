################################################################################
#
# platco-tv-bsp
#
################################################################################
PLATCO_TV_BSP_VERSION = main
PLATCO_TV_BSP_SITE = git@github.com:Metrological/SDK_Platco_TV.git
PLATCO_TV_BSP_SITE_METHOD = git
PLATCO_TV_BSP_LICENSE = CLOSED
PLATCO_TV_BSP_INSTALL_STAGING = YES
PLATCO_TV_BSP_INSTALL_TARGET = YES
PLATCO_TV_BSP_DEPENDENCIES = libdrm wayland linux

PLATCO_TV_BSP_KO_DIR=lib/modules/4.9.113

define PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL
    $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modules-load.d
    echo "${1}" > "${TARGET_DIR}/etc/modules-load.d/${1}.conf"

    if [ ! -z "${2}" ]; then \
        $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modprobe.d ; \
        echo "${2}" > "${TARGET_DIR}/etc/modprobe.d/${1}.conf" ; \
    fi
endef

define PLATCO_TV_BSP_APPLY_PATCH
    if [ ! -f "${@D}/.${3}.applied" ]; then ($(APPLY_PATCHES) $(1) $(2) $(3) && touch "${@D}/.${3}.applied"); fi
endef

define PLATCO_TV_BSP_FIX_LIBDRM_INCLUDE
    ln -sf libdrm/drm_fourcc.h $(1)/usr/include/drm_fourcc.h
    ln -sf libdrm/drm.h $(1)/usr/include/drm.h
    ln -sf libdrm/drm_mode.h $(1)/usr/include/drm_mode.h
endef

define PLATCO_TV_BSP_MODULE_LOAD_INIT_INSTALL
    $(INSTALL) -m 755 -d $(1)/etc/init.d/
    $(INSTALL) -m 755 $(@D)/init/modules $(1)/etc/init.d/S09modules
endef

###############################################################################
# WiFi driver
###############################################################################
define PLATCO_TV_BSP_WIFI_TOOL_BUILD_CMD
    $(MAKE) -C $(@D)/sky_tools/utils wifi_power
endef

define PLATCO_TV_BSP_WIFI_TOOL_INSTALL
    $(INSTALL) -m 755 -d $(1)/usr/bin
    $(INSTALL) -m 755 $(@D)/sky_tools/utils/wifi_power $(1)/usr/bin
endef

define PLATCO_TV_BSP_WIFI_INIT_INSTALL
    $(INSTALL) -m 755 -d $(1)/etc/init.d
    $(INSTALL) -m 755 $(@D)/init/wifidriver $(1)/etc/init.d/S31wifi
endef

PLATCO_TV_BSP_MODULE_SUBDIRS += wifi_qca6174/AIO/drivers/qcacld-new
PLATCO_TV_BSP_MODULE_MAKE_OPTS += \
    WLAN_ROOT="$(@D)/wifi_qca6174/AIO/drivers/qcacld-new" \
    CONFIG_QCA_WIFI_ISOC=0 \
    CONFIG_QCA_WIFI_2_0=1 \
    CONFIG_QCA_CLD_WLAN=m \
    WLAN_OPEN_SOURCE=1 \
    CONFIG_CLD_HL_SDIO_CORE=y \
    CONFIG_LINUX_QCMBR=y

define PLATCO_TV_BSP_INSTALL_WIFI_FIRMWARE
    $(INSTALL) -m 755 -d $(TARGET_DIR)/lib/firmware/
    $(INSTALL) -m 644 $(@D)/wifi_firmware/* $(TARGET_DIR)/lib/firmware/
endef
PLATCO_TV_BSP_POST_INSTALL_TARGET_HOOKS += PLATCO_TV_BSP_INSTALL_WIFI_FIRMWARE

###############################################################################
# PQ driver
###############################################################################
define PLATCO_TV_BSP_PREBUILD_PQ_MODULE_INSTALL
    $(INSTALL) -m 755 -d $(TARGET_DIR)/$(PLATCO_TV_BSP_KO_DIR)/kernel/pq
    $(INSTALL) -m 644 $(@D)/pq_prebuild/kernel-module/pq/*.ko $(TARGET_DIR)/$(PLATCO_TV_BSP_KO_DIR)/kernel/pq/
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,dnlp_alg_32)
endef
PLATCO_TV_BSP_POST_INSTALL_TARGET_HOOKS += PLATCO_TV_BSP_PREBUILD_PQ_MODULE_INSTALL

###############################################################################
# Generic BR targets
###############################################################################
define PLATCO_TV_BSP_BUILD_CMDS
    $(call PLATCO_TV_BSP_WIFI_TOOL_BUILD_CMD)
    $(call PLATCO_TV_BSP_LINUX_FUSION_COMPILE)
endef

define PLATCO_TV_BSP_INSTALL_STAGING_CMDS
    $(call PLATCO_TV_BSP_FIX_LIBDRM_INCLUDE,$(STAGING_DIR))
    $(call PLATCO_TV_BSP_INSTALL_MALI_DEV,$(STAGING_DIR))
endef

define PLATCO_TV_BSP_INSTALL_TARGET_CMDS
    $(call PLATCO_TV_BSP_INSTALL_MALI_LIB,$(TARGET_DIR))
    $(call PLATCO_TV_BSP_WIFI_INIT_INSTALL,$(TARGET_DIR))
    $(call PLATCO_TV_BSP_MODULE_LOAD_INIT_INSTALL,$(TARGET_DIR))
    $(call PLATCO_TV_BSP_WIFI_TOOL_INSTALL,$(TARGET_DIR))
endef

$(eval $(generic-package))
$(eval $(kernel-module))

