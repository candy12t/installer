#! /bin/bash

set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

tarball="OpenJDK8U-jdk_x64_linux_hotspot_8u312b07.tar.gz"
download_url="https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u312-b07/${tarball}"
install_path="/usr/local/jdk"

wget "${download_url}" -O "${tarball}"
sha256sum -c sha256sum.txt
mkdir -p "${install_path}"
tar xzf "${tarball}" -C "${install_path}" --strip-components=1

exit 0;
