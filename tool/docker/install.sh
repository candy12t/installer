#! /bin/bash

set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

docker_ce_version="20.10.10"
docker_ce_cli_version="20.10.10"
containerd_version="1.4.11-1"

distribution="$(cat /etc/lsb-release | grep DISTRIB_CODENAME | tr '=' ' ' | awk '{print $2}')"

docker_ce_url="https://download.docker.com/linux/ubuntu/dists/${distribution}/pool/stable/amd64/docker-ce_${docker_ce_version}~3-0~ubuntu-${distribution}_amd64.deb"
docker_ce_cli_url="https://download.docker.com/linux/ubuntu/dists/${distribution}/pool/stable/amd64/docker-ce-cli_20.10.10~3-0~ubuntu-${distribution}_amd64.deb"
containerd_url="https://download.docker.com/linux/ubuntu/dists/${distribution}/pool/stable/amd64/containerd.io_${containerd_version}_amd64.deb"

docker_ce_deb="docker_ce_${docker_ce_version}.deb"
docker_ce_cli_deb="docker_ce_cli_${docker_ce_cli_version}.deb"
containerd_deb="containerd_${containerd_version}.deb"
debs=("${docker_ce_deb}" "${docker_ce_cli_deb}" "${containerd_deb}")

declare -A deb_hash
deb_hash["${docker_ce_url}"]="${docker_ce_deb}"
deb_hash["${docker_ce_cli_url}"]="${docker_ce_cli_deb}"
deb_hash["${containerd_url}"]="${containerd_deb}"

__check_environment() {
  if [ ! -e "/etc/debian_version" ]; then
    echo "Error: This script is only for Debian"
    exit 1
  fi
}

__download_deb() {
  wget "$1" -O "$2"
}

__download_debs() {
  for url in "${!deb_hash[@]}"; do
    __download_deb "${url}" "${deb_hash[${url}]}"
  done
}

__dpkg() {
  dpkg -i $1
}

main() {
  __check_environment
  __download_debs
  __dpkg "${debs}"
}

main && echo "Successfully installed docker!!!"

exit 0;
