################################################################################
#
# platco-tv-bsp
#
################################################################################
AML_MEDIA_DRIVER_VERSION = main
AML_MEDIA_DRIVER_SITE = git@github.com:Metrological/SDK_Platco_TV.git
AML_MEDIA_DRIVER_SITE_METHOD = git
AML_MEDIA_DRIVER_LICENSE = CLOSED
AML_MEDIA_DRIVER_INSTALL_STAGING = YES
AML_MEDIA_DRIVER_INSTALL_TARGET = YES
AML_MEDIA_DRIVER_DEPENDENCIES = libdrm wayland linux

AML_MEDIA_DRIVER_KO_DIR=lib/modules/4.9.113

define AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL
    $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modules-load.d
    echo "${1}" > "${TARGET_DIR}/etc/modules-load.d/${1}.conf"

    if [ ! -z "${2}" ]; then \
        $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modprobe.d ; \
        echo "${2}" > "${TARGET_DIR}/etc/modprobe.d/${1}.conf" ; \
    fi
endef

define AML_MEDIA_DRIVER_APPLY_PATCH
    if [ ! -f "${@D}/.${3}.applied" ]; then ($(APPLY_PATCHES) $(1) $(2) $(3) && touch "${@D}/.${3}.applied"); fi
endef

define AML_MEDIA_DRIVER_MODULE_LOAD_INIT_INSTALL
    $(INSTALL) -m 755 -d $(1)/etc/init.d/
    $(INSTALL) -m 755 $(@D)/init/modules $(1)/etc/init.d/S09modules
endef

###############################################################################
# Media drivers
###############################################################################
AML_MEDIA_DRIVER_MODULE_SUBDIRS += media_modules/drivers
AML_MEDIA_DRIVER_MODULE_MAKE_OPTS += \
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
AML_MEDIA_DRIVER_MODULE_AUTO_LOAD += mali

define AML_MEDIA_DRIVER_INSTALL_VIDEO_FIRMWARE
    $(INSTALL) -m 755 -d $(TARGET_DIR)/lib/firmware/video
    $(INSTALL) -m 644 $(@D)/media_modules/firmware/video_ucode.bin $(TARGET_DIR)/lib/firmware/video
endef
AML_MEDIA_DRIVER_POST_INSTALL_TARGET_HOOKS += AML_MEDIA_DRIVER_INSTALL_VIDEO_FIRMWARE

define AML_MEDIA_DRIVER_INSTALL_MEDIA_MODULES_AUTO_LOAD
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,aml_hardware_dmx)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_av1)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_h264)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_h264mvc)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_h265)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_mh264)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_mjpeg)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_mmjpeg)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_mmpeg4)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_mmpeg12)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_mpeg12)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_ports,options amvdec_ports multiplanar=1 vp9_need_prefix=1 av1_need_prefix=1 force_enable_nr=1 force_enable_di_local_buffer=1)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,amvdec_vp9)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,decoder_common)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,firmware)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,media_clock)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,stream_input)
    $(call AML_MEDIA_DRIVER_AUTO_LOAD_MODULE_INSTALL,mxl661_fe)
endef
AML_MEDIA_DRIVER_POST_INSTALL_TARGET_HOOKS += AML_MEDIA_DRIVER_INSTALL_MEDIA_MODULES_AUTO_LOAD

$(eval $(kernel-module))

