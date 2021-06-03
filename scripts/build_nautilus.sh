REPO_ROOT=$(dirname $(dirname $(readlink -f $0)))

cp ${REPO_ROOT}/configs/nautilus.config ${REPO_ROOT}/benchmarks/nautilus/.config 
cd ${REPO_ROOT}/benchmarks/nautilus 

make isoimage -j${nproc}

mv nautilus.bin ${REPO_ROOT}/binaries
mv nautilus.iso ${REPO_ROOT}/binaries
