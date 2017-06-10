for device in $(curl -s https://raw.githubusercontent.com/PixelExperience/official_devices/master/devices.json | sed 's/ //; /^$/d' | grep -Po '\"codename\": ".*?"' | sed -e 's/codename//;s/\"//g;s/\: //')
do
add_lunch_combo aosp_$device-userdebug
done
