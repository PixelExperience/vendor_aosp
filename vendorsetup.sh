for device in $(python vendor/aosp/tools/get_official_devices.py)
do
for var in eng user userdebug; do
add_lunch_combo aosp_$device-$var
done
done

# SDClang Environment Variables
export SDCLANG_AE_CONFIG=vendor/aosp/sdclang/sdclangAE.json
export SDCLANG_CONFIG=vendor/aosp/sdclang/sdclang.json
export SDCLANG_SA_ENABLED=false
