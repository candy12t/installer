#! /bin/bash

set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

main() {
  curl https://get.docker.com | sh
  usemod -aG docker $USER
  newgrp docker
}

main && echo "Successfully installed docker!!!"

exit 0;
