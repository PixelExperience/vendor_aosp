# Set all versions
CUSTOM_BUILD_TYPE ?= UNOFFICIAL
CUSTOM_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)
CUSTOM_PLATFORM_VERSION := 9.0

TARGET_PRODUCT_SHORT := $(subst aosp_,,$(CUSTOM_BUILD))

CUSTOM_VERSION := PixelExperience_$(CUSTOM_BUILD)-$(CUSTOM_PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)-CAF-$(CUSTOM_BUILD_TYPE)
ROM_FINGERPRINT := PixelExperience/$(CUSTOM_PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/CAF/$(CUSTOM_BUILD_DATE)

CUSTOM_PROPERTIES := \
    org.pixelexperience.version=$(CUSTOM_VERSION) \
    org.pixelexperience.build_date=$(CUSTOM_BUILD_DATE) \
    org.pixelexperience.build_type=$(CUSTOM_BUILD_TYPE) \
    org.pixelexperience.fingerprint=$(ROM_FINGERPRINT)
