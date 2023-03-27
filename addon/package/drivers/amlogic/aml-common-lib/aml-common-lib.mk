################################################################################
#
# aml_common_lib
#
################################################################################
AML_COMMON_LIB_SITE = git@github.com:Metrological/amlogic-common-lib.git
AML_COMMON_LIB_VERSION = 67af48ec6b9db2504435a824996e588274d9f1cf
AML_COMMON_LIB_SITE_METHOD = git
AML_COMMON_LIB_LICENSE = PROPRIETARY
AML_COMMON_LIB_INSTALL_STAGING = YES

define AML_COMMON_LIB_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CC=$(TARGET_CC) -C $(@D)/liblog
endef

define AML_COMMON_LIB_INSTALL_STAGING_CMDS
	$(INSTALL) -d ${STAGING_DIR}/usr/lib
	$(INSTALL) -d ${STAGING_DIR}/usr/include
	$(INSTALL) -m 0644 ${@D}/liblog/liblog.so ${STAGING_DIR}/usr/lib
	cp -ra ${@D}/liblog/include/* ${STAGING_DIR}/usr/include
endef

define AML_COMMON_LIB_INSTALL_TARGET_CMDS
    $(INSTALL) -d ${TARGET_DIR}/usr/lib
    $(INSTALL) -m 0644 ${@D}/liblog/liblog.so ${TARGET_DIR}/usr/lib
endef

$(eval $(generic-package))
