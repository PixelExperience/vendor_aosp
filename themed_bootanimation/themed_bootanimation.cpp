/*
 * Copyright (C) 2019 The PixelExperience Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <errno.h>
#include <getopt.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>

#include <string>
#include <string_view>

#include <android-base/file.h>
#include <android-base/logging.h>
#include <android-base/properties.h>
#include <android-base/stringprintf.h>
#include <android-base/unique_fd.h>
#include <bootloader_message/bootloader_message.h>

using namespace std::string_literals;
using android::base::unique_fd;
using android::base::GetProperty;
using android::base::SetProperty;
using android::base::ReadFully;
using android::base::StringPrintf;
using std::stoi;
using std::string;
using std::string_view;

const char kPropOffset[] = "ro.misc.block.offset";
const char kPropBootTheme[] = "ro.boot.theme";

static bool read_misc_partition(void* p, size_t size, const string& misc_blk_device,
                                size_t offset, string* err) {
  unique_fd fd(open(misc_blk_device.c_str(), O_RDONLY));
  if (fd == -1) {
    *err = StringPrintf("failed to open %s: %s", misc_blk_device.c_str(),
                                       strerror(errno));
    return false;
  }
  if (lseek(fd, static_cast<off_t>(offset), SEEK_SET) != static_cast<off_t>(offset)) {
    *err = StringPrintf("failed to lseek %s: %s", misc_blk_device.c_str(),
                                       strerror(errno));
    return false;
  }
  if (!ReadFully(fd, p, size)) {
    *err = StringPrintf("failed to read %s: %s", misc_blk_device.c_str(),
                                       strerror(errno));
    return false;
  }
  return true;
}

int main(int argc, char** argv) {
  size_t offset = stoi(GetProperty(kPropOffset, "0"));
  string message, err;
  auto misc_blk_device = get_bootloader_message_blk_device(&err);
  constexpr string_view themeDarkMessage = "theme-dark";
  message.resize(themeDarkMessage.size());
  if (misc_blk_device.empty()) {
    LOG(ERROR) << "Unable to get misc block device: " << err;
    return EXIT_FAILURE;
  }
  LOG(INFO) << "Misc block device found: " << misc_blk_device.c_str();
  if (!read_misc_partition(message.data(), message.size(), misc_blk_device,
          VENDOR_SPACE_OFFSET_IN_MISC + offset, &err)){
      LOG(ERROR) << "Failed to read misc block device: " << misc_blk_device.c_str();
      return EXIT_FAILURE;
  }
  if (themeDarkMessage == message){
      LOG(INFO) << "Dark theme detected, defining ro.boot.theme=1";
      SetProperty(kPropBootTheme, "1");
  }else{
      LOG(INFO) << "Dark theme not detected, defining ro.boot.theme=0";
      SetProperty(kPropBootTheme, "0");
  }
  return EXIT_SUCCESS;
}