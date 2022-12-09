################################################################################
#
# Plugins Common
#
################################################################################
PLUGIN_COMMON_VERSION = main
PLUGIN_COMMON_SITE = git@git.integraal.info:domotica/modules.git
PLUGIN_COMMON_SUBDIR = src
PLUGIN_COMMON_SITE_METHOD = git
PLUGIN_COMMON_INSTALL_STAGING = NO 
PLUGIN_COMMON_DEPENDENCIES = bridge bridge-contracts bridge-clients
PLUGIN_COMMON_CONF_OPTS = -DBUILD_REFERENCE=${PLUGIN_COMMON_VERSION}

ifeq ($(BR2_PACKAGE_BRIDGE_DEBUG),y)
PLUGIN_COMMON_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTH),y)
#Prevent switching bluetooth to ttyS0
export BLUETOOTH=1
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTH=ON
ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTH_BAUDRATE_HIGH),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTH_BAUDRATE=921600
else
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTH_BAUDRATE=115200
endif
ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTH_AUTOSTART),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTH_AUTOSTART=true
endif
ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTH_PERSISTMAC),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTH_PERSISTMAC=true
endif
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTH_OOP=false
endif

ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTHREMOTECONTROL),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHREMOTECONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK=ON
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_LATENCY=${BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK_LATENCY}
ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK_CODECSBC), y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_CODECSBC=ON
ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET_LQ),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET=LQ
else ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET_MQ),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET=MQ
else ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET_HQ),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET=HQ
else ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET_XQ),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET=XQ
endif
PLUGIN_COMMON_DEPENDENCIES += sbc
endif
ifeq ($(BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE), y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE=ON
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE_NAME=${BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE_NAME}
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE_DESCRIPTION=${BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE_DESCRIPTION}
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE_PROVIDER=${BR2_PACKAGE_PLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE_PROVIDER}
endif
endif

ifeq ($(BR2_PACKAGE_PLUGIN_COMMANDER),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMMANDER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR=ON
ifeq ($(BR2_PACKAGE_WESTEROS),y)
PLUGIN_DEPENDENCIES += westeros
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Wayland
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_SUB_IMPLEMENTATION=Westeros
else ifeq  ($(BR2_PACKAGE_BCM_REFSW),y)
PLUGIN_DEPENDENCIES += bcm-refsw
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Nexus
else ifeq  ($(BR2_PACKAGE_HAS_NEXUS),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Nexus
else ifeq  ($(BR2_PACKAGE_RPI_FIRMWARE),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=RPI
else
$(error Missing a compositor implemtation, please provide one or disable PLUGIN_COMPOSITOR)
endif
ifeq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR_OUTOFPROCESS),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_OUTOFPROCESS=true
else
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_OUTOFPROCESS=false
endif
ifeq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR_AUTOSTART),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_AUTOSTART=true
else
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_AUTOSTART=false
endif
ifeq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR_NEXUS_SERVER),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_NXSERVER=ON
ifneq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR_IRMODE),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_IRMODE="$(call qstrip,$(BR2_PACKAGE_PLUGIN_COMPOSITOR_IRMODE))"
endif
ifneq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR_BOXMODE),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_BOXMODE="$(call qstrip,$(BR2_PACKAGE_PLUGIN_COMPOSITOR_BOXMODE))"
endif
ifneq ($(BR2_PACKAGE_BCM_REFSW_SAGE_PATH),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_SAGE_PATH="$(call qstrip,$(BR2_PACKAGE_BCM_REFSW_SAGE_PATH))"
endif
ifeq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR_SVP_NONE),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_SVP="None"
else ifeq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR_SVP_VIDEO),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_SVP="Video"
else ifeq ($(BR2_PACKAGE_PLUGIN_COMPOSITOR_SVP_ALL),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_SVP="All"
endif

ifneq ($(BR2_PACKAGE_COMPOSITOR_MEMORY_GFX),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_GFX="$(call qstrip,$(BR2_PACKAGE_COMPOSITOR_MEMORY_GFX))"
endif
ifneq ($(BR2_PACKAGE_COMPOSITOR_MEMORY_GFX2),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_GFX2="$(call qstrip,$(BR2_PACKAGE_COMPOSITOR_MEMORY_GFX2))"
endif
ifneq ($(BR2_PACKAGE_COMPOSITOR_MEMORY_RESTRICTED),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_RESTRICTED="$(call qstrip,$(BR2_PACKAGE_COMPOSITOR_MEMORY_RESTRICTED))"
endif
ifneq ($(BR2_PACKAGE_COMPOSITOR_MEMORY_MAIN),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_MAIN="$(call qstrip,$(BR2_PACKAGE_COMPOSITOR_MEMORY_MAIN))"
endif
ifneq ($(BR2_PACKAGE_COMPOSITOR_MEMORY_EXPORT),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_EXPORT="$(call qstrip,$(BR2_PACKAGE_COMPOSITOR_MEMORY_EXPORT))"
endif
ifneq ($(BR2_PACKAGE_COMPOSITOR_MEMORY_SECUREGFX),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_SECUREGFX="$(call qstrip,$(BR2_PACKAGE_COMPOSITOR_MEMORY_SECUREGFX))"
endif
ifneq ($(BR2_PACKAGE_COMPOSITOR_MEMORY_CLIENT),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_CLIENT="$(call qstrip,$(BR2_PACKAGE_COMPOSITOR_MEMORY_CLIENT))"
endif

ifeq ($(BR2_PACKAGE_COMPOSITOR_ALLOW_UNAUTHENTICATED_CLIENTS),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_ALLOW_UNAUTHENTICATED_CLIENTS=false
else
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_ALLOW_UNAUTHENTICATED_CLIENTS=true
endif
endif
endif

ifeq ($(BR2_PACKAGE_VIRTUALINPUT),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_COMPOSITOR_VIRTUALINPUT=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_DEVICEINFO),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_DEVICEINFO=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_DHCPSERVER),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_DHCPSERVER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_DISPLAYINFO),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_DISPLAYINFO=ON
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_DISPLAYINFO_INPROCESS=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_EGLTEST),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_EGLTEST=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_LAUNCHER),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_LAUNCHER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_LOCATIONSYNC),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_LOCATIONSYNC=ON
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_LOCATIONSYNC_URI=${BR2_PACKAGE_PLUGIN_LOCATIONSYNC_URI}
endif

ifeq ($(BR2_PACKAGE_PLUGIN_MONITOR),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_MONITOR=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_NETWORKCONTROL),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_NETWORKCONTROL=ON
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_NETWORKCONTROL_INTERFACES='$(call qstrip,$(BR2_PACKAGE_PLUGIN_NETWORKCONTROL_INTERFACES))'
endif

ifeq ($(BR2_PACKAGE_PLUGIN_OPENCDMSERVER),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMSERVER=ON
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_AUTOSTART=true
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_OOP=true
ifneq ($(BR2_PACKAGE_CDMI_USER),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_USER=$(BR2_PACKAGE_CDMI_USER)
endif
ifneq ($(BR2_PACKAGE_CDMI_GROUP),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_GROUP=$(BR2_PACKAGE_CDMI_GROUP)
endif
ifeq ($(BR2_PACKAGE_CDMI_CLEARKEY),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_CLEARKEY=ON
PLUGIN_COMMON_DEPENDENCIES += cdmi-clearkey
endif
ifeq ($(BR2_PACKAGE_CDMI_PLAYREADY),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY=ON
PLUGIN_COMMON_DEPENDENCIES += cdmi-playready
endif
ifeq ($(BR2_PACKAGE_CDMI_PLAYREADY_NEXUS),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY_NEXUS=ON
PLUGIN_COMMON_DEPENDENCIES += cdmi-playready-nexus
endif
ifeq ($(BR2_PACKAGE_CDMI_PLAYREADY_NEXUS_SVP),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY_NEXUS=ON
PLUGIN_COMMON_DEPENDENCIES += cdmi-playready-nexus-svp
endif
ifeq ($(BR2_PACKAGE_CDMI_PLAYREADY_VGDRM),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY_VGDRM=ON
PLUGIN_COMMON_DEPENDENCIES += cdmi-playready-vgdrm
endif
ifeq ($(BR2_PACKAGE_CDMI_WIDEVINE),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_WIDEVINE=ON
PLUGIN_COMMON_DEPENDENCIES += cdmi-widevine
endif
ifeq ($(BR2_PACKAGE_CDMI_NAGRA),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_OPENCDMI_NAGRA=ON
PLUGIN_COMMON_DEPENDENCIES += cdmi-nagra
endif

endif

ifeq ($(BR2_PACKAGE_PLUGIN_PLAYERINFO),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_PLAYERINFO=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_REMOTECONTROL),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_REMOTECONTROL=ON
ifeq ($(BR2_PACKAGE_PLUGIN_REMOTECONTROL_IR),y)
ifeq ($(BR2_PACKAGE_PLUGIN_REMOTECONTROL_IRNEXUS),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_REMOTECONTROL_IRNEXUS=ON
ifneq ($(BR2_PACKAGE_PLUGIN_REMOTECONTROL_IRNEXUS_MODE),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_REMOTECONTROL_IRMODE="$(call qstrip,$(BR2_PACKAGE_PLUGIN_REMOTECONTROL_IRNEXUS_MODE))"
endif
ifneq ($(BR2_PACKAGE_PLUGIN_REMOTECONTROL_IRNEXUS_CODEMASK),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_REMOTECONTROL_CODEMASK="$(call qstrip,$(BR2_PACKAGE_PLUGIN_REMOTECONTROL_IRNEXUS_CODEMASK))"
endif
endif
endif
ifeq ($(BR2_PACKAGE_PLUGIN_REMOTECONTROL_RF),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_REMOTECONTROL_RF=ON
endif
ifneq ($(BR2_TARGET_GENERIC_HOSTNAME),"buildroot")
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_REMOTECONTROL_HOST="$(call qstrip,$(BR2_TARGET_GENERIC_HOSTNAME))"
endif
endif

ifeq ($(BR2_PACKAGE_PLUGIN_SNAPSHOT),y)
PLUGIN_COMMON_DEPENDENCIES += libpng
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_SNAPSHOT=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_TIMESYNC),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_TIMESYNC=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_TRACECONTROL),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_TRACECONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_MESSAGECONTROL),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_MESSAGECONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER),y)
ifeq ($(BR2_PACKAGE_WPEWEBKIT),y)
PLUGIN_COMMON_DEPENDENCIES += wpewebkit
else 
PLUGIN_COMMON_DEPENDENCIES += wpewebkit-ml
endif
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER=ON
ifeq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_AUTOSTART),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_AUTOSTART=true
else
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_AUTOSTART=false
endif
ifneq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_STARTURL),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_STARTURL=$(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_STARTURL)
endif
ifneq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_USERAGENT),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_USERAGENT=$(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_USERAGENT)
endif
ifneq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_MEMORYPROFILE),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_MEMORYPROFILE=$(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_MEMORYPROFILE)
endif
ifneq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_MEMORYPRESSURE),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_MEMORYPRESSURE=$(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_MEMORYPRESSURE)
endif
ifeq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_MEDIADISKCACHE),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_MEDIADISKCACHE=true
endif
ifneq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_DISKCACHE),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_DISKCACHE=$(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_DISKCACHE)
endif
ifeq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_XHRCACHE),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_XHRCACHE=false
endif
ifeq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER_TRANSPARENT),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_TRANSPARENT=true
else
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_TRANSPARENT=false
endif
ifeq ($(BR2_PACKAGE_PLUGIN_YOUTUBE),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_YOUTUBE=ON
endif
endif

ifeq ($(BR2_PACKAGE_PLUGIN_WEBPROXY),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBPROXY=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_WEBSERVER),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSERVER=ON
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSERVER_AUTOSTART=true
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSERVER_PATH=$(BR2_PACKAGE_PLUGIN_WEBSERVER_PATH)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSERVER_PORT=$(BR2_PACKAGE_PLUGIN_WEBSERVER_PORT)

PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSERVER_USER=www-data
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSERVER_GROUP=www-data
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSERVER_MODE=Off

ifeq ($(BR2_PACKAGE_BRIDGE_PORT),)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSERVER_BRIDGE_PORT=80
else
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSERVER_BRIDGE_PORT=$(BR2_PACKAGE_BRIDGE_PORT)
endif

ifeq ($(BR2_PACKAGE_PLUGIN_DIALSERVER),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_DIALSERVER=ON
endif
endif

ifeq ($(BR2_PACKAGE_PLUGIN_WEBSHELL),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSHELL=ON
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WEBSHELL_AUTOSTART=false
endif

ifeq ($(BR2_PACKAGE_PLUGIN_WIFI),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_WIFICONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_TUNER),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_TUNER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_RPCLINK),y)
PLUGIN_COMMON_CONF_OPTS += -DPLUGIN_RPCLINK=ON
endif

$(eval $(cmake-package))