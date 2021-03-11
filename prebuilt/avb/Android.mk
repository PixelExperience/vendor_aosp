LOCAL_PATH := $(call my-dir)

ifeq ($(CUSTOM_BUILD_TYPE),OFFICIAL)
ifeq ($(TARGET_USES_CUSTOM_AVB_KEY),true)

define target-radio-files
$(notdir \
  $(wildcard $(LOCAL_PATH)/filesmap) \
  $(wildcard $(LOCAL_PATH)/*.bin) \
  $(wildcard $(LOCAL_PATH)/*.elf) \
  $(wildcard $(LOCAL_PATH)/*.img) \
  $(wildcard $(LOCAL_PATH)/*.mbn) \
)
endef

RADIO_FILES := $(wildcard $(LOCAL_PATH)/image/*)
$(foreach f, $(notdir $(RADIO_FILES)), \
    $(call add-radio-file,image/$(f)))

endif
endif
