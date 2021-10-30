#! /bin/bash

# https://github.com/sharkdp/bat

set -eu

version=0.18.0
deb="bat_${version}_amd64.deb"

if [ ! -f "${deb}" ]; then
  wget "https://github.com/sharkdp/bat/releases/download/v${version}/${deb}" -O "${deb}"
fi

sudo dpkg -i "${deb}"
