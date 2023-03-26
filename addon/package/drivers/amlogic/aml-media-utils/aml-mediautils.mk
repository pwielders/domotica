################################################################################
#
# dolby-ms12
#
################################################################################
AML_MEDIAUTILS_SITE = git@github.com:Metrological/amlogic-mediautils-userspace.git
AML_MEDIAUTILS_VERSION = dd25e8113a24e32c73afd760d01b1ea956a2eda4
AML_MEDIAUTILS_SITE_METHOD = git
AML_MEDIAUTILS_LICENSE = PROPRIETARY
AML_MEDIAUTILS_INSTALL_STAGING = NO

AML_MEDIAUTILS_ARM_TARGET=arm.aapcs-linux.hard

define AML_MEDIAUTILS_BUILD_CMDS
endef

define AML_MEDIAUTILS_INSTALL_STAGING_CMDS
endef

define AML_MEDIAUTILS_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 755 $(TARGET_DIR)/vendor/lib

	$(INSTALL) -m 0755 $(@D)/dolby_ms12_release/src/$(AML_MEDIAUTILS_ARM_TARGET)/dolby_fw_dms12 $(TARGET_DIR)/sbin/dolby_fw_dms12
	$(INSTALL) -m 0755 $(@D)/dolby_ms12_release/src/libdolbyms12.so $(TARGET_DIR)/usr/lib/
	$(INSTALL) -m 0755 $(@D)/dolby_ms12_release/src/S55dsms12 $(TARGET_DIR)/etc/init.d/

	ln -sf /tmp/ds/0x4d_0x5331_0x32.so $(TARGET_DIR)/vendor/lib/libdolbyms12.so
endef

$(eval $(generic-package))
