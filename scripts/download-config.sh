#!/usr/bin/env bash

# This script is for development purpose only. It will download official config files so we can compare them with current config files.

set -euo pipefail

rm -rf dev-config
mkdir -p dev-config
cd dev-config

wget https://book.world.dev.cardano.org/environments/mainnet/config.json
wget https://book.world.dev.cardano.org/environments/mainnet/topology.json
wget https://book.world.dev.cardano.org/environments/mainnet/byron-genesis.json
wget https://book.world.dev.cardano.org/environments/mainnet/shelley-genesis.json
wget https://book.world.dev.cardano.org/environments/mainnet/alonzo-genesis.json
