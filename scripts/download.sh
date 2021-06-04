REPO_ROOT=$(dirname $(dirname $(readlink -f $0)))

cd ${REPO_ROOT}
mkdir -p benchmarks
cd benchmarks

if [ -f ".download_done" ]; then
  exit
fi

tar -xf ${REPO_ROOT}/bundle/epcc.tgz

git clone --depth 1 -b karat-omp --single-branch https://github.com/sgh185/nautilus.git
cd nautilus
git checkout 68a4f61c05e14fd626737f358ba1e99cdecf93c6
git apply ${REPO_ROOT}/patches/nautilus-user-build.patch
cd ..

git clone https://github.com/benchmark-subsetting/NPB3.0-omp-C.git
cd NPB3.0-omp-C
git checkout 5d565d916cad47bf09a2fa7432bf8e5fa95446ec
git apply ${REPO_ROOT}/patches/nas-fix-is.patch
cp ${REPO_ROOT}/configs/nas-suite.def config/suite.def
cd ..

git clone --depth 1 -b llvmorg-9.0.1 --single-branch https://github.com/llvm/llvm-project.git
cd llvm-project
git apply ${REPO_ROOT}/patches/libomp-pik.patch
cd ..

touch .download_done