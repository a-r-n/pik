REPO_ROOT=$(dirname $(dirname $(readlink -f $0)))

cd ${REPO_ROOT}/benchmarks/NPB3.0-omp-C
cp ${REPO_ROOT}/configs/suite.def ./config
mkdir -p bin/

# Build for Linux 
cp ${REPO_ROOT}/configs/nas_linux_make.def ./config/make.def
rm -rf ${REPO_ROOT}/benchmarks/NPB3.0-omp-C/bin/* # paranoid against deleting /bin
make suite

mkdir -p ${REPO_ROOT}/binaries/linux
cp bin/* ${REPO_ROOT}/binaries/linux

# Build for Nautilus
cp ${REPO_ROOT}/configs/nas_nautilus_make.def ./config/make.def
rm -rf ${REPO_ROOT}/benchmarks/NPB3.0-omp-C/bin/* # paranoid against deleting /bin
make suite

mkdir -p ${REPO_ROOT}/binaries/nautilus
cp bin/* ${REPO_ROOT}/binaries/nautilus
