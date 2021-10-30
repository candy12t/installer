#! /bin/bash

# https://github.com/BurntSushi/ripgrep

set -eu

version=12.1.1
deb="ripgrep_${version}_amd64.deb"

if [ ! -f "${deb}" ]; then
  wget "https://github.com/BurntSushi/ripgrep/releases/download/${version}/${deb}" -O "${deb}"
fi

sudo dpkg -i "${deb}"
