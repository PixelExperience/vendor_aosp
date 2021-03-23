BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_KEY_PATH := external/avb-keys/avb.pem
ifneq ($(BOARD_AVB_VBMETA_SYSTEM_KEY_PATH), )
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb-keys/avb.pem
endif
ifneq ($(BOARD_AVB_RECOVERY_KEY_PATH), )
BOARD_AVB_RECOVERY_KEY_PATH := external/avb-keys/avb.pem
endif
