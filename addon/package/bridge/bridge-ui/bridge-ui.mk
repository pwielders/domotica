################################################################################
#
# Bridge UI
#
################################################################################
BRIDGE_UI_VERSION = main
BRIDGE_UI_SITE = git@git.integraal.info:integraal/thunder-iot-js.git
BRIDGE_UI_SITE_METHOD = git
BRIDGE_UI_CONFIGURE_CMDS = true
BRIDGE_UI_BUILD_CMDS = true
BRIDGE_UI_INSTALL_STAGING = NO
BRIDGE_UI_INSTALL_TARGET = YES
BRIDGE_UI_DEPENDENCIES = bridge plugin-common
BRIDGE_UI_CONF_OPTS = -DBUILD_REFERENCE=${BRIDGE_UI_VERSION}

define BRIDGE_UI_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/bridge/WebServer/iot
	cp -r $(@D)/$(BRIDGE_UI_SUBDIR)dist/* $(TARGET_DIR)/usr/share/bridge/WebServer/iot
endef

$(eval $(generic-package))

