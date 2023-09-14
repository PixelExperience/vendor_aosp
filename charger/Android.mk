#
# Copyright (C) 2020 Raphielscape LLC. and Haruka LLC.
#
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

LOCAL_PATH := $(call my-dir)

### pixel_charger_res_images ###
ifneq ($(strip $(LOCAL_CHARGER_NO_UI)),true)
define _add-product-charger-image
include $$(CLEAR_VARS)
ifeq ($(2),vendor)
LOCAL_MODULE := pixel_charger_res_images_charger_$(notdir $(1))_vendor
else
LOCAL_MODULE := pixel_charger_res_images_charger_$(notdir $(1))
endif
LOCAL_MODULE_STEM := $(notdir $(1))
ifeq ($(2),vendor)
_img_modules_vendor += $$(LOCAL_MODULE)
else
_img_modules += $$(LOCAL_MODULE)
endif
LOCAL_SRC_FILES := $1
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := res/images/charger
ifeq ($(2),vendor)
LOCAL_VENDOR_MODULE := true
else
LOCAL_PRODUCT_MODULE := true
endif
include $$(BUILD_PREBUILT)
endef

_img_modules :=
$(foreach _img, $(call find-subdir-subdir-files, "images/charger", "*.png"), \
  $(eval $(call _add-product-charger-image,$(_img))))
_img_modules_vendor :=
$(foreach _img, $(call find-subdir-subdir-files, "images/charger", "*.png"), \
  $(eval $(call _add-product-charger-image,$(_img),vendor)))

### pixel_charger_animation_file ###
define _add-product-charger-animation-file
include $$(CLEAR_VARS)
ifeq ($(2),vendor)
LOCAL_MODULE := pixel_charger_res_values_charger_$(notdir $(1))_vendor
else
LOCAL_MODULE := pixel_charger_res_values_charger_$(notdir $(1))
endif
LOCAL_MODULE_STEM := $(notdir $(1))
ifeq ($(2),vendor)
_anim_modules_vendor += $$(LOCAL_MODULE)
else
_anim_modules += $$(LOCAL_MODULE)
endif
LOCAL_SRC_FILES := $1
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := res/values/charger
ifeq ($(2),vendor)
LOCAL_VENDOR_MODULE := true
LOCAL_OVERRIDES_MODULES := charger_res_images_vendor
else
LOCAL_PRODUCT_MODULE := true
LOCAL_OVERRIDES_MODULES := charger_res_images
endif
include $$(BUILD_PREBUILT)
endef

_anim_modules :=
$(foreach _txt, $(call find-subdir-subdir-files, "values/charger", "*.txt"), \
  $(eval $(call _add-product-charger-animation-file,$(_txt))))
_anim_modules_vendor :=
$(foreach _txt, $(call find-subdir-subdir-files, "values/charger", "*.txt"), \
  $(eval $(call _add-product-charger-animation-file,$(_txt),vendor)))

include $(CLEAR_VARS)
LOCAL_MODULE := product_charger_res_images
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := $(_img_modules) $(_anim_modules)
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := product_charger_res_images_vendor
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := $(_img_modules_vendor) $(_anim_modules_vendor)
include $(BUILD_PHONY_PACKAGE)

_add-product-charger-image :=
_add-product-charger-animation-file :=
_img_modules :=
_img_modules_vendor :=
_anim_modules :=
_anim_modules_vendor :=
endif # LOCAL_CHARGER_NO_UI
