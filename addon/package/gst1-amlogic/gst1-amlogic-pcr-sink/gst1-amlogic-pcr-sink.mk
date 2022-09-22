################################################################################
#
# gst1-amlogic-pcr-sink
#
################################################################################
GST1_AMLOGIC_PCR_SINK_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/linux/multimedia/gstreamer_plugin_pcr_sink
GST1_AMLOGIC_PCR_SINK_VERSION = stable2
GST1_AMLOGIC_PCR_SINK_SITE_METHOD = git
GST1_AMLOGIC_PCR_SINK_LICENSE = PROPRIETARY
GST1_AMLOGIC_PCR_SINK_INSTALL_STAGING = YES
GST1_AMLOGIC_PCR_SINK_DEPENDENCIES = gstreamer1 gst1-plugins-base aml-avsync
GST1_AMLOGIC_PCR_SINK_AUTORECONF = YES

$(eval $(autotools-package))
