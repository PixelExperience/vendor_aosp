# Telephony

IS_PHONE := true

# Telephony packages
PRODUCT_PACKAGES += \
    Stk \
    CellBroadcastReceiver

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    net.tethering.noprovisioning=true

# Inherit full common PixelExperience stuff
$(call inherit-product, vendor/aosp/config/common_full.mk)
