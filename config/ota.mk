ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)

CUSTOM_OTA_VERSION_CODE ?= oreo

CUSTOM_PROPERTIES += \
    org.pixelexperience.ota.version_code=$(CUSTOM_OTA_VERSION_CODE)

PRODUCT_PACKAGES += \
    Updates

endif
