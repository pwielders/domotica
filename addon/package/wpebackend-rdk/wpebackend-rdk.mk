################################################################################
#
# wpebackend-rdk
#
################################################################################

WPEBACKEND_RDK_VERSION = 495d11b9dadb21b00d3cadfd9c0fb3df40a9255e
WPEBACKEND_RDK_SITE = $(call github,WebPlatformForEmbedded,WPEBackend-rdk,$(WPEBACKEND_RDK_VERSION))
WPEBACKEND_RDK_INSTALL_STAGING = YES
WPEBACKEND_RDK_DEPENDENCIES = wpebackend libglib2

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON),y)
    WPEBACKEND_RDK_DEPENDENCIES += libxkbcommon xkeyboard-config
endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_BACK_BCM_NEXUS),y)
WPEBACKEND_RDK_DEPENDENCIES += nexus
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_BCM_NEXUS=ON
else
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_BCM_NEXUS=OFF
endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_BACK_BCM_NEXUS_WAYLAND),y)
WPEBACKEND_RDK_DEPENDENCIES += bcm-weston
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_BCM_NEXUS_WAYLAND=ON
else
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_BCM_NEXUS_WAYLAND=OFF
    endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_BACK_BCM_RPI),y)
WPEBACKEND_RDK_DEPENDENCIES += libegl
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_BCM_RPI=ON
else
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_BCM_RPI=OFF
    endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_BACK_INTEL_CE),y)
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_INTEL_CE=ON
else
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_INTEL_CE=OFF
    endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_BACK_WAYLAND_EGL),y)
WPEBACKEND_RDK_DEPENDENCIES += libegl wayland
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_WAYLAND_EGL=ON
else
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_WAYLAND_EGL=OFF
endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_BACK_WESTEROS),y)
WPEBACKEND_RDK_DEPENDENCIES += westeros
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_WESTEROS=ON
        else
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_WESTEROS=OFF
        endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_BACK_WPEFRAMEWORK),y)
WPEBACKEND_RDK_DEPENDENCIES += wpeframework wpeframework-clientlibraries
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_WPEFRAMEWORK=ON
else
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_WPEFRAMEWORK=OFF
endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_BACK_BRIDGE),y)
WPEBACKEND_RDK_DEPENDENCIES += bridge bridge-clients
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_WPEFRAMEWORK=ON
else
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_WPEFRAMEWORK=OFF
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CLIENTLIBRARY_COMPOSITORCLIENT)$(BR2_PACKAGE_RPI_USERLAND),yy)
WPEBACKEND_RDK_CONF_OPTS += -DUSE_HOLE_PUNCH_GSTREAMER=OFF
endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_INPUT_VIRTUALKBD),y)

WPEBACKEND_RDK_CONF_OPTS += -DUSE_VIRTUAL_KEYBOARD=ON
ifeq ($(BR2_PACKAGE_GLUELOGIC_VIRTUAL_KEYBOARD),y)
WPEBACKEND_RDK_DEPENDENCIES += gluelogic
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)
WPEBACKEND_RDK_CONF_OPTS += -DUSE_INPUT_LIBINPUT=OFF
WPEBACKEND_RDK_DEPENDENCIES += wpeframework
endif

ifeq ($(BR2_PACKAGE_BRIDGE_VIRTUALINPUT),y)
WPEBACKEND_RDK_CONF_OPTS += -DUSE_INPUT_LIBINPUT=OFF
WPEBACKEND_RDK_DEPENDENCIES += bridge bridge-clientlibraries
endif


else

ifeq ($(BR2_PACKAGE_LIBINPUT),y)
WPEBACKEND_RDK_DEPENDENCIES += libinput
WPEBACKEND_RDK_CONF_OPTS += -DUSE_INPUT_LIBINPUT=ON
else
WPEBACKEND_RDK_CONF_OPTS += -DUSE_INPUT_LIBINPUT=OFF
    endif

    endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_ADDITIONAL_PATCHES)x,yx)
WPEBACKEND_RDK_POST_PATCH_HOOKS += WPEBACKEND_RDK_PATCHES
define WPEBACKEND_RDK_PATCHES
	patch -d $(@D)/ -p1 < package/wpe/wpebackend-rdk/0001-restore-communication-loop.patch.additional
endef
endif

$(eval $(cmake-package))
