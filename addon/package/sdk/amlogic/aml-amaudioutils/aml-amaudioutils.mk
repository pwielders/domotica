################################################################################
#
# aml-amaudioutils
#
################################################################################
AML_AMAUDIOUTILS_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/linux/multimedia/amaudioutils
AML_AMAUDIOUTILS_VERSION = stable2
AML_AMAUDIOUTILS_SITE_METHOD = git
AML_AMAUDIOUTILS_LICENSE = PROPRIETARY
AML_AMAUDIOUTILS_INSTALL_STAGING = YES
AML_AMAUDIOUTILS_DEPENDENCIES = boost aml-commonlib

define AML_AMAUDIOUTILS_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CC=$(TARGET_CC) -C $(@D)/ all
endef

define AML_AMAUDIOUTILS_INSTALL_STAGING_CMDS
    $(INSTALL) -d ${STAGING_DIR}/usr/include/audio_utils
    $(INSTALL) -d ${STAGING_DIR}/usr/include/audio_utils/spdif
    $(INSTALL) -d ${STAGING_DIR}/usr/include/IpcBuffer

  	$(INSTALL) -m 644 -D $(@D)/libamaudioutils.so ${STAGING_DIR}/usr/lib
    $(INSTALL) -m 644 -D $(@D)/libcutils.so ${STAGING_DIR}/usr/lib

	$(INSTALL) -m 644 $(@D)/include/audio_utils/*.h ${STAGING_DIR}/usr/include/audio_utils
	$(INSTALL) -m 644 $(@D)/include/audio_utils/spdif/*.h ${STAGING_DIR}/usr/include/audio_utils/spdif
	$(INSTALL) -m 644 $(@D)/include/IpcBuffer/*.h ${STAGING_DIR}/usr/include/IpcBuffer/
endef

define AML_AMAUDIOUTILS_INSTALL_TARGET_CMDS
  	$(INSTALL) -m 644 -D $(@D)/libamaudioutils.so ${TARGET_DIR}/usr/lib
    $(INSTALL) -m 644 -D $(@D)/libcutils.so ${TARGET_DIR}/usr/lib
endef

$(eval $(generic-package))