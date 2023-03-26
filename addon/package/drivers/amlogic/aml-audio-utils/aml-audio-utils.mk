################################################################################
#
# aml-audio-utils
#
################################################################################
AML_AUDIO_UTILS_SITE = git@github.com:Metrological/amlogic-audio-utils.git
AML_AUDIO_UTILS_VERSION = f9cb1584bf7da04600bb9bfef6a7413643f29729
AML_AUDIO_UTILS_SITE_METHOD = git
AML_AUDIO_UTILS_LICENSE = PROPRIETARY
AML_AUDIO_UTILS_INSTALL_STAGING = YES
AML_AUDIO_UTILS_DEPENDENCIES = boost aml-common-lib

define AML_AUDIO_UTILS_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CC=$(TARGET_CC) -C $(@D)/ all
endef

define AML_AUDIO_UTILS_INSTALL_STAGING_CMDS
    $(INSTALL) -d ${STAGING_DIR}/usr/include/audio_utils
    $(INSTALL) -d ${STAGING_DIR}/usr/include/audio_utils/spdif
    $(INSTALL) -d ${STAGING_DIR}/usr/include/IpcBuffer

  	$(INSTALL) -m 644 -D $(@D)/libamaudioutils.so ${STAGING_DIR}/usr/lib
    $(INSTALL) -m 644 -D $(@D)/libcutils.so ${STAGING_DIR}/usr/lib

	$(INSTALL) -m 644 $(@D)/include/audio_utils/*.h ${STAGING_DIR}/usr/include/audio_utils
	$(INSTALL) -m 644 $(@D)/include/audio_utils/spdif/*.h ${STAGING_DIR}/usr/include/audio_utils/spdif
	$(INSTALL) -m 644 $(@D)/include/IpcBuffer/*.h ${STAGING_DIR}/usr/include/IpcBuffer/
endef

define AML_AUDIO_UTILS_INSTALL_TARGET_CMDS
  	$(INSTALL) -m 644 -D $(@D)/libamaudioutils.so ${TARGET_DIR}/usr/lib
    $(INSTALL) -m 644 -D $(@D)/libcutils.so ${TARGET_DIR}/usr/lib
endef

$(eval $(generic-package))
