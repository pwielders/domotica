################################################################################
#
# westeros-simpleshell
#
################################################################################

WESTEROS_SIMPLESHELL_VERSION = 380015778c45e7f26406f22a063bd259a7dece46
WESTEROS_SIMPLESHELL_SITE_METHOD = git
WESTEROS_SIMPLESHELL_SITE = https://github.com/rdkcmf/westeros
WESTEROS_SIMPLESHELL_INSTALL_STAGING = YES
WESTEROS_SIMPLESHELL_SUBDIR = simpleshell/
WESTEROS_SIMPLESHELL_AUTORECONF = YES
WESTEROS_SIMPLESHELL_AUTORECONF_OPTS = "-Icfg"

WESTEROS_SIMPLESHELL_DEPENDENCIES = wayland libglib2

define WESTEROS_SIMPLESHELL_RUN_AUTOCONF
	mkdir -p $(@D)/simpleshell/cfg
	mkdir -p $(@D)/simpleshell/m4
endef
WESTEROS_SIMPLESHELL_PRE_CONFIGURE_HOOKS += WESTEROS_SIMPLESHELL_RUN_AUTOCONF

define WESTEROS_SIMPLESHELL_BUILD_CMDS
	SCANNER_TOOL=${HOST_DIR}/usr/bin/wayland-scanner $(MAKE) -C $(@D)/simpleshell/protocol
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/simpleshell
endef

define WESTEROS_SIMPLESHELL_INSTALL_STAGING_CMDS
	$(MAKE1) -C $(@D)/simpleshell DESTDIR=$(STAGING_DIR) install
endef

define WESTEROS_SIMPLESHELL_INSTALL_TARGET_CMDS
	$(MAKE1) -C $(@D)/simpleshell DESTDIR=$(TARGET_DIR) install
endef

$(eval $(autotools-package))
