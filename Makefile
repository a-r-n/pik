all: 
	scripts/check_env.sh
	scripts/download.sh
	scripts/build_libomp.sh
	scripts/build_nas.sh
	scripts/build_epcc.sh
	scripts/make_ramdisk.sh
	scripts/build_nautilus.sh

download:
	scripts/download.sh

ramdisk:
	scripts/make_ramdisk.sh

nas: libomp download
	scripts/build_nas.sh

libomp: download
	scripts/build_libomp.sh

purge:
	rm -rf benchmarks/ binaries/
