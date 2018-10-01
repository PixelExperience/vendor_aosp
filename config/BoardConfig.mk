include vendor/aosp/config/BoardConfigKernel.mk
include vendor/aosp/config/BoardConfigQcom.mk
include vendor/aosp/config/BoardConfigSoong.mk

# Disable qmi EAP-SIM security
DISABLE_EAP_PROXY ?= true
