QCOM_HARDWARE_VARIANT=$(get_build_var QCOM_HARDWARE_VARIANT)
if [ ! -z "$QCOM_HARDWARE_VARIANT" -a "$QCOM_HARDWARE_VARIANT" != " " ]; then
    echo "Configuring display hal: ${QCOM_HARDWARE_VARIANT}"
    rm -rf $ANDROID_BUILD_TOP/hardware/qcom/display
    cp -a $ANDROID_BUILD_TOP/hardware/qcom/display-caf/$QCOM_HARDWARE_VARIANT $ANDROID_BUILD_TOP/hardware/qcom/display
    sed -i '1,3d' $ANDROID_BUILD_TOP/hardware/qcom/display/Android.bp
fi