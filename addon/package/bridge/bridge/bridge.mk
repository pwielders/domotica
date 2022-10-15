################################################################################
#
# Bridge
#
################################################################################

BRIDGE_VERSION = main 
BRIDGE_SITE_METHOD = git
BRIDGE_SITE = git@git.integraal.info:domotica/framework.git
BRIDGE_SUBDIR = src
BRIDGE_INSTALL_STAGING = YES
BRIDGE_DEPENDENCIES = zlib host-bridge-tools
BRIDGE_CONF_OPTS = -DBUILD_REFERENCE=$(BRIDGE_VERSION) -DTREE_REFERENCE=$(shell $(GIT) rev-parse HEAD)

BRIDGE_CONF_OPTS += -DBRIDGE_TEST_APPS=ON -DBRIDGE_TEST_LOADER=ON -DBRIDGE_INSTALL_HEADERS=ON -DPROTOCOLS=OFF -DCOM=ON -DWEBSOCKET=ON -DHIDE_NON_EXTERNAL_SYMBOLS=ON

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE),y)
    BRIDGE_CONF_OPTS += -DPLATFORM=RASPBERRYPI
endif

ifneq ($(BR2_PACKAGE_BRIDGE_PORT),)
BRIDGE_CONF_OPTS += -DBRIDGE_PORT=$(BR2_PACKAGE_BRIDGE_PORT)
BRIDGE_CONF_OPTS += -DPORT=$(BR2_PACKAGE_BRIDGE_PORT)
endif

ifneq ($(BR2_PACKAGE_BRIDGE_BIND),)
BRIDGE_CONF_OPTS += -DBRIDGE_BINDING=$(BR2_PACKAGE_BRIDGE_BIND)
endif

ifneq ($(BR2_PACKAGE_BRIDGE_IDLE_TIME),)
BRIDGE_CONF_OPTS += -DBRIDGE_IDLE_TIME=$(BR2_PACKAGE_BRIDGE_IDLE_TIME)
endif

ifneq ($(BR2_PACKAGE_BRIDGE_PERSISTENT_PATH),)
BRIDGE_CONF_OPTS += -DBRIDGE_PERSISTENT_PATH=$(BR2_PACKAGE_BRIDGE_PERSISTENT_PATH)
BRIDGE_CONF_OPTS += -DPERSISTENT_PATH=$(BR2_PACKAGE_BRIDGE_PERSISTENT_PATH)
endif

ifneq ($(BR2_PACKAGE_BRIDGE_DATA_PATH),)
BRIDGE_CONF_OPTS += -DBRIDGE_DATA_PATH=$(BR2_PACKAGE_BRIDGE_DATA_PATH)
BRIDGE_CONF_OPTS += -DDATA_PATH=$(BR2_PACKAGE_BRIDGE_DATA_PATH)
endif

ifneq ($(BR2_PACKAGE_BRIDGE_SYSTEM_PATH),)
BRIDGE_CONF_OPTS += -DBRIDGE_SYSTEM_PATH=$(BR2_PACKAGE_BRIDGE_SYSTEM_PATH)
BRIDGE_CONF_OPTS += -DSYSTEM_PATH=$(BR2_PACKAGE_BRIDGE_SYSTEM_PATH)
endif

ifneq ($(BR2_PACKAGE_BRIDGE_VOLATILE_PATH),)
BRIDGE_CONF_OPTS += -DBRIDGE_VOLATILE_PATH=$(BR2_PACKAGE_BRIDGE_VOLATILE_PATH)
BRIDGE_CONF_OPTS += -DVOLATILE_PATH=$(BR2_PACKAGE_BRIDGE_VOLATILE_PATH)
endif

ifneq ($(BR2_PACKAGE_BRIDGE_PROXYSTUB_PATH),)
BRIDGE_CONF_OPTS += -DBRIDGE_PROXYSTUB_PATH=$(BR2_PACKAGE_BRIDGE_PROXYSTUB_PATH)
BRIDGE_CONF_OPTS += -DPROXYSTUB_PATH=$(BR2_PACKAGE_BRIDGE_PROXYSTUB_PATH)
endif

ifneq ($(BR2_PACKAGE_BRIDGE_OOM_ADJUST),)
BRIDGE_CONF_OPTS += -DBRIDGE_OOMADJUST=$(BR2_PACKAGE_BRIDGE_OOM_ADJUST)
endif

# BRIDGE_CONF_OPTS += -DBRIDGE_WEBSERVER_PATH=
# BRIDGE_CONF_OPTS += -DBRIDGE_WEBSERVER_PORT=
# BRIDGE_CONF_OPTS += -DBRIDGE_CONFIG_INSTALL_PATH=
# BRIDGE_CONF_OPTS += -DBRIDGE_IPV6_SUPPORT=
# BRIDGE_CONF_OPTS += -DBRIDGE_PRIORITY=
# BRIDGE_CONF_OPTS += -DBRIDGE_POLICY=
# BRIDGE_CONF_OPTS += -DBRIDGE_STACKSIZE=

ifeq ($(BR2_PACKAGE_BRIDGE_DEBUG),y)
    BRIDGE_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
else ifeq ($(BR2_PACKAGE_BRIDGE_RELEASE),y)
    BRIDGE_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
else 
    BRIDGE_CONF_OPTS += -DCMAKE_BUILD_TYPE=MinSizeRel
endif

ifeq ($(BR2_PACKAGE_BRIDGE_BLUETOOTH), y)
BRIDGE_CONF_OPTS += -DBLUETOOTH_SUPPORT=ON
BRIDGE_DEPENDENCIES += bluez5_utils-headers
endif

ifeq ($(BR2_PACKAGE_BRIDGE_MESSAGING), y)
BRIDGE_CONF_OPTS += -DMESSAGING=ON
BRIDGE_CONF_OPTS += -DTRACING=OFF
else
BRIDGE_CONF_OPTS += -DMESSAGING=OFF
BRIDGE_CONF_OPTS += -DTRACING=ON
endif

ifeq ($(BR2_PACKAGE_BRIDGE_VIRTUALINPUT),y)
BRIDGE_CONF_OPTS += -DVIRTUALINPUT=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_PROVISIONING),y)
BRIDGE_EXTERN_EVENTS += Provisioning
endif

ifeq ($(BR2_PACKAGE_PLUGIN_LOCATIONSYNC),y)
BRIDGE_EXTERN_EVENTS += Internet
BRIDGE_EXTERN_EVENTS += Location
endif

ifeq ($(BR2_PACKAGE_PLUGIN_TIMESYNC),y)
BRIDGE_EXTERN_EVENTS += Time
endif

ifeq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR),y)
BRIDGE_EXTERN_EVENTS += Platform
BRIDGE_EXTERN_EVENTS += Graphics
endif

ifeq ($(BR2_PACKAGE_PLUGIN_NETWORKCONTROL),y)
BRIDGE_EXTERN_EVENTS += Network
endif

ifeq ($(BR2_PACKAGE_PLUGIN_CDMI),y)
BRIDGE_EXTERN_EVENTS += Decryption
endif

ifeq ($(BR2_PACKAGE_PLUGIN_STREAMER),y)
PEFRAMEWORK_EXTERN_EVENTS += Streaming
endif

ifeq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER),y)
BRIDGE_CONF_OPTS += -DPLUGIN_WEBKITBROWSER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_WEBSERVER),y)
BRIDGE_EXTERN_EVENTS += WebSource
BRIDGE_CONF_OPTS += -DPLUGIN_WEBSERVER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_ESPIAL),y)
BRIDGE_CONF_OPTS += -DPLUGIN_ESPIAL=ON
endif

BRIDGE_CONF_OPTS += -DEXTERN_EVENTS="${BRIDGE_EXTERN_EVENTS}"

ifeq ($(BR2_PACKAGE_BRIDGE_DEVICES),y)
    BRIDGE_CONF_OPTS += -DDEVICES=ON		
    BRIDGE_DEPENDENCIES += libusb
endif

ifeq ($(BR2_PACKAGE_BRIDGE_ZWAVE),y)
    BRIDGE_CONF_OPTS += -DZWAVE=ON		
endif

ifeq ($(BR2_PACKAGE_BRIDGE_ZIGBEE),y)
    BRIDGE_CONF_OPTS += -DZIGBEE=ON		
endif

ifeq ($(BR2_PACKAGE_PLUGIN_PROVISIONING),y)		
EXTERN_SUBSYSTEM += Provisioning
endif
ifeq ($(BR2_PACKAGE_PLUGIN_LOCATIONSYNC),y)
EXTERN_SUBSYSTEM += Internet
EXTERN_SUBSYSTEM += Location
endif
ifeq ($(BR2_PACKAGE_PLUGIN_TIMESYNC),y)
EXTERN_SUBSYSTEM += Time
endif
ifeq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR),y)
EXTERN_SUBSYSTEM += Platform
EXTERN_SUBSYSTEM += Graphics
endif
ifeq ($(BR2_PACKAGE_PLUGIN_NETWORKCONTROL),y)
EXTERN_SUBSYSTEM += Network
endif
ifeq ($(BR2_PACKAGE_PLUGIN_OPENCDMSERVER),y)
EXTERN_SUBSYSTEM += Decryption
endif
ifeq ($(BR2_PACKAGE_PLUGIN_WEBSERVER),y)
EXTERN_SUBSYSTEM += WebSource
endif

BRIDGE_CONF_OPTS += -DEXTERN_SUBSYSTEMS="${EXTERN_SUBSYSTEM}"

ifneq ($(BR2_PACKAGE_BRIDGE_DISABLE_INITD),y)
    BRIDGE_POST_INSTALL_TARGET_HOOKS += BRIDGE_POST_TARGET_INITD
endif

BRIDGE_POST_INSTALL_STAGING_HOOKS += BRIDGE_POST_STAGING_CDM_HEADER
BRIDGE_POST_INSTALL_TARGET_HOOKS += BRIDGE_POST_TARGET_REMOVE_STAGING_ARTIFACTS

$(eval $(cmake-package))
