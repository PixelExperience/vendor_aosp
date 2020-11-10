#!/sbin/sh
source /tmp/install/bin/mount_functions.sh

mount -o bind /dev/urandom /dev/random
umount_all
mount_all

dynamic_partitions=`getprop ro.boot.dynamic_partitions`
if [ "$dynamic_partitions" = "true" ]; then
  for partition in system vendor product odm; do
    (mount -o ro -t auto /dev/block/mapper/"$partition" /"$partition"
    blockdev --setrw /dev/block/mapper/"$partition"
    mount -o rw,remount -t auto /dev/block/mapper/"$partition" /"$partition") 2>/dev/null
  done
else
mount -o rw,remount -t auto /system || mount -o rw,remount -t auto /
(mount -o rw,remount -t auto /system_root
mount -o rw,remount -t auto /vendor
mount -o rw,remount -t auto /product
mount -o rw,remount -t auto /odm) 2>/dev/null
fi

exit 0