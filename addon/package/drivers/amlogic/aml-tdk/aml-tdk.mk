################################################################################
#
# aml-tdk
#
################################################################################
AML_TDK_SITE = git@github.com:Metrological/amlogic-tdk.git
AML_TDK_VERSION = 96ca7c90d6a0dc1a42835a497179b01151416d39
AML_TDK_SITE_METHOD = git
AML_TDK_LICENSE = PROPRIETARY
AML_TDK_INSTALL_STAGING = YES

define AML_TDK_BUILD_CMDS
endef

define AML_TDK_INSTALL_STAGING_CMDS
    $(INSTALL) -d -m 755 ${STAGING_DIR}/usr/include
    $(INSTALL) -m 755 $(@D)/ca_export_arm/include/* ${STAGING_DIR}/usr/include/
    $(INSTALL) -m 755 $(@D)/ca_export_arm/bin/tee-supplicant ${STAGING_DIR}/usr/bin

    $(INSTALL) -m 755 $(@D)/ca_export_arm/lib/libteec.so.1.0 ${STAGING_DIR}/usr/lib
    ln -sf libteec.so.1 ${STAGING_DIR}/usr/lib/libteec.so.1.0
    ln -sf libteec.so   ${STAGING_DIR}/usr/lib/libteec.so.1.0
endef

define AML_TDK_INSTALL_TARGET_CMDS
    $(INSTALL) -m 755 $(@D)/ca_export_arm/bin/tee-supplicant ${TARGET_DIR}/usr/bin
    $(INSTALL) -m 755 $(@D)/ca_export_arm/lib/libteec.so.1.0 ${TARGET_DIR}/usr/lib
    ln -sf libteec.so.1.0 ${TARGET_DIR}/usr/lib/libteec.so
    ln -sf libteec.so.1.0 ${TARGET_DIR}/usr/lib/libteec.so.1
endef

$(eval $(generic-package))
