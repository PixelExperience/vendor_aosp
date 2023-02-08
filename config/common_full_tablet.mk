# Launcher overlay
PRODUCT_PACKAGES += \
    NexusLauncherTabletOverlay
    
# Tablet extension
PRODUCT_PACKAGES += \
    androidx.window.extensions

# Inherit full common PixelExperience stuff
$(call inherit-product, vendor/aosp/config/common_full_phone.mk)
