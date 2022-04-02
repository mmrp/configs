#!/bin/bash --noprofile

trap 'echo "# $BASH_COMMAND"' DEBUG

set -e
set -u

configs=$(realpath $(dirname $0))/configs
njobs=$((2 * $(nproc)))

if [ ! -d ${configs} ]; then
  echo "configs directory missing, please check where you are running this script from"
  exit 1
fi

if [ $(id -u) -ne 0 ]; then
  echo "run as root user"
  return 1
fi


isfile() {
  file=${1?"arg missing"}
  if [ -f ${file} ]; then
    return 0
  fi
  return 1

}

check_exists() {
  [ -e ${1} ]
}


check_dir() {
  if [ ! -d ${1} ]; then
    echo "not a directory:${1}"
    return 1
  fi
  return 0
}


build_n_install() {
  local src;src=${1?"provide source directory"}
  local dst;dst=${2?"provide destination directory"}
  local cfg_file; cfg_file=${3?"provide config file path"}
  local pkg;pkg=${4?"provide pkg name"}
  local -n build_dir=${5:-Yadeghilkp}
  local -n install_dir=${6:-Xadeghilkp}
  local install_func=${7:-""}

  check_dir ${src} || return 1

  check_exists ${dst} && isfile ${dst} && ( echo "dst:${dst} is a file, expecting directory"; return 1 )


  src=$(realpath ${src})
  dst=$(realpath ${dst})
  cfg_file=$(realpath ${cfg_file})

  install_dir=${dst}/install/${pkg}
  build_dir=${dst}/build/${pkg}

  mkdir -p ${install_dir}
  mkdir -p ${build_dir}

  #rm -rf ${install_dir}/*
  #rm -rf ${build_dir}/*


  cp ${cfg_file} ${build_dir}/.config

  cd ${build_dir}

  cd ${src}

  make mrproper

  make oldconfig O=${build_dir} >/dev/null

  make -j${njobs} O=${build_dir}

  if [ -n "${install_func}" ]; then
    echo "Executing user provided function"
    eval "${install_func}"
  else
    make install -j${njobs} O=${build_dir} CONFIG_PREFIX=${install_dir}
  fi

  return 0
}

build_n_install_busybox() {
 if [ $# -lt 2 ]; then
    echo "Usage: src-dir dst-dir"
    return 1
  fi

  pushd .
  build_n_install "$@" ${configs}/busybox.config busybox
  popd
}

build_n_install_linux() {
  local install
  local build
  if [ $# -lt 2 ]; then
    echo "Usage: src-dir dst-dir"
    return 1
  fi


  pushd .
  build_n_install "$@" ${configs}/linux.config linux build install "echo"
  cp ${build}/arch/x86/boot/bzImage ${install}
  echo "Image in ${install}/bzImage"
  popd
}


create_disk_image() {
   local dir; dir=${1?"provide directory containing binaries"}
   local size; size=${2?"size of the image in MB"}
   local dst; dst=${3?:"provide destination directory"}
   local name; name=${4?:"provide image name"}

   pushd .
   check_dir ${dir} || return 1
   check_dir ${dst} || return 1

   local image=${dst}/${name}

   dd if=/dev/zero of=${image} bs=1M count=${size}
   mkfs.ext4 -q ${image}

   local mount_pt=${dst}/mount_pt
   mkdir -p ${mount_pt}

   first_dev=$(losetup -f)
   losetup ${first_dev} ${image}

   mount ${image} ${mount_pt}

   cp -a ${dir}/* ${mount_pt}

   for dir in sys proc dev etc etc/init.d tmp; do
	   mkdir -p ${mount_pt}/${dir}
   done

   cp -a ${configs}/rootfs/* ${mount_pt}
   chown -R 0:0 ${mount_pt}

   umount ${mount_pt}
   losetup -d ${first_dev}
   popd 
}

run_qemu() {
  local kernel;kernel=${1:?"provide kernel image location"}
  local rootfs;rootfs=${2:?"provide root filesystem image"}

  qemu-system-x86_64 -kernel ${kernel} \
    -drive file=${rootfs},if=virtio,format=raw \
    --append "console=ttyS0 root=/dev/vda ro" \
    -nic user,model=virtio-net-pci,hostfwd=tcp::8000-:4000 \
    -nographic
}


build_n_run() {
	local busybox_src=${1?"provide busybox source code"}
	local linux_src=${2?"provide linux source code"}
	local artifacts_dir=${3?"artificats directory"}
	local disk_image_name=${4?"disk image name"}

    build_n_install_busybox ${busybox_src} ${artifacts_dir}
    build_n_install_linux   ${linux_src}   ${artifacts_dir}
	create_disk_image ${artifacts_dir}/install/busybox/ 50 ${artifacts_dir} ${disk_image_name}
	run_qemu ${artifacts_dir}/install/linux/bzImage ${artifacts_dir}/${disk_image_name}

}

help() {
 for fun in "build_n_install_linux build_n_install_busybox create_disk_image run_qemu"; do
   echo ${fun}
 done
 echo "sample usage:"
cat <<EOF
# build linux
./setup.sh build_n_install_linux /home/test/work/git/linux /tmp/qemu configs/linux.config  linux

# build busybox
./setup.sh build_n_install_busybox /home/test//work/git/busybox /tmp/qemu

# create disk
sudo ./setup.sh create_disk_image /tmp/qemu/install/busybox/ 50 /tmp/qemu/ rootfs.ext4

# start qemu
sudo ./setup.sh run_qemu /tmp/qemu/install/linux/bzImage /tmp/qemu/rootfs.ext4
EOF
}

#build_n_install_busybox "$@"
#build_n_install_linux "$@"
#create_disk_image "$@"
#run_qemu "$@"

cmd=${1?"provide valid commands"}
shift
echo "executing command: ${cmd}"
eval "${cmd}" "$@" || (echo -e "help")
