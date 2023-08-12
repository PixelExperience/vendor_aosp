ifneq ($(filter OFFICIAL,$(CUSTOM_BUILD_TYPE)),)
PRODUCT_PACKAGES += \
    Updates
endif
