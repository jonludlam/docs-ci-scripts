#!/bin/bash

set -x
set -e

host=$1 # gamma
dir=$2 # /data/data
prep_path=$3
local_prep_path=$4

time rsync -a $host:$dir/$prep_path/content.tar .
tar xf content.tar
mkdir -p $local_prep_path
mv home/opam/.opam/*/* $local_prep_path || true
mv home/opam/.opam/*/.opam-switch/packages/*/opam $local_prep_path || true

