BUILD_RRO_SYSTEM_PACKAGE := $(TOPDIR)vendor/aosp/build/core/system_rro.mk

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
SELINUX_IGNORE_NEVERALLOWS := true
endif

# Rules for MTK targets
include $(TOPDIR)vendor/aosp/build/core/mtk_target.mk

# Rules for QCOM targets
include $(TOPDIR)vendor/aosp/build/core/qcom_target.mk
