#!/sbin/sh
source /tmp/install/bin/mount_functions.sh

umount_all

(for dir in /system /system_root; do
    if [ -L "${dir}_link" ]; then
    rmdir $dir
    mv -f ${dir}_link $dir
    fi
done
umount -l /dev/random) 2>/dev/null

exit 0