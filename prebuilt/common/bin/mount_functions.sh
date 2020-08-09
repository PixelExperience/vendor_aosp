#!/sbin/sh
export TMP="/tmp/install/bin"
export OUTFD="/proc/self/fd/$2"
cd $TMP

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

mount_all() {
  (mount -o rw -t auto /vendor
  mount -o rw -t auto /product
  mount -o rw -t auto /odm) 2>/dev/null
  setup_mountpoint $ANDROID_ROOT
  if ! is_mounted $ANDROID_ROOT; then
    mount -o rw -t auto $ANDROID_ROOT 2>/dev/null
  fi
  case $ANDROID_ROOT in
    /system_root) setup_mountpoint /system;;
    /system)
      if ! is_mounted /system && ! is_mounted /system_root; then
        setup_mountpoint /system_root
        mount -o rw -t auto /system_root
      elif [ -f /system/system/build.prop ]; then
        setup_mountpoint /system_root
        mount --move /system /system_root
      fi
      if [ $? != 0 ]; then
        umount /system
        umount -l /system 2>/dev/null
        if [ "$dynamic_partitions" = "true" ]; then
          test -e /dev/block/mapper/system || local slot=$(getprop ro.boot.slot_suffix 2>/dev/null)
          mount -o rw -t auto /dev/block/mapper/system$slot /system_root
          mount -o rw -t auto /dev/block/mapper/vendor$slot /vendor 2>/dev/null
          mount -o rw -t auto /dev/block/mapper/product$slot /product 2>/dev/null
          mount -o rw -t auto /dev/block/mapper/odm$slot /odm 2>/dev/null
        else
          test -e /dev/block/bootdevice/by-name/system || local slot=$(getprop ro.boot.slot_suffix 2>/dev/null)
          mount -o rw -t auto /dev/block/bootdevice/by-name/system$slot /system_root
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
}

umount_all() {
  (umount /system
  umount -l /system
  if [ -e /system_root ]; then
    umount /system_root
    umount -l /system_root
  fi
  for p in "/vendor" "/product" "/odm"; do
    umount $p
    umount -l $p
  done
  if [ "$UMOUNT_DATA" ]; then
    umount /data
    umount -l /data
  fi) 2>/dev/null
}
