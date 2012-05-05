KERNEL_DIR=linux-2.6.32-rzx50-20120225
KERNEL_VERSION=2.6.32-20120225

KERNEL_DIR=clab.out/rzx50-20120225/linux-2.6.32rzx50-20120222
KERNEL_VERSION=2.6.32-20120225

mount rootfs.ext2 mnt -o loop
cd mnt
#tar vfx ../missed_files.tar.gz
cd ..

mkdir -p mnt/lib/modules
cp -a ${KERNEL_DIR}/lib/modules/${KERNEL_VERSION} mnt/lib/modules
cp ${KERNEL_DIR}/lib/modules/${KERNEL_VERSION}/kernel/drivers/usb/gadget/g_serial.ko mnt/lib/modules
cp ${KERNEL_DIR}/lib/modules/${KERNEL_VERSION}/kernel/drivers/usb/gadget/g_ether.ko mnt/lib/modules

bash
umount mnt
