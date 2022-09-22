################################################################################
#
# platco-tv-bsp
#
################################################################################
PLATCO_TV_BSP_VERSION = main
PLATCO_TV_BSP_SITE = git@github.com:Metrological/SDK_Platco_TV.git
PLATCO_TV_BSP_SITE_METHOD = git
PLATCO_TV_BSP_LICENSE = CLOSED
PLATCO_TV_BSP_INSTALL_STAGING = YES
PLATCO_TV_BSP_INSTALL_TARGET = YES
PLATCO_TV_BSP_DEPENDENCIES = libdrm wayland linux

PLATCO_TV_BSP_KO_DIR=lib/modules/4.9.113

define PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL
    $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modules-load.d
    echo "${1}" > "${TARGET_DIR}/etc/modules-load.d/${1}.conf"

    if [ ! -z "${2}" ]; then \
        $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modprobe.d ; \
        echo "${2}" > "${TARGET_DIR}/etc/modprobe.d/${1}.conf" ; \
    fi
endef

define PLATCO_TV_BSP_APPLY_PATCH
    if [ ! -f "${@D}/.${3}.applied" ]; then ($(APPLY_PATCHES) $(1) $(2) $(3) && touch "${@D}/.${3}.applied"); fi
endef

define PLATCO_TV_BSP_FIX_LIBDRM_INCLUDE
    ln -sf libdrm/drm_fourcc.h $(1)/usr/include/drm_fourcc.h
    ln -sf libdrm/drm.h $(1)/usr/include/drm.h
    ln -sf libdrm/drm_mode.h $(1)/usr/include/drm_mode.h
endef

define PLATCO_TV_BSP_MODULE_LOAD_INIT_INSTALL
    $(INSTALL) -m 755 -d $(1)/etc/init.d/
    $(INSTALL) -m 755 $(@D)/init/modules $(1)/etc/init.d/S09modules
endef

###############################################################################
# Mali driver
###############################################################################
define PLATCO_TV_BSP_INSTALL_MALI_LIB
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

define PLATCO_TV_BSP_INSTALL_MALI_DEV
    $(call PLATCO_TV_BSP_INSTALL_MALI_LIB,$(1))

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

define PLATCO_TV_BSP_APPLY_MALI_FIXES
    $(call PLATCO_TV_BSP_APPLY_PATCH,$(@D)/meson_mali,$(@D)/gles3_fix,0001-RDK-Just-for-RDK-build-1-1.patch)
endef
PLATCO_TV_BSP_PRE_CONFIGURE_HOOKS +=  PLATCO_TV_BSP_APPLY_MALI_FIXES

PLATCO_TV_BSP_MODULE_SUBDIRS += mali_driver/bifrost/r25p0/kernel/drivers/gpu/arm/midgard
PLATCO_TV_BSP_MODULE_MAKE_OPTS += \
	CONFIG_MALI_MIDGARD=m \
	CONFIG_MALI_PLATFORM_DEVICETREE=y \
	CONFIG_MALI_MIDGARD_DVFS=y \
	CONFIG_MALI_BACKEND=gpu

###############################################################################
# Media drivers
###############################################################################
PLATCO_TV_BSP_MODULE_SUBDIRS += media_modules/drivers
PLATCO_TV_BSP_MODULE_MAKE_OPTS += \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG12=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG2_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG4=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG4_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_VC1=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H264=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H264_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H264_MVC=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H265=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_VP9=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MJPEG=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MJPEG_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_REAL=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AVS=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AVS2=m \
    CONFIG_AMLOGIC_MEDIA_VENC_H264=m \
    CONFIG_AMLOGIC_MEDIA_VENC_H265=m \
    CONFIG_AMLOGIC_MEDIA_ENHANCEMENT_DOLBYVISION=y \
    CONFIG_AMLOGIC_MEDIA_GE2D=y \
    CONFIG_AMLOGIC_MEDIA_VDEC_AV1=m
PLATCO_TV_BSP_MODULE_AUTO_LOAD += mali

define PLATCO_TV_BSP_INSTALL_VIDEO_FIRMWARE
    $(INSTALL) -m 755 -d $(TARGET_DIR)/lib/firmware/video
    $(INSTALL) -m 644 $(@D)/media_modules/firmware/video_ucode.bin $(TARGET_DIR)/lib/firmware/video
endef
PLATCO_TV_BSP_POST_INSTALL_TARGET_HOOKS += PLATCO_TV_BSP_INSTALL_VIDEO_FIRMWARE

define PLATCO_TV_BSP_INSTALL_MEDIA_MODULES_AUTO_LOAD
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,aml_hardware_dmx)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_av1)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_h264)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_h264mvc)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_h265)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_mh264)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_mjpeg)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_mmjpeg)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_mmpeg4)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_mmpeg12)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_mpeg12)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_ports,options amvdec_ports multiplanar=1 vp9_need_prefix=1 av1_need_prefix=1 force_enable_nr=1 force_enable_di_local_buffer=1)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,amvdec_vp9)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,decoder_common)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,firmware)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,media_clock)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,stream_input)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,mxl661_fe)
endef
PLATCO_TV_BSP_POST_INSTALL_TARGET_HOOKS += PLATCO_TV_BSP_INSTALL_MEDIA_MODULES_AUTO_LOAD

###############################################################################
# WiFi driver
###############################################################################
define PLATCO_TV_BSP_WIFI_TOOL_BUILD_CMD
    $(MAKE) -C $(@D)/sky_tools/utils wifi_power
endef

define PLATCO_TV_BSP_WIFI_TOOL_INSTALL
    $(INSTALL) -m 755 -d $(1)/usr/bin
    $(INSTALL) -m 755 $(@D)/sky_tools/utils/wifi_power $(1)/usr/bin
endef

define PLATCO_TV_BSP_WIFI_INIT_INSTALL
    $(INSTALL) -m 755 -d $(1)/etc/init.d
    $(INSTALL) -m 755 $(@D)/init/wifidriver $(1)/etc/init.d/S31wifi
endef

PLATCO_TV_BSP_MODULE_SUBDIRS += wifi_qca6174/AIO/drivers/qcacld-new
PLATCO_TV_BSP_MODULE_MAKE_OPTS += \
    WLAN_ROOT="$(@D)/wifi_qca6174/AIO/drivers/qcacld-new" \
    CONFIG_QCA_WIFI_ISOC=0 \
    CONFIG_QCA_WIFI_2_0=1 \
    CONFIG_QCA_CLD_WLAN=m \
    WLAN_OPEN_SOURCE=1 \
    CONFIG_CLD_HL_SDIO_CORE=y \
    CONFIG_LINUX_QCMBR=y

define PLATCO_TV_BSP_INSTALL_WIFI_FIRMWARE
    $(INSTALL) -m 755 -d $(TARGET_DIR)/lib/firmware/
    $(INSTALL) -m 644 $(@D)/wifi_firmware/* $(TARGET_DIR)/lib/firmware/
endef
PLATCO_TV_BSP_POST_INSTALL_TARGET_HOOKS += PLATCO_TV_BSP_INSTALL_WIFI_FIRMWARE

###############################################################################
# PQ driver
###############################################################################
define PLATCO_TV_BSP_PREBUILD_PQ_MODULE_INSTALL
    $(INSTALL) -m 755 -d $(TARGET_DIR)/$(PLATCO_TV_BSP_KO_DIR)/kernel/pq
    $(INSTALL) -m 644 $(@D)/pq_prebuild/kernel-module/pq/*.ko $(TARGET_DIR)/$(PLATCO_TV_BSP_KO_DIR)/kernel/pq/
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,dnlp_alg_32)
endef
PLATCO_TV_BSP_POST_INSTALL_TARGET_HOOKS += PLATCO_TV_BSP_PREBUILD_PQ_MODULE_INSTALL

###############################################################################
# OPTEE driver
###############################################################################
LINUX_MAKE_ENV += KERNEL_A32_SUPPORT=true

PLATCO_TV_BSP_MODULE_SUBDIRS += optee-linux-driver/linuxdriver

define PLATCO_TV_BSP_OPTEE_MODULES_AUTO_LOAD
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,optee)
    $(call PLATCO_TV_BSP_AUTO_LOAD_MODULE_INSTALL,optee_armtz)
endef
PLATCO_TV_BSP_POST_INSTALL_TARGET_HOOKS += PLATCO_TV_BSP_OPTEE_MODULES_AUTO_LOAD


###############################################################################
# Generic BR targets
###############################################################################
define PLATCO_TV_BSP_BUILD_CMDS
    $(call PLATCO_TV_BSP_WIFI_TOOL_BUILD_CMD)
    $(call PLATCO_TV_BSP_LINUX_FUSION_COMPILE)
endef

define PLATCO_TV_BSP_INSTALL_STAGING_CMDS
    $(call PLATCO_TV_BSP_FIX_LIBDRM_INCLUDE,$(STAGING_DIR))
    $(call PLATCO_TV_BSP_INSTALL_MALI_DEV,$(STAGING_DIR))
endef

define PLATCO_TV_BSP_INSTALL_TARGET_CMDS
    $(call PLATCO_TV_BSP_INSTALL_MALI_LIB,$(TARGET_DIR))
    $(call PLATCO_TV_BSP_WIFI_INIT_INSTALL,$(TARGET_DIR))
    $(call PLATCO_TV_BSP_MODULE_LOAD_INIT_INSTALL,$(TARGET_DIR))
    $(call PLATCO_TV_BSP_WIFI_TOOL_INSTALL,$(TARGET_DIR))
endef

$(eval $(generic-package))
$(eval $(kernel-module))

