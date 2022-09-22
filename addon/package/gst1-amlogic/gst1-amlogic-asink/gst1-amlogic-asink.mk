################################################################################
#
# gst1-amlogic-asink
#
################################################################################
GST1_AMLOGIC_ASINK_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/linux/multimedia/gstreamer_plugin_asink
GST1_AMLOGIC_ASINK_VERSION = stable2
GST1_AMLOGIC_ASINK_SITE_METHOD = git
GST1_AMLOGIC_ASINK_LICENSE = PROPRIETARY
GST1_AMLOGIC_ASINK_INSTALL_STAGING = YES
GST1_AMLOGIC_ASINK_DEPENDENCIES = gstreamer1 gst1-plugins-base gst1-plugins-bad aml-avsync aml-audio-service
GST1_AMLOGIC_ASINK_AUTORECONF = YES

#TODO: enable support for audio description but I have no clue who supplies
#      the needed libgstpesmeta.so

GST1_AMLOGIC_ASINK_CONF_OPTS = \
	--enable-xrun-detection=yes \
	--enable-ms12=yes \
	--enable-essos-rm=no \
	--enable-ad=no

$(eval $(autotools-package))
