################################################################################
#
# wpeframework-screensaver
#
################################################################################
WPEFRAMEWORK_SCREENSAVER_VERSION = 04ae0fa60ddd1dcf5ed91496490322c2cc63264a
WPEFRAMEWORK_SCREENSAVER_SITE = $(call github,Metrological,ThunderScreensaver,$(WPEFRAMEWORK_SCREENSAVER_VERSION))
WPEFRAMEWORK_SCREENSAVER_INSTALL_STAGING = NO
WPEFRAMEWORK_SCREENSAVER_DEPENDENCIES = wpeframework-clientlibraries

WPEFRAMEWORK_SCREENSAVER_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_SCREENSAVER_VERSION}
WPEFRAMEWORK_SCREENSAVER_CONF_OPTS += -DLEGACY_CONFIG_GENERATOR=OFF

ifeq ($(BR2_CMAKE_HOST_DEPENDENCY),)
WPEFRAMEWORK_SCREENSAVER_CONF_OPTS += \
       -DCMAKE_MODULE_PATH=$(HOST_DIR)/share/cmake/Modules
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SCREENSAVER_AUTOSTART),y)
WPEFRAMEWORK_SCREENSAVER_CONF_OPTS += -DPLUGIN_SCREENSAVER_AUTOSTART=true
else
WPEFRAMEWORK_SCREENSAVER_CONF_OPTS += -DPLUGIN_SCREENSAVER_AUTOSTART=false
endif

$(eval $(cmake-package))
