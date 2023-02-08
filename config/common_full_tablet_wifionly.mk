# Tablet extension
PRODUCT_PACKAGES += \
    NexusLauncherTabletOverlay \
    androidx.window.extensions

# Inherit full common PixelExperience stuff
$(call inherit-product, vendor/aosp/config/common_full.mk)
