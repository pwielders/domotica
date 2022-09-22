################################################################################
#
# gst1-amlogic-plugins
#
################################################################################
GST1_AMLOGIC_PLUGINS_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/linux/multimedia/gstreamer_plugin
GST1_AMLOGIC_PLUGINS_VERSION = stable2
GST1_AMLOGIC_PLUGINS_SITE_METHOD = git
GST1_AMLOGIC_PLUGINS_LICENSE = PROPRIETARY
GST1_AMLOGIC_PLUGINS_INSTALL_STAGING = YES
GST1_AMLOGIC_PLUGINS_DEPENDENCIES = gstreamer1 gst1-plugins-base host-pkgconf libplayer speexdsp
GST1_AMLOGIC_PLUGINS_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_GST1_AMLOGIC_PLUGINS_AUDIO_HAL_SINK),y)
	GST1_AMLOGIC_PLUGINS_DEPENDENCIES += hal_audio_service
	GST1_AMLOGIC_PLUGINS_CONF_OPTS += --enable-aml-audio-hal-sink
endif

$(eval $(autotools-package))
