################################################################################
#
# apl-client-library
#
################################################################################

APL_CLIENT_LIBRARY_VERSION = v1.8.2
APL_CLIENT_LIBRARY_SITE =  $(call github,alexa,apl-client-library,$(APL_CLIENT_LIBRARY_VERSION))
APL_CLIENT_LIBRARY_LICENSE = Apache-2.0
APL_CLIENT_LIBRARY_LICENSE_FILES = LICENSE.txt
APL_CLIENT_LIBRARY_DEPENDENCIES = host-cmake
APL_CLIENT_LIBRARY_INSTALL_STAGING = YES
APL_CLIENT_LIBRARY_INSTALL_TARGET = YES
APL_CLIENT_LIBRARY_DEPENDENCIES = host-cmake apl-core-library asio websocketpp

APL_CLIENT_LIBRARY_CONF_OPTS += -DSANDBOX=ON
APL_CLIENT_LIBRARY_CONF_OPTS += -DAPL_CORE=ON
APL_CLIENT_LIBRARY_CONF_OPTS += -DAPLCORE_INCLUDE_DIR=$(STAGING_DIR)/usr/include/apl
APL_CLIENT_LIBRARY_CONF_OPTS += -DAPLCORE_BUILD_INCLUDE_DIR="$(STAGING_DIR)/usr/include"
APL_CLIENT_LIBRARY_CONF_OPTS += -DAPLCORE_RAPIDJSON_INCLUDE_DIR="$(STAGING_DIR)/usr/include"
APL_CLIENT_LIBRARY_CONF_OPTS += -DAPLCORE_LIB_DIR="$(STAGING_DIR)/usr/lib/"
APL_CLIENT_LIBRARY_CONF_OPTS += -DYOGA_INCLUDE_DIR="$(STAGING_DIR)/usr/include/yoga"
APL_CLIENT_LIBRARY_CONF_OPTS += -DYOGA_LIB_DIR="$(STAGING_DIR)/usr/lib/"
APL_CLIENT_LIBRARY_CONF_OPTS += -DWEBSOCKETPP_INCLUDE_DIR="$(STAGING_DIR)/usr/include/websocketpp"

$(eval $(cmake-package))
