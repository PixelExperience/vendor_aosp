TARGET_MINIMAL_APPS ?= false

GAPPS_VARIANT := nano

ifeq ($(IS_PHONE),true)
GAPPS_FORCE_DIALER_OVERRIDES := true
GAPPS_FORCE_MMS_OVERRIDES := true
endif

GAPPS_PRODUCT_PACKAGES += GoogleContacts talkback LatinImeGoogle PrebuiltDeskClockGoogle CalculatorGoogle TagGoogle
GAPPS_EXCLUDED_PACKAGES := PrebuiltGmsCoreInstantApps GooglePackageInstaller

ifeq ($(TARGET_MINIMAL_APPS),false)
GAPPS_FORCE_BROWSER_OVERRIDES := true
GAPPS_PRODUCT_PACKAGES += CalendarGooglePrebuilt Photos
else
GAPPS_EXCLUDED_PACKAGES += Velvet
endif

$(call inherit-product, vendor/opengapps/build/opengapps-packages.mk)
