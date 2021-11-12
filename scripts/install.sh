#!/usr/bin/env bash

# This script install cardano-node's binaries into bin/ directory.
# If you want to include the binaries in your PATH, run:
# export PATH=$PATH:$PWD/bin

set -euo pipefail

clean() {
  echo "Clean up"
  rm bin.tar.gz
}
trap clean EXIT

# Version: 1.31.0
LINUX_BUILD="8113349"
MACOS_BUILD="8113506"

rm -rf bin
mkdir -p bin

echo "Download binaries from official IOHK build"
case $(uname) in
Darwin)
  wget -O bin.tar.gz https://hydra.iohk.io/build/${MACOS_BUILD}/download/1/cardano-node-1.30.1-macos.tar.gz
  ;;
Linux)
  wget -O bin.tar.gz https://hydra.iohk.io/build/${LINUX_BUILD}/download/1/cardano-node-1.30.1-linux.tar.gz
  ;;
esac

echo "Unarchive binaries file"
tar -xzf bin.tar.gz -C bin
