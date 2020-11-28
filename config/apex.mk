ifeq ($(TARGET_FLATTEN_APEX),false)
# Overlay
PRODUCT_PACKAGES += \
    ApexOverlay

# Enable Google Play system updates support
PRODUCT_SOONG_NAMESPACES += \
    vendor/aosp/apex

# ModuleMetadata
PRODUCT_PACKAGES += \
    ModuleMetadataGoogle

# Google Apexes
PRODUCT_PACKAGES += \
    com.google.android.adbd \
    com.google.android.conscrypt \
    com.google.android.extservices \
    com.google.android.ipsec \
    com.google.android.media \
    com.google.android.media.swcodec \
    com.google.android.mediaprovider \
    com.google.android.neuralnetworks \
    com.google.android.os.statsd \
    com.google.android.permission \
    com.google.android.resolv \
    com.google.android.sdkext \
    com.google.android.telephony \
    com.google.android.tzdata2
endif
