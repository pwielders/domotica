################################################################################
#
# bridge-contracts
#
################################################################################

BRIDGE_CONTRACTS_VERSION = main
BRIDGE_CONTRACTS_SITE_METHOD = git
BRIDGE_CONTRACTS_SITE = git@git.integraal.info:integraal/contracts.git
BRIDGE_CONTRACTS_INSTALL_STAGING = YES
BRIDGE_CONTRACTS_INSTALL_TARGET = YES

BRIDGE_CONTRACTS_DEPENDENCIES = bridge
BRIDGE_CONTRACTS_SUBDIR = src/
BRIDGE_CONTRACTS_CONF_OPTS += -DBUILD_REFERENCE=${BRIDGE_CONTRACTS_VERSION}

# Hopefully this is no longer needed ?
# define BRIDGE_POST_STAGING_CDM_HEADER
#        ln -sfn $(STAGING_DIR)/usr/include/bridge/interfaces/IDRM.h $(STAGING_DIR)/usr/include/cdmi.h
# endef

$(eval $(cmake-package))

