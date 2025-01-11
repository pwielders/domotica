################################################################################
#
# ggml
#
################################################################################
WHISPER_VERSION = ece3ff88f66cdc867d334ff4b8e8c00d9ffcebf7
WHISPER_SITE = $(call github,ggerganov,whisper.cpp,$(WHISPER_VERSION))
WHISPER_INSTALL_STAGING = YES
WHISPER_DEPENDENCIES = ggml llama

# WHISPER_CONF_OPTS  = -DWHISPER_BUILD_TESTS=OFF

ifeq ($(BR2_arm)$(BR2_aarch64),y)
WHISPER_CONF_OPTS += -DCMAKE_C_FLAGS="-mfp16-format=ieee" \
                     -DCMAKE_CXX_FLAGS="-mfp16-format=ieee"
endif

$(eval $(cmake-package))
