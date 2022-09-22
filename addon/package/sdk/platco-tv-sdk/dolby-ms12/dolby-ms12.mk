################################################################################
#
# dolby-ms12
#
################################################################################
DOLBY_MS12_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/linux/multimedia/utils
DOLBY_MS12_VERSION = stable2
DOLBY_MS12_SITE_METHOD = git
DOLBY_MS12_LICENSE = PROPRIETARY
DOLBY_MS12_INSTALL_STAGING = NO

DOLBY_MS12_ARM_TARGET=arm.aapcs-linux.hard

define DOLBY_MS12_BUILD_CMDS
endef

define DOLBY_MS12_INSTALL_STAGING_CMDS
endef

define DOLBY_MS12_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 755 $(TARGET_DIR)/vendor/lib

	$(INSTALL) -m 0755 $(@D)/dolby_ms12_release/src/$(DOLBY_MS12_ARM_TARGET)/dolby_fw_dms12 $(TARGET_DIR)/sbin/dolby_fw_dms12
	$(INSTALL) -m 0755 $(@D)/dolby_ms12_release/src/libdolbyms12.so $(TARGET_DIR)/usr/lib/
	$(INSTALL) -m 0755 $(@D)/dolby_ms12_release/src/S55dsms12 $(TARGET_DIR)/etc/init.d/

	ln -sf /tmp/ds/0x4d_0x5331_0x32.so $(TARGET_DIR)/vendor/lib/libdolbyms12.so
endef

$(eval $(generic-package))