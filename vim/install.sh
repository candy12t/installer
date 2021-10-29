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

if [ ! -e "/etc/debian_version" ]; then
  echo "Error: This script is only for Debian"
  exit 1
fi

apt install -y build-essential
apt build-dep -y vim

if [ ! -f "${tarball}" ]; then
  wget "https://github.com/vim/vim/archive/refs/tags/${tarball}" -O "${tarball}"
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
rm -rf "${archivedir}"

exit 0;
