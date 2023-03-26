################################################################################
#
# aml_media_utils
#
################################################################################
AML_MEDIA_UTILS_SITE = git@github.com:Metrological/amlogic-mediautils-userspace.git
AML_MEDIA_UTILS_VERSION = dd25e8113a24e32c73afd760d01b1ea956a2eda4
AML_MEDIA_UTILS_SITE_METHOD = git
AML_MEDIA_UTILS_LICENSE = PROPRIETARY
AML_MEDIA_UTILS_INSTALL_STAGING = NO

AML_MEDIA_UTILS_ARM_TARGET=arm.aapcs-linux.hard

define AML_MEDIA_UTILS_BUILD_CMDS
endef

define AML_MEDIA_UTILS_INSTALL_STAGING_CMDS
endef

define AML_MEDIA_UTILS_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 755 $(TARGET_DIR)/vendor/lib

	$(INSTALL) -m 0755 $(@D)/dolby_ms12_release/src/$(AML_MEDIA_UTILS_ARM_TARGET)/dolby_fw_dms12 $(TARGET_DIR)/sbin/dolby_fw_dms12
	$(INSTALL) -m 0755 $(@D)/dolby_ms12_release/src/libdolbyms12.so $(TARGET_DIR)/usr/lib/
	$(INSTALL) -m 0755 $(@D)/dolby_ms12_release/src/S55dsms12 $(TARGET_DIR)/etc/init.d/

	ln -sf /tmp/ds/0x4d_0x5331_0x32.so $(TARGET_DIR)/vendor/lib/libdolbyms12.so
endef

$(eval $(generic-package))
