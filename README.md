# Quick start
This repo is configured such that you can simply run `make MOUNTPATH=<path>` from the root and all required files will be compiled with minimal intervention (`MOUNTPATH` will be used to temporarily mount a filesystem; you will need `sudo` permissions). It assumes that the build environment is similar to that described in "Setting up a machine (or VM) for Nautilus Development and Testing." Everything should ideally be compiled with clang 9.0.0, but similar versions have been shown to work with limited testing. After building everything, all relevant files will be in a newly created directory called `binaries`. Those built for Linux are under `binaries/linux` and should work on most Linux systems. Those build for Nautilus are under `binaries/nautilus` and will only work in Nautilus. Nautilus itself will be available as `binaries/nautilus.{bin,iso}`.

To boot Nautilus in qemu, you can execute the `./run.sh` script at the root of this repo.

Once booted, you should see a prompt starting with `root-shell>`. Here, you can run any of the mounted benchmarks using the command: `exec /<filename>` (note the leading slash). You may need to reboot Nautilus before running a subsequent benchmark.

# Manually building
This section outlines the process of building the benchmarks for PIK and configuring Nautilus for PIK.

## Building libomp.a

More or less, a standard build of OpenMP can be used for PIK. Some small necessary changes are automatically included as a patch when you run `make download`. After downloading, you just need to build OpenMP as a static library. More detailed directions for this are available from LLVM in their repo.

## Building and mounting the benchmarks

### NAS benchmarks

The NAS benchmarks used are available after running `make download` in `benchmarks/NPB3.0-omp-C`.

Since PIK uses a modified linking process, some modifications need to be made to `config/make.def`:

  1. `CLINK` should be replaced with the path to `nld`, plus the `-nokarat` flag (`benchmarks/nautilus/user/framework/nld`).
  2. The `CFLAGS` should be replaced with `-fPIC -O3`.
  3. You need to make the linker able to see `libomp.a`, probably with a `-L` flag to the path containing it.

Change directory to `benchmarks/NPB3.0-omp-C/`. Run `mkdir bin; make suite` to build

At this point, all of the binaries will be located under `benchmarks/NPB3.0-omp-C/bin/`. They next need to be placed on a filesystem so that they can be embedded in the Nautilus boot image:

  1. Make a new empty file (we suggest the following parameters): `dd if=/dev/zero of=ramdisk.img bs=1024 count=100000`
  2. Format the filesystem as ext2: `mkfs.ext2 ramdisk.img`
  3. Mount the filesystem. (e.g. `sudo mount ext2.img /mnt`)
  4. Copy the binaries from `bin/` to the filesystem (e.g. `sudo cp bin/* /mnt/`).
  5. Unmount the filesystem (e.g. `sudo umount /mnt`).
  6. Move the `ramdisk.img` to `benchmarks/nautilus`.

### EPCC benchmarks

The EPCC benchmarks are included as an archive under `bundle/epcc.tgz`. To build for Nautilus, you will need to set the linker to `benchmarks/nautilus/user/framework/nld -nokarat` and pass a `-L` pointing to the directory containing `libomp.a`. No other changes should be necessary.

The same procedure as described in the previous section should be used to place the images on a ramdisk for use in Nautilus.

## Building Nautilus for PIK

Nautilus uses Kconfig. To set its configuration prior to compilation, run `make menuconfig`.

The following configuration options are required (or suggested) for PIK:

  1. (Suggested) Build -> Compiler and related toolchain... -> Clang
  2. Configuration -> Enable support for process creation
  3. Configuration -> Enable support for Linux syscall emulation
  4. Address Spaces -> Enable Address Spaces -> Paging Abstraction
  5. Devices -> RAM Disk Support -> Embed nautilus/ramdisk.img ...
  6. Filesystems -> Enable EXT2

Assuming the above configuration is set and that the steps to create `ramdisk.img` were followed, you can now run `make isoimage` and Nautilus with PIK will be built. It can then be run in qemu with the desired parameters (example in `run.sh`).
