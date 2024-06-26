################################################################################
#
# wpeframework-libraries
#
################################################################################
WPEFRAMEWORK_LIBRARIES_VERSION = b623aa7078c2d1016f613986c1ba14282765eae4
WPEFRAMEWORK_LIBRARIES_SITE_METHOD = git
WPEFRAMEWORK_LIBRARIES_SITE = git@github.com:WebPlatformForEmbedded/ThunderLibraries.git
WPEFRAMEWORK_LIBRARIES_INSTALL_STAGING = YES
WPEFRAMEWORK_LIBRARIES_DEPENDENCIES = wpeframework

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CLIENTLIBRARY_BROADCAST),y)
WPEFRAMEWORK_LIBRARIES_CONF_OPTS += -DBROADCAST=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BROADCAST_SI_PARSING),y)
WPEFRAMEWORK_LIBRARIES_CONF_OPTS += -DBROADCAST_SI_PARSING=ON
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTH),y)
WPEFRAMEWORK_LIBRARIES_CONF_OPTS += -DBLUETOOTH=ON
WPEFRAMEWORK_LIBRARIES_DEPENDENCIES += bluez5_utils-headers

ifneq (,$(filter y,$(BR2_PACKAGE_RPI_BT_FIRMWARE)$(BR2_PACKAGE_BRCMFMAC_SDIO_FIRMWARE_RPI_BT)))
WPEFRAMEWORK_LIBRARIES_CONF_OPTS += -DBCM43XX=ON
endif
endif

$(eval $(cmake-package))
