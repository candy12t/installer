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

if [ "$(uname -s)" != "Linux" ]; then
  echo "Error: This script is only for Linux"
  exit 1
fi

if [ -e "/etc/debian_version" ]; then
  sudo apt install -y build-essential
  sudo apt build-dep -y tmux
fi

if [ ! -f "${tarball}" ]; then
  wget "https://github.com/tmux/tmux/releases/download/${version}/${tarball}" -O "${tarball}"
fi

if [ -e "${archivedir}" ]; then
  sudo rm -rf "${archivedir}"
fi

tar zxvf "${tarball}"
cd "${archivedir}"

./configure --prefix=${prefix}
make
make install

cd "${script_home}"
sudo rm -rf "${archivedir}"
