#!/bin/bash
set -euo pipefail

STARTDIR=$PWD

setup_env() {
  # enable ARM support
  sudo cp /usr/bin/qemu-arm-static /usr/local/bin/
  sudo update-binfmts --install qemu-arm /usr/local/bin/qemu-arm-static --magic "\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00" --mask "\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff"

  # Get and unpack the ARM compiler tools for x64
  wget -q -c https://developer.arm.com/-/media/Files/downloads/gnu-a/${GCC_VERSION}/binrel/gcc-arm-${GCC_VERSION}-x86_64-arm-none-linux-gnueabihf.tar.xz
  sudo tar xf gcc-arm-${GCC_VERSION}-x86_64-arm-none-linux-gnueabihf.tar.xz -C /opt
  rm gcc-arm-${GCC_VERSION}-x86_64-arm-none-linux-gnueabihf.tar.xz

  # Setup the PATH to reference the newly unpacked tools.
  # IMPORTANT: This export is required for configure to pickup the ARM tools
  # IMPORTANT: so the path must be exported like this.
  export PATH=/opt/gcc-arm-${GCC_VERSION}-x86_64-arm-none-linux-gnueabihf/bin:$PATH

  # Update symbolic links to reference the ARM libraries needed for the build
  sudo ln -s /opt/gcc-arm-${GCC_VERSION}-x86_64-arm-none-linux-gnueabihf/arm-none-linux-gnueabihf/libc/lib/ld-linux-armhf.so.3 /lib/ld-linux-armhf.so.3
  sudo ln -s /opt/gcc-arm-${GCC_VERSION}-x86_64-arm-none-linux-gnueabihf/arm-none-linux-gnueabihf/libc/lib/libc.so.6 /lib/libc.so.6
  sudo ln -s /opt/gcc-arm-${GCC_VERSION}-x86_64-arm-none-linux-gnueabihf/arm-none-linux-gnueabihf/libc/lib/libpthread.so.0 /lib/libpthread.so.0
}

get() {
  wget -q https://github.com/esnet/iperf/releases/download/${IPERF3_VERSION}/iperf-${IPERF3_VERSION}.tar.gz
  tar xf iperf-${IPERF3_VERSION}.tar.gz
}

build() {
  # Go into the cdrdao-repo directory and configure the build to run for ARM Linux
  cd iperf-${IPERF3_VERSION}
  ./configure --host=arm-none-linux-gnueabihf --enable-static-bin
  make
  find . -type f -name iperf3
  cp "$(find . -type f -name iperf3)"  "${STARTDIR}/Scripts/.config/mister-iperf3"
}

cleanup() {
  cd $STARTDIR
  rm -rf iperf-${IPERF3_VERSION} iperf-${IPERF3_VERSION}.tar.gz
}

setup_env
get
build
cleanup
