################################################################################
#
# aml-audio-sync
#
################################################################################
AML_AUDIO_SYNC_SITE = git@github.com:Metrological/amlogic-audio-sync.git
AML_AUDIO_SYNC_VERSION = 68003f9e12790ff713be363a0efe94107599fd8d
AML_AUDIO_SYNC_SITE_METHOD = git
AML_AUDIO_SYNC_LICENSE = PROPRIETARY
AML_AUDIO_SYNC_INSTALL_STAGING = YES

define AML_AUDIO_SYNC_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CC=$(TARGET_CC) -C $(@D)/src
endef

define AML_AUDIO_SYNC_INSTALL_STAGING_CMDS
	$(INSTALL) -m 644 $(@D)/src/aml_avsync_log.h $(STAGING_DIR)/usr/include/
	$(INSTALL) -m 644 $(@D)/src/aml_avsync.h $(STAGING_DIR)/usr/include/
	$(INSTALL) -m 644 $(@D)/src/libamlavsync.so $(STAGING_DIR)/usr/lib/
endef

define AML_AUDIO_SYNC_INSTALL_TARGET_CMDS
	$(INSTALL) -m 644 $(@D)/src/libamlavsync.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
