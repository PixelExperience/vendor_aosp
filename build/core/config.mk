BUILD_RRO_SYSTEM_PACKAGE := $(TOPDIR)vendor/aosp/build/core/system_rro.mk

# Rules for MTK targets
include $(TOPDIR)vendor/aosp/build/core/mtk_target.mk

# Rules for QCOM targets
include $(TOPDIR)vendor/aosp/build/core/qcom_target.mk
