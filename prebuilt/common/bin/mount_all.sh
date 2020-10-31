#!/sbin/sh
source /tmp/install/bin/mount_functions.sh

dynamic_partitions=`getprop ro.boot.dynamic_partitions`
if [ "$dynamic_partitions" = "true" ]; then
  for partition in system vendor product odm; do
    mount -o ro -t auto /dev/block/mapper/"$partition" /"$partition" 2> /dev/null
    blockdev --setrw /dev/block/mapper/"$partition" 2> /dev/null
    mount -o rw,remount -t auto /dev/block/mapper/"$partition" /"$partition" 2> /dev/null
  done
else
mount -o rw,remount -t auto /system || mount -o rw,remount -t auto /
mount -o rw,remount -t auto /vendor 2>/dev/null
mount -o rw,remount -t auto /product 2>/dev/null
mount -o rw,remount -t auto /odm 2>/dev/null
fi

exit 0