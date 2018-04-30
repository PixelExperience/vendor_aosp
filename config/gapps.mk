TARGET_MINIMAL_APPS ?= false

GAPPS_VARIANT := nano

GAPPS_FORCE_MATCHING_DPI := true

ifeq ($(TARGET_HAS_NFC_SUPPORT),true)
GAPPS_PRODUCT_PACKAGES += TagGoogle
endif

ifeq ($(IS_PHONE),true)
GAPPS_PRODUCT_PACKAGES += PrebuiltBugle GoogleDialer
endif

GAPPS_PRODUCT_PACKAGES += GoogleContacts talkback LatinImeGoogle

ifeq ($(TARGET_MINIMAL_APPS),false)
GAPPS_PRODUCT_PACKAGES += CalendarGooglePrebuilt Chrome Photos PrebuiltDeskClockGoogle CalculatorGooglePrebuilt
else
GAPPS_EXCLUDED_PACKAGES := Velvet
endif

$(call inherit-product, vendor/opengapps/build/opengapps-packages.mk)
