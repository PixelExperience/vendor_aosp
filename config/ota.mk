ifneq ($(filter OFFICIAL CI,$(CUSTOM_BUILD_TYPE)),)
PRODUCT_PACKAGES += \
    Updates
endif
