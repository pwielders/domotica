################################################################################
#
# gyp
#
################################################################################

GYP_VERSION = 9d09418933ea2f75cc416e5ce38d15f62acd5c9a
GYP_SITE_METHOD = git
GYP_SITE = https://chromium.googlesource.com/external/gyp
GYP_INSTALL_STAGING = NO
GYP_SETUP_TYPE = setuptools
GYP_DEPENDENCIES = host-gyp 
HOST_GYP_DEPENDENCIES = host-python3

define HOST_GYP_CONFIGURE_CMDS
	(cd $(@D); rm -rf build)
endef

define HOST_GYP_BUILD_CMDS
	$(HOST_MAKE_ENV) PYTHON=$(HOST_DIR)/usr/bin/python3;
	cd $(@D);$(PYTHON) ./setup.py build;
endef

define HOST_GYP_INSTALL_CMDS
        $(HOST_MAKE_ENV) PYTHON=$(HOST_DIR)/usr/bin/python3;
        cd $(@D);$(PYTHON) ./setup.py install;
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
