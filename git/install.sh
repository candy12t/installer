#! /bin/bash
set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

GIT_VERSION=2.31.1
GIT_TARBALL="v${GIT_VERSION}.tar.gz"
GIT_BUILD_DIR="git-${GIT_VERSION}"
GIT_PREFIX="/usr/local"

if [ "$(uname -s)" != "Linux" ]; then
  echo "Error: This script is only for Linux. Exiting."
  exit 1
fi

if command -v apt &> /dev/null; then
  sudo apt -y install make autoconf build-essential
  sudo apt -y build-dep git
fi

if [ ! -f "$GIT_TARBALL" ]; then
  wget "https://github.com/git/git/archive/refs/tags/${GIT_TARBALL}" -O "$GIT_TARBALL"
fi

if [ -e "$GIT_BUILD_DIR" ]; then
  rm -rf "$GIT_BUILD_DIR"
fi

tar zxf "$GIT_TARBALL"
pushd "$GIT_BUILD_DIR"

make configure
./configure --prefix="$GIT_PREFIX"
make all doc
make install install-doc install-html

popd
rm -rf "$GIT_BUILD_DIR"
exit 0
