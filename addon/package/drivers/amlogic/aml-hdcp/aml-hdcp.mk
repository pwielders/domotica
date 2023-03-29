################################################################################
#
# aml-hdcp
#
################################################################################
AML_HDCP_SITE = git@github.com:Metrological/amlogic-hdcp.git
AML_HDCP_VERSION = 1535513a711aaf240eafe1bd79ea6718b170f7ce
AML_HDCP_SITE_METHOD = git
AML_HDCP_LICENSE = PROPRIETARY
AML_HDCP_INSTALL_STAGING = NO

define AML_HDCP_BUILD_CMDS
endef

define AML_HDCP_INSTALL_TARGET_CMDS
    $(INSTALL) -m 755 $(@D)/ca/bin/tee_hdcp ${TARGET_DIR}/usr/bin
    $(INSTALL) -m 755 $(@D)/ca/bin/hdcp_rx22 ${TARGET_DIR}/usr/bin
    $(INSTALL) -d -m 755 ${STAGING_DIR}/lib/teetz/
    $(INSTALL) -m 600 $(@D)/ta/v2.4/ff2a4bea-ef6d-11e6-89cc-d4ae52a7b3b3.ta ${TARGET_DIR}/lib/teetz
endef

$(eval $(generic-package))
