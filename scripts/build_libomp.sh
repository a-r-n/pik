REPO_ROOT=$(dirname $(dirname $(readlink -f $0)))

cd ${REPO_ROOT}/benchmarks/llvm-project/openmp

mkdir -p build 
cd build/

if [ -f ".already_built" ]; then
  exit
fi

cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLIBOMP_ENABLE_SHARED=OFF -DDEFINE_DEBUG=OFF -DLIBOMP_ENABLE_ASSERTIONS=OFF -DDEBUG_BUILD=OFF -DLIBOMP_CXXFLAGS="-fPIC" ..
make -j32

touch .already_built

cd ${REPO_ROOT}/benchmarks
ln -s llvm-project/openmp/build/runtime/src/libomp.a libomp.a
