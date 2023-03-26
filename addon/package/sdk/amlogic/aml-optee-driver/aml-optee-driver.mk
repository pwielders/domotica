################################################################################
#
# aml-optee-driver
#
################################################################################
AML_OPTEE_DRIVER_VERSION = stable2
AML_OPTEE_DRIVER_SITE = git@github.com:Metrological/amlogic-optee-driver.git
AML_OPTEE_DRIVER_SITE_METHOD = git
AML_OPTEE_DRIVER_LICENSE = CLOSED
AML_OPTEE_DRIVER_INSTALL_STAGING = YES
AML_OPTEE_DRIVER_INSTALL_TARGET = YES
AML_OPTEE_DRIVER_DEPENDENCIES = libdrm wayland linux

AML_OPTEE_DRIVER_KO_DIR=lib/modules/4.9.113

define AML_OPTEE_DRIVER_AUTO_LOAD_MODULE_INSTALL
    $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modules-load.d
    echo "${1}" > "${TARGET_DIR}/etc/modules-load.d/${1}.conf"

    if [ ! -z "${2}" ]; then \
        $(INSTALL) -m 755 -d $(TARGET_DIR)/etc/modprobe.d ; \
        echo "${2}" > "${TARGET_DIR}/etc/modprobe.d/${1}.conf" ; \
    fi
endef

###############################################################################
# OPTEE driver
###############################################################################
LINUX_MAKE_ENV += KERNEL_A32_SUPPORT=true

AML_OPTEE_DRIVER_MODULE_SUBDIRS += linuxdriver

define AML_OPTEE_DRIVER_OPTEE_MODULES_AUTO_LOAD
    $(call AML_OPTEE_DRIVER_AUTO_LOAD_MODULE_INSTALL,optee)
    $(call AML_OPTEE_DRIVER_AUTO_LOAD_MODULE_INSTALL,optee_armtz)
endef
AML_OPTEE_DRIVER_POST_INSTALL_TARGET_HOOKS += AML_OPTEE_DRIVER_OPTEE_MODULES_AUTO_LOAD

$(eval $(kernel-module))
$(eval $(generic-package))

