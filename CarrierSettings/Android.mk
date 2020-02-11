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

include $(CLEAR_VARS)
LOCAL_MODULE := CarrierSettings
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := CarrierSettings.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_OWNER := google
LOCAL_PRODUCT_MODULE := true
LOCAL_OVERRIDES_PACKAGES := CarrierConfig
LOCAL_PRIVILEGED_MODULE := true
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
include $(BUILD_PREBUILT)

define _add-carrier-settings-protobuf
include $$(CLEAR_VARS)
LOCAL_MODULE := $(notdir $(1))
LOCAL_MODULE_STEM := $(notdir $(1))
LOCAL_SRC_FILES := $1
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_OWNER := google
LOCAL_MODULE_PATH := $$(TARGET_OUT_PRODUCT)/etc/CarrierSettings
LOCAL_PRODUCT_MODULE := true
include $$(BUILD_PREBUILT)
endef

$(foreach _cspb, $(call find-subdir-subdir-files, "configs", "*.pb"), \
 $(eval $(call _add-carrier-settings-protobuf, $(_cspb))))
