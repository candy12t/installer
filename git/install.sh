#! /bin/bash

#
# git install
#

set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

version=2.31.1
tarball="v${version}.tar.gz"
archivedir="git-${version}"

prefix="/usr/local"

if [ ! -e "/etc/debian_version" ]; then
  echo "Error: This script is only for Debian"
  exit 1
fi

sudo apt install -y build-essential autoconf libssl-dev
sudo apt build-dep -y git

if [ ! -f "${tarball}" ]; then
  wget "https://github.com/git/git/archive/refs/tags/${tarball}" -O "${tarball}"
fi

tar zxvf "${tarball}"
cd "${archivedir}"

make configure
./configure --prefix=${prefix}
make all doc
make install install-doc install-html

cd "${script_home}"
rm -rf "${archivedir}"

exit 0;
