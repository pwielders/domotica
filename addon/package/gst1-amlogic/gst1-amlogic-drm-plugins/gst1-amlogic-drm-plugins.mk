################################################################################
#
# gst1-amlogic-drm-plugins
#
################################################################################
GST1_AMLOGIC_DRM_PLUGINS_SITE = ssh://gerrit.teamccp.com:29418/rdk/components/sdk/soc/amlogic/linux/multimedia/gstreamer_plugin_drm
GST1_AMLOGIC_DRM_PLUGINS_VERSION = stable2
GST1_AMLOGIC_DRM_PLUGINS_SITE_METHOD = git
GST1_AMLOGIC_DRM_PLUGINS_LICENSE = PROPRIETARY
GST1_AMLOGIC_DRM_PLUGINS_INSTALL_STAGING = YES
GST1_AMLOGIC_DRM_PLUGINS_DEPENDENCIES = gstreamer1 gst1-plugins-base host-pkgconf
GST1_AMLOGIC_DRM_PLUGINS_AUTORECONF = YES

$(eval $(autotools-package))
