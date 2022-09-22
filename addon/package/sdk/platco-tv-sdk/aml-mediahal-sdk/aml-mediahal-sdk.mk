################################################################################
#
# aml-mediahal-sdk
#
################################################################################
AML_MEDIAHAL_SDK_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/vendor/amlogic/mediahal_sdk
AML_MEDIAHAL_SDK_VERSION = stable2
AML_MEDIAHAL_SDK_SITE_METHOD = git
AML_MEDIAHAL_SDK_LICENSE = PROPRIETARY
AML_MEDIAHAL_SDK_INSTALL_STAGING = YES

AML_MEDIAHAL_SDK_ARM_TARGET="arm.aapcs-linux.hard"
AML_MEDIAHAL_SDK_TA_TARGET="noarch"

define AML_MEDIAHAL_SDK_BUILD_CMDS
endef

define AML_MEDIAHAL_SDK_INSTALL_STAGING_CMDS
    $(INSTALL) -d -m 755 ${STAGING_DIR}/usr/lib
    $(INSTALL) -d -m 755 ${STAGING_DIR}/usr/include

    $(INSTALL) -D -m 755 $(@D)/prebuilt/${AML_MEDIAHAL_SDK_TA_TARGET}/include/*.h ${STAGING_DIR}/usr/include
    $(INSTALL) -D -m 755 $(@D)/prebuilt/${AML_MEDIAHAL_SDK_ARM_TARGET}/libmediahal_resman.so ${STAGING_DIR}/usr/lib
endef

define AML_MEDIAHAL_SDK_INSTALL_TARGET_CMDS
    $(INSTALL) -d -m 755 ${TARGET_DIR}/usr/lib
    $(INSTALL) -D -m 755 $(@D)/prebuilt/${AML_MEDIAHAL_SDK_ARM_TARGET}/libmediahal_resman.so ${TARGET_DIR}/usr/lib
endef

$(eval $(generic-package))