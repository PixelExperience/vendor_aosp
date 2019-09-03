include vendor/aosp/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/aosp/config/BoardConfigQcom.mk
else

ifneq ($(FORCE_QCOM_DISPLAY_HAL_VARIANT),)
include vendor/aosp/config/BoardConfigQcomDisplayOverride.mk
endif

endif

include vendor/aosp/config/BoardConfigSoong.mk
