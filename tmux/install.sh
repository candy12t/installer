#! /bin/bash

#
# tmux install
#

set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

version=3.1c
tarball="tmux-${version}.tar.gz"
archivedir="tmux-${version}"

prefix="/usr/local"

if [ ! -e "/etc/debian_version" ]; then
  echo "Error: This script is only for Debian"
  exit 1
fi

apt install -y libevent-dev ncurses-dev build-essential bison pkg-config

if [ ! -f "${tarball}" ]; then
  wget "https://github.com/tmux/tmux/releases/download/${version}/${tarball}" -O "${tarball}"
fi

tar zxvf "${tarball}"
cd "${archivedir}"

./configure \
  --prefix=${prefix} \
  --enable-static
make
make install

cd "${script_home}"
rm -rf "${archivedir}"

exit 0;
