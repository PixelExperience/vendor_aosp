# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
# Copyright (C) 2018 The PixelExperience Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CUSTOM_INSTALLED_SYSTEMIMAGE := $(PRODUCT_OUT)/$(CUSTOM_VERSION).img
CUSTOM_INSTALLED_SYSTEMIMAGE_COMPACTED := $(CUSTOM_INSTALLED_SYSTEMIMAGE).zip

.PHONY: gsi
gsi: $(INSTALLED_SYSTEMIMAGE)
	$(hide) mv $(PRODUCT_OUT)/system.img $(CUSTOM_INSTALLED_SYSTEMIMAGE)
	$(hide) zip -9qjX $(CUSTOM_INSTALLED_SYSTEMIMAGE_COMPACTED) $(CUSTOM_INSTALLED_SYSTEMIMAGE)
	$(hide) $(MD5SUM) $(CUSTOM_INSTALLED_SYSTEMIMAGE_COMPACTED) | sed "s|$(PRODUCT_OUT)/||" > $(CUSTOM_INSTALLED_SYSTEMIMAGE_COMPACTED).md5sum
	@echo "Package Complete: $(CUSTOM_INSTALLED_SYSTEMIMAGE_COMPACTED)" >&2
