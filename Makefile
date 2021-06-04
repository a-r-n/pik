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

nautilus:
	scripts/build_nautilus.sh

purge:
	rm -rf benchmarks/ binaries/ serial1.out serial2.out debug.out
