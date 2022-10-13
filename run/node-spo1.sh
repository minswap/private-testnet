#!/usr/bin/env bash

cardano-node run \
  --config 'configuration.yaml' \
  --topology 'node-spo1/topology.json' \
  --database-path 'node-spo1/db' \
  --socket-path 'sockets/node-spo1.sock' \
  --shelley-kes-key 'node-spo1/kes.skey' \
  --shelley-vrf-key 'node-spo1/vrf.skey' \
  --byron-delegation-certificate 'node-spo1/byron-delegation.cert' \
  --byron-signing-key 'node-spo1/byron-delegate.key' \
  --shelley-operational-certificate 'node-spo1/opcert.cert' \
  --host-addr 0.0.0.0 \
  --port 3001 |
  tee -a 'node-spo1/node.log'
