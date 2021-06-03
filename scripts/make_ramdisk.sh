REPO_ROOT=$(dirname $(dirname $(readlink -f $0)))

cd ${REPO_ROOT}/binaries
dd if=/dev/zero of=ramdisk.img bs=1024 count=100000
mkfs.ext2 ramdisk.img
sudo mount ramdisk.img $MOUNTPATH

sudo cp ${REPO_ROOT}/binaries/nautilus/* $MOUNTPATH

sudo umount $MOUNTPATH

mv ramdisk.img ${REPO_ROOT}/benchmarks/nautilus/
