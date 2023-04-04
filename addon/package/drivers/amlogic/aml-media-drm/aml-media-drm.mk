################################################################################
#
# aml-media-drm
#
################################################################################
AML_MEDIA_DRM_SITE = git@github.com:Metrological/amlogic-mediadrm-userspace.git
AML_MEDIA_DRM_VERSION = e1aa101b4acc1790e4b2902d8f3e3e2c1bfd9027
AML_MEDIA_DRM_SITE_METHOD = git
AML_MEDIA_DRM_LICENSE = PROPRIETARY
AML_MEDIA_DRM_INSTALL_STAGING = YES
AML_MEDIA_DRM_DEPENDENCIES = aml-media-hal openssl

AML_MEDIA_DRM_ARM_TARGET="arm.aapcs-linux.hard"
AML_MEDIA_DRM_TA_TARGET="noarch"
AML_MEDIA_DRM_TDK_VERSION="v2.4"

define AML_MEDIA_DRM_BUILD_CMDS
endef

define AML_MEDIA_DRM_INSTALL_STAGING_CMDS
	test -d "${STAGING_DIR}/usr/include" || $(INSTALL) -d -m 755 "${STAGING_DIR}/usr/include"

	$(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_MEDIA_DRM_TA_TARGET}/include/*.h ${STAGING_DIR}/usr/include
	$(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_MEDIA_DRM_ARM_TARGET}/libsecmem.so ${STAGING_DIR}/usr/lib
endef

define AML_MEDIA_DRM_INSTALL_TARGET_CMDS
	test -d "${STAGING_DIR}/lib/teetz" || $(INSTALL) -d -m 755 "${TARGET_DIR}/lib/teetz"

	$(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_MEDIA_DRM_TA_TARGET}/ta/${AML_MEDIA_DRM_TDK_VERSION}/*.ta ${TARGET_DIR}/lib/teetz/
	$(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_MEDIA_DRM_ARM_TARGET}/secmem_test ${TARGET_DIR}/usr/bin
	$(INSTALL) -m 755 $(@D)/libsecmem-bin/prebuilt/${AML_MEDIA_DRM_ARM_TARGET}/libsecmem.so ${TARGET_DIR}/usr/lib
endef

$(eval $(generic-package))
