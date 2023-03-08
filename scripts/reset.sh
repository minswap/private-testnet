#!/usr/bin/env bash

set -euo pipefail

here="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
root="$(cd "$here/.." && pwd)"
cd "$root"

export PATH=$PWD/bin:$PATH

# Use GNU sed for MacOS
case $(uname) in
Darwin) sed='gsed' ;;
*) sed='sed' ;;
esac

case $(uname) in
Darwin) date='gdate' ;;
*) date='date' ;;
esac

timeISO=$($date -u -d "now + 30 seconds" +"%Y-%m-%dT%H:%M:%SZ")
timeUnix=$($date -d "now + 30 seconds" +%s)

echo "Clean old state and logs"
rm -rf \
  logs \
  node-spo1/db \
  node-spo1/node.log \
  node-spo1/node.sock \
  node-spo2/db \
  node-spo2/node.log \
  node-spo2/node.sock \
  node-spo3/db \
  node-spo3/node.log \
  node-spo3/node.sock \
  sockets/*

mkdir -p sockets

echo "Update start time in genesis files"
$sed -i -E "s/\"startTime\": [0-9]+/\"startTime\": ${timeUnix}/" genesis/byron/genesis.json
$sed -i -E "s/\"systemStart\": \".*\"/\"systemStart\": \"${timeISO}\"/" genesis/shelley/genesis.json

echo "Update VRF key permission, sometimes GitHub changes these"
chmod 600 \
  node-spo1/vrf.skey \
  node-spo2/vrf.skey \
  node-spo3/vrf.skey

# Kill all child processes on Ctrl+C
trap 'killall -2 cardano-node' EXIT

echo "Run all nodes"
run/node-spo1.sh &
run/node-spo2.sh &
run/node-spo3.sh &

# Mint test tokens as soon as nodes are ready
CARDANO_NODE_SOCKET_PATH=$PWD/sockets/node-spo3.sock ./scripts/mint-tokens.sh &

wait
