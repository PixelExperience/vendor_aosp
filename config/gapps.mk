TARGET_MINIMAL_APPS ?= false

ifeq ($(TARGET_MINIMAL_APPS),false)
GAPPS_VARIANT := nano
else
GAPPS_VARIANT := pico
endif

ifeq ($(IS_PHONE),true)
GAPPS_FORCE_DIALER_OVERRIDES := true
GAPPS_FORCE_MMS_OVERRIDES := true
endif

GAPPS_PRODUCT_PACKAGES += GoogleContacts talkback LatinImeGoogle PrebuiltDeskClockGoogle CalculatorGoogle
GAPPS_EXCLUDED_PACKAGES := PrebuiltGmsCoreInstantApps GooglePackageInstaller

ifeq ($(TARGET_MINIMAL_APPS),false)
GAPPS_FORCE_BROWSER_OVERRIDES := true
GAPPS_PRODUCT_PACKAGES += CalendarGooglePrebuilt Photos
endif

$(call inherit-product, vendor/opengapps/build/opengapps-packages.mk)
