#! /bin/bash

#
# vim install
#

set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

version=8.2.2738
tarball="v${version}.tar.gz"
archivedir="vim-${version}"

prefix="/usr/local"
feature="huge"

if [ "$(uname -s)" != "Linux" ]; then
  echo "Error: This script is only for Linux"
  exit 1
fi

if [ -e "/etc/debian_version" ]; then
  sudo apt install -y build-essential
  sudo apt build-dep -y vim
fi

if [ ! -f "${tarball}" ]; then
  wget "https://github.com/vim/vim/archive/refs/tags/${tarball}" -O "${tarball}"
fi

if [ -e "${archivedir}" ]; then
  sudo rm -rf "${archivedir}"
fi

tar zxvf "${tarball}"
cd "${archivedir}"

./configure \
  --prefix=${prefix} \
  --with-features=${feature} \
  --enable-fail-if-missing

make
make install

cd "${script_home}"
sudo rm -rf "${archivedir}"
