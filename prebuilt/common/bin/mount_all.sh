#!/sbin/ash
source /tmp/install/bin/mount_functions.sh

test "$ANDROID_ROOT" || ANDROID_ROOT=/system

mount -o bind /dev/urandom /dev/random
umount_all
mount_all

dynamic_partitions=`getprop ro.boot.dynamic_partitions`
if [ "$dynamic_partitions" = "true" ]; then
  for block in system vendor product odm; do
    for slot in "" _a _b; do
      blockdev --setrw /dev/block/mapper/$block$slot 2>/dev/null
    done
  done
fi

mount -o rw,remount -t auto /system || mount -o rw,remount -t auto /
mount -o rw,remount -t auto /vendor 2>/dev/null
mount -o rw,remount -t auto /product 2>/dev/null
mount -o rw,remount -t auto /odm 2>/dev/null

exit 0