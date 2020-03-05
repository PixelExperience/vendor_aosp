ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)

CUSTOM_OTA_VERSION_CODE := ten_plus

CUSTOM_PROPERTIES += \
    org.pixelexperience.ota.version_code=$(CUSTOM_OTA_VERSION_CODE)

PRODUCT_PACKAGES += \
    Updates

PRODUCT_COPY_FILES += \
    vendor/aosp/config/permissions/org.pixelexperience.ota.xml:system/etc/permissions/org.pixelexperience.ota.xml

endif
