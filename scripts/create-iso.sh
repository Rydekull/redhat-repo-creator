#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}" )"

ISO=rhel-server-7.6-x86_64-dvd.iso

rm -rf ../custom_inst ../custom_inst.iso

if [ ! -d ../custom_inst ]
then
  xorriso -osirrox on -indev ../${ISO} extract / ../custom_inst
fi

cp ../htmlpub/ks.cfg ../custom_inst/ks.cfg
#cp -r ../files/* ../custom_inst/
cd ../custom_inst
xorriso -as mkisofs -o ../custom_inst.iso -isohybrid-mbr /usr/share/syslinux/isohdpfx.bin -c isolinux/boot.cat -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -V CUSTOM_INST ./
#lsblk -o NAME,TRAN | awk '$NF ~ /^usb$/ { print $1 }'

