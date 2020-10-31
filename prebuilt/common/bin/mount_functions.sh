#!/sbin/ash
export OUTFD="/proc/self/fd/$2"
export TMP="/tmp/install/bin"
export PATH="$TMP:$PATH"

ui_print() {
  echo "ui_print $1
    ui_print" >> $OUTFD
}

setup_mountpoint() {
  test -L $1 && mv -f $1 ${1}_link
  if [ ! -d $1 ]; then
    rm -f $1
    mkdir $1
  fi
}

is_mounted() { mount | grep -q " $1 "; }

mount_apex() {
  test -d /system/apex || return 1
  local apex dest loop minorx num
  setup_mountpoint /apex
  test -e /dev/block/loop1 && minorx=$(ls -l /dev/block/loop1 | awk '{ print $6 }') || minorx=1
  num=0
  for apex in /system/apex/*; do
    dest=/apex/$(basename $apex .apex)
    test "$dest" = /apex/com.android.runtime.release && dest=/apex/com.android.runtime
    mkdir -p $dest
    case $apex in
      *.apex)
        unzip -qo $apex apex_payload.img -d /apex
        mv -f /apex/apex_payload.img $dest.img
        mount -t ext4 -o ro,noatime $dest.img $dest 2>/dev/null
        if [ $? != 0 ]; then
          while [ $num -lt 64 ]; do
            loop=/dev/block/loop$num
            (mknod $loop b 7 $((num * minorx))
            losetup $loop $dest.img) 2>/dev/null
            num=$((num + 1))
            losetup $loop | grep -q $dest.img && break
          done
          mount -t ext4 -o ro,loop,noatime $loop $dest
          if [ $? != 0 ]; then
            losetup -d $loop 2>/dev/null
          fi
        fi
      ;;
      *) mount -o bind $apex $dest;;
    esac
  done
  export ANDROID_RUNTIME_ROOT=/apex/com.android.runtime
  export ANDROID_TZDATA_ROOT=/apex/com.android.tzdata
  export BOOTCLASSPATH=/apex/com.android.runtime/javalib/core-oj.jar:/apex/com.android.runtime/javalib/core-libart.jar:/apex/com.android.runtime/javalib/okhttp.jar:/apex/com.android.runtime/javalib/bouncycastle.jar:/apex/com.android.runtime/javalib/apache-xml.jar:/system/framework/framework.jar:/system/framework/ext.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar:/system/framework/android.test.base.jar:/apex/com.android.conscrypt/javalib/conscrypt.jar:/apex/com.android.media/javalib/updatable-media.jar
}

umount_apex() {
  test -d /apex || return 1
  local dest loop
  for dest in $(find /apex -type d -mindepth 1 -maxdepth 1); do
    if [ -f $dest.img ]; then
      loop=$(mount | grep $dest | cut -d" " -f1)
    fi
    (umount -l $dest
    losetup -d $loop) 2>/dev/null
  done
  rm -rf /apex 2>/dev/null
  unset ANDROID_RUNTIME_ROOT ANDROID_TZDATA_ROOT BOOTCLASSPATH
}

mount_all() {
  (mount /cache
  mount -o ro -t auto /persist
  mount -o ro -t auto /product
  mount -o ro -t auto /odm
  mount -o ro -t auto /vendor) 2>/dev/null
  setup_mountpoint $ANDROID_ROOT
  if ! is_mounted $ANDROID_ROOT; then
    mount -o ro -t auto $ANDROID_ROOT 2>/dev/null
  fi
  case $ANDROID_ROOT in
    /system_root) setup_mountpoint /system;;
    /system)
      if ! is_mounted /system && ! is_mounted /system_root; then
        setup_mountpoint /system_root
        mount -o ro -t auto /system_root
      elif [ -f /system/system/build.prop ]; then
        setup_mountpoint /system_root
        mount --move /system /system_root
      fi
      if [ $? != 0 ]; then
        umount /system
        umount -l /system 2>/dev/null
        if [ "$dynamic_partitions" = "true" ]; then
          test -e /dev/block/mapper/system || local slot=$(getprop ro.boot.slot_suffix 2>/dev/null)
          mount -o ro -t auto /dev/block/mapper/system$slot /system_root
          mount -o ro -t auto /dev/block/mapper/vendor$slot /vendor 2>/dev/null
          mount -o ro -t auto /dev/block/mapper/product$slot /product 2>/dev/null
          mount -o ro -t auto /dev/block/mapper/odm$slot /odm 2>/dev/null
        else
          test -e /dev/block/bootdevice/by-name/system || local slot=$(getprop ro.boot.slot_suffix 2>/dev/null)
          mount -o ro -t auto /dev/block/bootdevice/by-name/system$slot /system_root
        fi
      fi
    ;;
  esac
  if is_mounted /system_root; then
    if [ -f /system_root/build.prop ]; then
      mount -o bind /system_root /system
    else
      mount -o bind /system_root/system /system
    fi
  fi
  mount_apex
}

umount_all() {
  (umount /system
  umount -l /system
  if [ -e /system_root ]; then
    umount /system_root
    umount -l /system_root
  fi
  for p in "/cache" "/persist" "/vendor" "/product" "/odm"; do
    umount $p
    umount -l $p
  done) 2>/dev/null
}
