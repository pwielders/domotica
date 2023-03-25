################################################################################
#
# aml-audio-service
#
################################################################################
AML_AUDIO_SERVICE_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/linux/multimedia/audio_server
AML_AUDIO_SERVICE_VERSION = stable2
AML_AUDIO_SERVICE_SITE_METHOD = git
AML_AUDIO_SERVICE_LICENSE = PROPRIETARY
AML_AUDIO_SERVICE_INSTALL_STAGING = YES
AML_AUDIO_SERVICE_DEPENDENCIES = grpc host-grpc host-protobuf aml-amaudioutils dolby-ms12 aml-commonlib boost

define AML_AUDIO_SERVICE_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CC=$(TARGET_CC) -C $(@D)/ all
endef

define AML_AUDIO_SERVICE_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/include/hardware
	$(INSTALL) -d $(STAGING_DIR)/usr/include/system

	$(INSTALL) -m 644 -D $(@D)/libaudio_client.so -t $(STAGING_DIR)/usr/lib/
	$(INSTALL) -m 644 -D $(@D)/include/audio_if_client.h -t $(STAGING_DIR)/usr/include
	$(INSTALL) -m 644 -D $(@D)/include/audio_if.h -t $(STAGING_DIR)/usr/include
	$(INSTALL) -m 644 -D $(@D)/include/audio_effect_if.h -t $(STAGING_DIR)/usr/include
	$(INSTALL) -m 644 -D $(@D)/include/audio_effect_params.h -t $(STAGING_DIR)/usr/include
	$(INSTALL) -m 644 -D $(@D)/include/hardware/*.h $(STAGING_DIR)/usr/include/hardware
	$(INSTALL) -m 644 -D $(@D)/include/system/*.h $(STAGING_DIR)/usr/include/system
endef

define AML_AUDIO_SERVICE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -D $(@D)/audio_server -t $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/audio_client_test -t $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/audio_client_test_ac3 $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/halplay $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/dap_setting $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/speaker_delay $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/digital_mode $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/test_arc $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/start_arc $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/hal_param $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/hal_dump $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/hal_patch $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/master_vol $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 755 -D $(@D)/effect_tool $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 644 -D $(@D)/libaudio_client.so -t $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))