REPO_ROOT=$(dirname $(dirname $(readlink -f $0)))

cd ${REPO_ROOT}/benchmarks/epcc/

# Build for Linux 
cp ${REPO_ROOT}/configs/epcc_linux_make.defs ./config/Makefile.defs
make clean; make

mkdir -p ${REPO_ROOT}/binaries/linux

ls | grep arraybench | grep -v "\.c" | grep -v "\.h" | grep -v "\.o" | xargs -I% mv % ${REPO_ROOT}/binaries/linux
cp *bench ${REPO_ROOT}/binaries/linux

# Build for Nautilus
cp ${REPO_ROOT}/configs/epcc_nautilus_make.defs ./config/Makefile.defs
make clean; make

mkdir -p ${REPO_ROOT}/binaries/nautilus

ls | grep arraybench | grep -v "\.c" | grep -v "\.h" | grep -v "\.o" | xargs -I% mv % ${REPO_ROOT}/binaries/nautilus
cp *bench ${REPO_ROOT}/binaries/nautilus