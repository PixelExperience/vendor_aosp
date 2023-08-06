lunch_others_targets=()
for d in $(python vendor/aosp/tools/get_official_devices.py)
do
    for v in user userdebug eng; do
        lunch_others_targets+=("aosp_$d-$v")
    done
done
