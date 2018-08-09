ifneq ($(IS_GENERIC_SYSTEM_IMAGE), true)
ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)

ifeq ($(IS_GO_VERSION), true)
CUSTOM_OTA_VERSION_CODE := pie_go
else
CUSTOM_OTA_VERSION_CODE := pie
endif

CUSTOM_PROPERTIES += \
    org.pixelexperience.ota.version_code=$(CUSTOM_OTA_VERSION_CODE)

PRODUCT_PACKAGES += \
    Updates

endif
endif
