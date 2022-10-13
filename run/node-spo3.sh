#!/usr/bin/env bash

cardano-node run \
  --config 'configuration.yaml' \
  --topology 'node-spo3/topology.json' \
  --database-path 'node-spo3/db' \
  --socket-path 'sockets/node-spo3.sock' \
  --shelley-kes-key 'node-spo3/kes.skey' \
  --shelley-vrf-key 'node-spo3/vrf.skey' \
  --byron-delegation-certificate 'node-spo3/byron-delegation.cert' \
  --byron-signing-key 'node-spo3/byron-delegate.key' \
  --shelley-operational-certificate 'node-spo3/opcert.cert' \
  --host-addr 0.0.0.0 \
  --port 3003 |
  tee -a 'node-spo3/node.log'
