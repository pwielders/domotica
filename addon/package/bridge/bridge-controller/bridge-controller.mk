################################################################################
#
# Bridge Domotica
#
################################################################################
BRIDGE_CONTROLLER_VERSION = main
BRIDGE_CONTROLLER_SITE = git@git.integraal.info:domotica/controller.git
BRIDGE_CONTROLLER_SITE_METHOD = git
BRIDGE_CONTROLLER_CONFIGURE_CMDS = true
BRIDGE_CONTROLLER_BUILD_CMDS = true
BRIDGE_CONTROLLER_INSTALL_STAGING = NO
BRIDGE_CONTROLLER_INSTALL_TARGET = YES
BRIDGE_CONTROLLER_DEPENDENCIES = bridge plugin-common plugin-domotica
BRIDGE_CONTROLLER_CONF_OPTS = -DBUILD_REFERENCE=${BRIDGE_CONTROLLER_VERSION}

define BRIDGE_CONTROLLER_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/usr/share/bridge/Controller/UI
	mkdir -p $(TARGET_DIR)/usr/share/bridge/Controller/UI
	cp -r $(@D)/$(BRIDGE_CONTROLLER_SUBDIR)dist/* $(TARGET_DIR)/usr/share/bridge/Controller/UI
endef

$(eval $(generic-package))

