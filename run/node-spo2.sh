#!/usr/bin/env bash

cardano-node run \
  --config 'configuration.yaml' \
  --topology 'node-spo2/topology.json' \
  --database-path 'node-spo2/db' \
  --socket-path 'sockets/node-spo2.sock' \
  --shelley-kes-key 'node-spo2/kes.skey' \
  --shelley-vrf-key 'node-spo2/vrf.skey' \
  --byron-delegation-certificate 'node-spo2/byron-delegation.cert' \
  --byron-signing-key 'node-spo2/byron-delegate.key' \
  --shelley-operational-certificate 'node-spo2/opcert.cert' \
  --host-addr 0.0.0.0 \
  --port 3002 |
  tee -a 'node-spo2/node.log'
