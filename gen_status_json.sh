#!/bin/bash

set -ex

P=$1

pushd $P
ls -1 *.json | jq -R -s 'split("\n")[:-1] | {failed: false, files: .}' > /tmp/status.json
mv /tmp/status.json .
popd

 



