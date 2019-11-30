# Telephony

IS_PHONE := true

ifeq ($(TARGET_USES_AOSP_APNS_CONF),)
# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml
endif

# Telephony packages
PRODUCT_PACKAGES += \
    Stk \
    CellBroadcastReceiver

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    net.tethering.noprovisioning=true

# Default ringtone
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.ringtone=The_big_adventure.ogg

# Inherit full common PixelExperience stuff
$(call inherit-product, vendor/aosp/config/common_full.mk)
