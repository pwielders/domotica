################################################################################
#
# aml_commonlib
#
################################################################################
AML_COMMONLIB_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/aml_commonlib
AML_COMMONLIB_VERSION = stable2
AML_COMMONLIB_SITE_METHOD = git
AML_COMMONLIB_LICENSE = PROPRIETARY
AML_COMMONLIB_INSTALL_STAGING = YES

define AML_COMMONLIB_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CC=$(TARGET_CC) -C $(@D)/liblog
endef

define AML_COMMONLIB_INSTALL_STAGING_CMDS
	$(INSTALL) -d ${STAGING_DIR}/usr/lib
    $(INSTALL) -d ${STAGING_DIR}/usr/include
    $(INSTALL) -m 0644 ${@D}/liblog/liblog.so ${STAGING_DIR}/usr/lib
    cp -ra ${@D}/liblog/include/* ${STAGING_DIR}/usr/include
endef

define AML_COMMONLIB_INSTALL_TARGET_CMDS
    $(INSTALL) -d ${TARGET_DIR}/usr/lib
    $(INSTALL) -m 0644 ${@D}/liblog/liblog.so ${TARGET_DIR}/usr/lib
endef

$(eval $(generic-package))