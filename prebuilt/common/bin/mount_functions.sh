#!/sbin/sh
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

mount_all() {
  (mount /cache
  mount -o rw -t auto /persist
  mount -o rw -t auto /product
  mount -o rw -t auto /odm
  mount -o rw -t auto /vendor) 2>/dev/null
  test "$ANDROID_ROOT" || ANDROID_ROOT=/system
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
      echo "exit code is $?"
      if [ $? != 0 ]; then
        umount /system
        umount -l /system 2>/dev/null
        if [ "$dynamic_partitions" = "true" ]; then
          test -e /dev/block/mapper/system
          mount -o rw -t auto /dev/block/mapper/system /system_root
          (mount -o rw -t auto /dev/block/mapper/vendor /vendor
          mount -o rw -t auto /dev/block/mapper/product /product
          mount -o rw -t auto /dev/block/mapper/odm /odm) 2>/dev/null
        else
          test -e /dev/block/bootdevice/by-name/system
          mount -o rw -t auto /dev/block/bootdevice/by-name/system /system_root
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
  for p in "/cache" "/persist" "/vendor" "/product" "/odm"; do
    umount $p
    umount -l $p
  done) 2>/dev/null
}
