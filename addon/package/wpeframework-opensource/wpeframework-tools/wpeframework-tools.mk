################################################################################
#
# wpeframework-tools
#
################################################################################
WPEFRAMEWORK_TOOLS_VERSION = 0c558f735257eab5bded617d6c3e491e988d80f1
HOST_WPEFRAMEWORK_TOOLS_SITE = $(call github,rdkcentral,ThunderTools,$(WPEFRAMEWORK_TOOLS_VERSION))
HOST_WPEFRAMEWORK_TOOLS_INSTALL_STAGING = YES
HOST_WPEFRAMEWORK_TOOLS_INSTALL_TARGET = NO
HOST_WPEFRAMEWORK_TOOLS_DEPENDENCIES = host-cmake host-python3 host-python3-jsonref

ifeq ($(BR2_CMAKE_HOST_DEPENDENCY),)
HOST_WPEFRAMEWORK_TOOLS_CONF_OPTS += \
	-DGENERIC_CMAKE_MODULE_PATH=$(HOST_DIR)/share/cmake/Modules
endif

$(eval $(host-cmake-package))
