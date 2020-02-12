# arbutus-slab family
PRODUCT_PACKAGES += \
    ArbutusSlab-Regular.ttf

# google-sans family
PRODUCT_PACKAGES += \
    GoogleSans-BoldItalic.ttf \
    GoogleSans-Bold.ttf \
    GoogleSans-Italic.ttf \
    GoogleSans-MediumItalic.ttf \
    GoogleSans-Medium.ttf \
    GoogleSans-Regular.ttf

# lato family
PRODUCT_PACKAGES += \
    Lato-BoldItalic.ttf \
    Lato-Bold.ttf \
    Lato-Italic.ttf \
    Lato-MediumItalic.ttf \
    Lato-Medium.ttf \
    Lato-Regular.ttf

# rubik family
PRODUCT_PACKAGES += \
    Rubik-BoldItalic.ttf \
    Rubik-Bold.ttf \
    Rubik-Italic.ttf \
    Rubik-MediumItalic.ttf \
    Rubik-Medium.ttf \
    Rubik-Regular.ttf

# zilla-slab family
PRODUCT_PACKAGES += \
    ZillaSlab-MediumItalic.ttf \
    ZillaSlab-Medium.ttf \
    ZillaSlab-SemiBoldItalic.ttf \
    ZillaSlab-SemiBold.ttf

# Customization overlays
PRODUCT_PACKAGES += \
    FontArbutusSourceOverlay \
    FontArvoLatoOverlay \
    FontRubikRubikOverlay

PRODUCT_COPY_FILES += \
    vendor/aosp/fonts/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml
