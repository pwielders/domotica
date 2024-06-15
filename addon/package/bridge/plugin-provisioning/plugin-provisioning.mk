################################################################################
#
# Plugin Provisioning
#
################################################################################
PLUGIN_PROVISIONING_VERSION = main
PLUGIN_PROVISIONING_SITE = git@git.integraal.info:integraal/modules.git
PLUGIN_PROVISIONING_SUBDIR = src/provisioning/Provisioning
PLUGIN_PROVISIONING_SITE_METHOD = git
PLUGIN_PROVISIONING_INSTALL_STAGING = NO
PLUGIN_PROVISIONING_DEPENDENCIES = bridge bridge-clients bridge-contracts libprovision
PLUGIN_PROVISIONING_CONF_OPTS = -DBUILD_REFERENCE=${PLUGIN_PROVISIONING_VERSION}
PLUGIN_PROVISIONING_CONF_OPTS += -DBUILD_TYPE=${BR2_PACKAGE_BRIDGE_BUILD_TYPE}
PLUGIN_PROVISIONING_CONF_OPTS += -DWPEFRAMEWORK_PROVISIONING_URI=${BR2_PACKAGE_PLUGIN_PROVISIONING_URI}
PLUGIN_PROVISIONING_CONF_OPTS += -DPLUGIN_PROVISIONING_OPERATOR=${BR2_PACKAGE_PLUGIN_PROVISIONING_OPERATOR}
PLUGIN_PROVISIONING_CONF_OPTS += -DENABLE_METROLOGICAL_CLOUD=ON
PLUGIN_PROVISIONING_CONF_OPTS += -DPLUGIN_PROVISIONING=ON

ifeq ($(shell expr $(BR2_PACKAGE_PLUGIN_CACHE_PERIODE) \> 0),1)
    PLUGIN_PROVISIONING_CONF_OPTS += -DPLUGIN_PROVISIONING_CACHE=$(call qstrip,$(BR2_PACKAGE_PLUGIN_PROVISIONING_CACHE_PERIODE))
endif

$(eval $(cmake-package))
