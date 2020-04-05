# Set all versions
CUSTOM_BUILD_TYPE ?= UNOFFICIAL

CUSTOM_PLATFORM_VERSION := 10.0

TARGET_PRODUCT_SHORT := $(subst aosp_,,$(CUSTOM_BUILD))

CUSTOM_VERSION := PixelExperience_$(CUSTOM_BUILD)-$(CUSTOM_PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)-$(CUSTOM_BUILD_TYPE)
CUSTOM_VERSION_PROP := ten

CUSTOM_PROPERTIES := \
    org.pixelexperience.version=$(CUSTOM_VERSION_PROP) \
    org.pixelexperience.version.display=$(CUSTOM_VERSION) \
    org.pixelexperience.build_type=$(CUSTOM_BUILD_TYPE)

ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/secure/releasekey
endif
