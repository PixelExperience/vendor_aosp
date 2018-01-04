for device in $(python vendor/aosp/tools/get_official_devices.py)
do
for var in eng user userdebug; do
add_lunch_combo aosp_$device-$var
done
done
