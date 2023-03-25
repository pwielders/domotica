################################################################################
#
# aml-secmem
#
################################################################################
AML_SECMEM_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/prebuilt/libmediadrm
AML_SECMEM_VERSION = stable2
AML_SECMEM_SITE_METHOD = git
AML_SECMEM_LICENSE = PROPRIETARY
AML_SECMEM_INSTALL_STAGING = YES
AML_SECMEM_DEPENDENCIES = aml-mediahal-sdk openssl

AML_SECMEM_ARM_TARGET="arm.aapcs-linux.hard"
AML_SECMEM_TA_TARGET="noarch"
AML_SECMEM_TDK_VERSION="v2.4"

define AML_SECMEM_BUILD_CMDS
endef

define AML_SECMEM_INSTALL_STAGING_CMDS
    $(INSTALL) -d -m 755 ${STAGING_DIR}/usr/include

    $(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_SECMEM_TA_TARGET}/include/*.h ${STAGING_DIR}/usr/include
    $(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_SECMEM_ARM_TARGET}/libsecmem.so ${STAGING_DIR}/usr/lib
endef

define AML_SECMEM_INSTALL_TARGET_CMDS
    $(INSTALL) -d -m 755 ${TARGET_DIR}/lib/teetz

    $(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_SECMEM_TA_TARGET}/ta/${AML_SECMEM_TDK_VERSION}/*.ta ${TARGET_DIR}/lib/teetz/
    $(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_SECMEM_ARM_TARGET}/secmem_test ${TARGET_DIR}/usr/bin
    $(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_SECMEM_ARM_TARGET}/libsecmem.so ${TARGET_DIR}/usr/lib
endef

$(eval $(generic-package))