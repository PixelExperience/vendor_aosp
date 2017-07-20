for device in $(curl -s https://raw.githubusercontent.com/PixelExperience/official_devices/master/devices.json | sed 's/ //; /^$/d' | grep -Po '\"codename\": ".*?"' | sed -e 's/codename//;s/\"//g;s/\: //')
do
for var in eng user userdebug; do
add_lunch_combo aosp_$device-$var
done
done
