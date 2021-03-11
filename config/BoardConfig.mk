include vendor/aosp/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/aosp/config/BoardConfigQcom.mk
endif

# Custom AVB Key
ifeq ($(CUSTOM_BUILD_TYPE),OFFICIAL)
ifeq ($(TARGET_USES_CUSTOM_AVB_KEY),true)
include vendor/aosp/config/BoardConfigAvb.mk
endif
endif

include vendor/aosp/config/BoardConfigSoong.mk

# Namespace for fwk-detect
TARGET_FWK_DETECT_PATH ?= hardware/qcom-caf/common
PRODUCT_SOONG_NAMESPACES += \
    $(TARGET_FWK_DETECT_PATH)/fwk-detect
