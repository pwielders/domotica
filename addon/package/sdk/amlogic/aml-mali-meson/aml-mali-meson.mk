################################################################################
#
# aml-mali-meson
#
################################################################################
AML_MALI_MESON_VERSION = 67d90e57e27f0fc17ac1a49d6d8ca32a9b133240
AML_MALI_MESON_SITE = git@github.com:Metrological/amlogic-mali-userspace.git
AML_MALI_MESON_SITE_METHOD = git
AML_MALI_MESON_LICENSE = CLOSED
AML_MALI_MESON_INSTALL_STAGING = YES
AML_MALI_MESON_INSTALL_TARGET = YES
AML_MALI_MESON_DEPENDENCIES = libdrm wayland linux

define AML_MALI_MESON_FIX_LIBDRM_INCLUDE
    ln -sf libdrm/drm_fourcc.h $(1)/usr/include/drm_fourcc.h
    ln -sf libdrm/drm.h $(1)/usr/include/drm.h
    ln -sf libdrm/drm_mode.h $(1)/usr/include/drm_mode.h
endef

define AML_MALI_MESON_MODULE_LOAD_INIT_INSTALL
    $(INSTALL) -m 755 -d $(1)/etc/init.d/
    $(INSTALL) -m 755 $(@D)/init/modules $(1)/etc/init.d/S09modules
endef

###############################################################################
# Mali driver
###############################################################################
define AML_MALI_MESON_INSTALL_MALI_LIB
    cp -af $(@D)/meson_mali/lib/eabihf/dvalin/r25p0/wayland/drm/libMali_rdk.so $(1)/usr/lib/libMali.so

    patchelf --set-soname libMali.so  $(1)/usr/lib/libMali.so

    ln -sf libMali.so $(1)/usr/lib/libEGL.so.1.4.0
    ln -sf libEGL.so.1.4.0 $(1)/usr/lib/libEGL.so.1
    ln -sf libEGL.so.1 $(1)/usr/lib/libEGL.so

    ln -sf libMali.so $(1)/usr/lib/libGLESv1_CM.so.1.1.0
    ln -sf libGLESv1_CM.so.1.1.0 $(1)/usr/lib/libGLESv1_CM.so.1
    ln -sf libGLESv1_CM.so.1 $(1)/usr/lib/libGLESv1_CM.so

    ln -sf libMali.so $(1)/usr/lib/libGLESv2.so.2.1.0
    ln -sf libGLESv2.so.2.1.0 $(1)/usr/lib/libGLESv2.so.2
    ln -sf libGLESv2.so.2 $(1)/usr/lib/libGLESv2.so

    ln -sf libMali.so $(1)/usr/lib/libwayland-egl.so.1.0.0
    ln -sf libwayland-egl.so.1.0.0 $(1)/usr/lib/libwayland-egl.so.1
    ln -sf libwayland-egl.so.1 $(1)/usr/lib/libwayland-egl.so

    ln -sf libMali.so $(1)/usr/lib/libvulkan.so.1.0.0
    ln -sf libvulkan.so.1.0.0 $(1)/usr/lib/libvulkan.so.1
    ln -sf libvulkan.so.1 $(1)/usr/lib/libvulkan.so

    ln -sf libMali.so $(1)/usr/lib/libgbm.so.1.0.0
    ln -sf libgbm.so.1.0.0 $(1)/usr/lib/libgbm.so.1
    ln -sf libgbm.so.1 $(1)/usr/lib/libgbm.so
endef

define AML_MALI_MESON_INSTALL_MALI_DEV
    $(call AML_MALI_MESON_INSTALL_MALI_LIB,$(1))

    mkdir -p $(1)/usr/include/{EGL,GLES,GLES2,GLES3,KHR}

    cp -af $(@D)/meson_mali/include/EGL/*.h $(1)/usr/include/EGL
    cp -af $(@D)/meson_mali/include/GLES/*.h $(1)/usr/include/GLES
    cp -af $(@D)/meson_mali/include/GLES2/*.h $(1)/usr/include/GLES2
    cp -af $(@D)/meson_mali/include/GLES3/*.h $(1)/usr/include/GLES3
    cp -af $(@D)/meson_mali/include/KHR/*.h $(1)/usr/include/KHR

    cp -af $(@D)/meson_mali/include/EGL_platform/platform_wayland/*.h $(1)/usr/include/EGL
    cp -af $(@D)/meson_mali/include/EGL_platform/platform_wayland/gbm/gbm.h $(1)/usr/include
    cp -af $(@D)/meson_mali/include/EGL_platform/platform_wayland/weston-egl-ext.h $(1)/usr/include

    cp -af $(@D)/meson_mali/lib/pkgconfig/*.pc $(1)/usr/lib/pkgconfig/
    cp -af $(@D)/meson_mali/lib/pkgconfig/gbm/*.pc $(1)/usr/lib/pkgconfig/

    cp -af $(@D)/gles3_fix/gl3ext.h $(1)/usr/include/GLES3
endef

define AML_MALI_MESON_APPLY_MALI_FIXES
    $(call AML_MALI_MESON_APPLY_PATCH,$(@D)/meson_mali,$(@D)/gles3_fix,0001-RDK-Just-for-RDK-build-1-1.patch)
endef
AML_MALI_MESON_PRE_CONFIGURE_HOOKS +=  AML_MALI_MESON_APPLY_MALI_FIXES

###############################################################################
# Generic BR targets
###############################################################################

define AML_MALI_MESON_INSTALL_STAGING_CMDS
    $(call AML_MALI_MESON_FIX_LIBDRM_INCLUDE,$(STAGING_DIR))
    $(call AML_MALI_MESON_INSTALL_MALI_DEV,$(STAGING_DIR))
endef

define AML_MALI_MESON_INSTALL_TARGET_CMDS
    $(call AML_MALI_MESON_INSTALL_MALI_LIB,$(TARGET_DIR))
endef

$(eval $(generic-package))

