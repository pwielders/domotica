################################################################################
#
# aml-mediahal-bsp
#
################################################################################
AML_MEDIAHAL_BSP_SITE = git@github.com:Metrological/amlogic-mediahal-bsp.git
AML_MEDIAHAL_BSP_VERSION = 0260ff83b2f752a437378d134239c59dcc65c523
AML_MEDIAHAL_BSP_SITE_METHOD = git
AML_MEDIAHAL_BSP_LICENSE = PROPRIETARY
AML_MEDIAHAL_BSP_INSTALL_STAGING = YES

AML_MEDIAHAL_BSP_ARM_TARGET="arm.aapcs-linux.hard"
AML_MEDIAHAL_BSP_TA_TARGET="noarch"

define AML_MEDIAHAL_BSP_BUILD_CMDS
endef

define AML_MEDIAHAL_BSP_INSTALL_STAGING_CMDS
    $(INSTALL) -d -m 755 ${STAGING_DIR}/usr/lib
    $(INSTALL) -d -m 755 ${STAGING_DIR}/usr/include

    $(INSTALL) -D -m 755 $(@D)/prebuilt/${AML_MEDIAHAL_BSP_TA_TARGET}/include/*.h ${STAGING_DIR}/usr/include
    $(INSTALL) -D -m 755 $(@D)/prebuilt/${AML_MEDIAHAL_BSP_ARM_TARGET}/libmediahal_resman.so ${STAGING_DIR}/usr/lib
endef

define AML_MEDIAHAL_BSP_INSTALL_TARGET_CMDS
    $(INSTALL) -d -m 755 ${TARGET_DIR}/usr/lib
    $(INSTALL) -D -m 755 $(@D)/prebuilt/${AML_MEDIAHAL_BSP_ARM_TARGET}/libmediahal_resman.so ${TARGET_DIR}/usr/lib
endef

$(eval $(generic-package))
