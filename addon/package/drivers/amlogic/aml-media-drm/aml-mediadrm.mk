################################################################################
#
# aml-mediadrm
#
################################################################################
AML_MEDIADRM_SITE = git@github.com:Metrological/amlogic-mediadrm-userspace.git
AML_MEDIADRM_VERSION = e1aa101b4acc1790e4b2902d8f3e3e2c1bfd9027
AML_MEDIADRM_SITE_METHOD = git
AML_MEDIADRM_LICENSE = PROPRIETARY
AML_MEDIADRM_INSTALL_STAGING = YES
AML_MEDIADRM_DEPENDENCIES = aml-mediahal-bsp openssl

AML_MEDIADRM_ARM_TARGET="arm.aapcs-linux.hard"
AML_MEDIADRM_TA_TARGET="noarch"
AML_MEDIADRM_TDK_VERSION="v2.4"

define AML_MEDIADRM_BUILD_CMDS
endef

define AML_MEDIADRM_INSTALL_STAGING_CMDS
    $(INSTALL) -d -m 755 ${STAGING_DIR}/usr/include

    $(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_MEDIADRM_TA_TARGET}/include/*.h ${STAGING_DIR}/usr/include
    $(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_MEDIADRM_ARM_TARGET}/libsecmem.so ${STAGING_DIR}/usr/lib
endef

define AML_MEDIADRM_INSTALL_TARGET_CMDS
    $(INSTALL) -d -m 755 ${TARGET_DIR}/lib/teetz

    $(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_MEDIADRM_TA_TARGET}/ta/${AML_MEDIADRM_TDK_VERSION}/*.ta ${TARGET_DIR}/lib/teetz/
    $(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_MEDIADRM_ARM_TARGET}/secmem_test ${TARGET_DIR}/usr/bin
    $(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_MEDIADRM_ARM_TARGET}/libsecmem.so ${TARGET_DIR}/usr/lib
endef

$(eval $(generic-package))
