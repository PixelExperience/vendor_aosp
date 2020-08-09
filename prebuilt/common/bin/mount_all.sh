#!/sbin/sh
source /tmp/install/bin/mount_functions.sh

ps | grep zygote | grep -v grep >/dev/null && BOOTMODE=true || BOOTMODE=false
$BOOTMODE || ps -A 2>/dev/null | grep zygote | grep -v grep >/dev/null && BOOTMODE=true

test "$ANDROID_ROOT" || ANDROID_ROOT=/system

dynamic_partitions=`getprop ro.boot.dynamic_partitions`

# emulators can only flash booted and may need /system (on legacy images), or / (on system-as-root images), remounted rw
if ! $BOOTMODE; then
  ./$mount_exec -o bind /dev/urandom /dev/random
  umount_all
  mount_all
fi
if [ "$dynamic_partitions" = "true" ]; then
  for block in system vendor product odm; do
    for slot in "" _a _b; do
      blockdev --setrw /dev/block/mapper/$block$slot 2>/dev/null
    done
  done
fi

./$mount_exec -o rw,remount -t auto /system || ./$mount_exec -o rw,remount -t auto /
./$mount_exec -o rw,remount -t auto /system_root 2>/dev/null
./$mount_exec -o rw,remount -t auto /vendor 2>/dev/null
./$mount_exec -o rw,remount -t auto /product 2>/dev/null
./$mount_exec -o rw,remount -t auto /odm 2>/dev/null