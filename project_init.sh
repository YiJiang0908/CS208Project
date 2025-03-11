#!/bin/bash

set -e
# Docker
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# QEMU
apt-get install qemu -y
# KVM
sudo apt -y install bridge-utils cpu-checker libvirt-clients libvirt-daemon qemu qemu-kvm cargo squashfs-tools jq snapd
sudo apt update
sudo apt install git build-essential clang libssl-dev -y
# Firecracker
ARCH="$(uname -m)"
release_url="https://github.com/firecracker-microvm/firecracker/releases"
latest=$(basename $(curl -fsSLI -o /dev/null -w  %{url_effective} ${release_url}/latest))
curl -L ${release_url}/download/${latest}/firecracker-${latest}-${ARCH}.tgz \
| tar -xz

# Rename the binary to "firecracker"
mv release-${latest}-$(uname -m)/firecracker-${latest}-${ARCH} firecracker
cp firecracker /usr/local/bin/firecracker

#OSv
git clone https://github.com/cloudius-systems/osv.git
cd osv && git submodule update --init --recursive
./scripts/setup.py

#wrk
sudo apt update
sudo apt install git build-essential clang libssl-dev -y
git clone https://github.com/wg/wrk.git
cd wrk
make
sudo cp wrk /usr/local/bin/

