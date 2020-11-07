#!/sbin/sh
export TMP="/tmp/install/bin"
export OUTFD="/proc/self/fd/$2"
export mount_exec="$TMP/mount"
export umount_exec="$TMP/umount"

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

is_mounted() { ./$mount_exec | grep -q " $1 "; }

mount_all() {
  (./$mount_exec -o rw -t auto /vendor
  ./$mount_exec -o rw -t auto /product
  ./$mount_exec -o rw -t auto /odm) 2>/dev/null
  setup_mountpoint $ANDROID_ROOT
  if ! is_mounted $ANDROID_ROOT; then
    ./$mount_exec -o rw -t auto $ANDROID_ROOT 2>/dev/null
  fi
  case $ANDROID_ROOT in
    /system_root) setup_mountpoint /system;;
    /system)
      if ! is_mounted /system && ! is_mounted /system_root; then
        setup_mountpoint /system_root
        ./$mount_exec -o rw -t auto /system_root
      elif [ -f /system/system/build.prop ]; then
        setup_mountpoint /system_root
        ./$mount_exec --move /system /system_root
      fi
      if [ $? != 0 ]; then
        ./$umount_exec /system
        ./$umount_exec -l /system 2>/dev/null
        if [ "$dynamic_partitions" = "true" ]; then
          test -e /dev/block/mapper/system || local slot=$(getprop ro.boot.slot_suffix 2>/dev/null)
          ./$mount_exec -o rw -t auto /dev/block/mapper/system$slot /system_root
          ./$mount_exec -o rw -t auto /dev/block/mapper/vendor$slot /vendor 2>/dev/null
          ./$mount_exec -o rw -t auto /dev/block/mapper/product$slot /product 2>/dev/null
          ./$mount_exec -o rw -t auto /dev/block/mapper/odm$slot /odm 2>/dev/null
        else
          test -e /dev/block/bootdevice/by-name/system || local slot=$(getprop ro.boot.slot_suffix 2>/dev/null)
          ./$mount_exec -o rw -t auto /dev/block/bootdevice/by-name/system$slot /system_root
        fi
      fi
    ;;
  esac
  if is_mounted /system_root; then
    if [ -f /system_root/build.prop ]; then
      ./$mount_exec -o bind /system_root /system
    else
      ./$mount_exec -o bind /system_root/system /system
    fi
  fi
}

umount_all() {
  (./$umount_exec /system
  ./$umount_exec -l /system
  if [ -e /system_root ]; then
    ./$umount_exec /system_root
    ./$umount_exec -l /system_root
  fi
  for p in "/vendor" "/product" "/odm"; do
    ./$umount_exec $p
    ./$umount_exec -l $p
  done
  if [ "$UMOUNT_DATA" ]; then
    ./$umount_exec /data
    ./$umount_exec -l /data
  fi) 2>/dev/null
}
