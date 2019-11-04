BUILD_RRO_SYSTEM_PACKAGE := $(TOPDIR)vendor/aosp/build/core/system_rro.mk

# Rules for QCOM targets
include $(TOPDIR)vendor/aosp/build/core/qcom_target.mk

# Signing
ifneq ($(CUSTOM_KEYS_PATH),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(CUSTOM_KEYS_PATH)/releasekey
    PRODUCT_EXTRA_RECOVERY_KEYS := $(PRODUCT_DEFAULT_DEV_CERTIFICATE)
endif
