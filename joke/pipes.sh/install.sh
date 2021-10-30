#! /bin/bash

#
# pipes.sh install
#

set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

version=1.3.0
tarball="v${version}.tar.gz"
archivedir="pipes.sh-${version}"

if [ ! -f "${tarball}" ]; then
  wget "https://github.com/pipeseroni/pipes.sh/archive/refs/tags/${tarball}" -O "${tarball}"
fi

tar zxvf "${tarball}"
cd "${archivedir}"

make install

cd "${script_home}"
rm -rf "${archivedir}"

exit 0;
