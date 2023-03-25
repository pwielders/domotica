################################################################################
#
# aml-avsync
#
################################################################################
AML_AVSYNC_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/linux/multimedia/libavsync
AML_AVSYNC_VERSION = stable2
AML_AVSYNC_SITE_METHOD = git
AML_AVSYNC_LICENSE = PROPRIETARY
AML_AVSYNC_INSTALL_STAGING = YES

define AML_AVSYNC_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CC=$(TARGET_CC) -C $(@D)/src
endef

define AML_AVSYNC_INSTALL_STAGING_CMDS
	$(INSTALL) -m 644 $(@D)/src/aml_avsync_log.h $(STAGING_DIR)/usr/include/
	$(INSTALL) -m 644 $(@D)/src/aml_avsync.h $(STAGING_DIR)/usr/include/
	$(INSTALL) -m 644 $(@D)/src/libamlavsync.so $(STAGING_DIR)/usr/lib/
endef

define AML_AVSYNC_INSTALL_TARGET_CMDS
	$(INSTALL) -m 644 $(@D)/src/libamlavsync.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
