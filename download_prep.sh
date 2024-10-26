#!/bin/bash

set -e
set -x

host=$1   # gamma
dir=$2    # /data/data/
pkg=$3    # prep0/u/745d6c5e6ba222bcc493e3bdedc73465/cmdliner/1.3.0/

cd /home/opam/.cache/prep


if [ ! -f $pkg/content.tar ]; then
   mkdir -p $pkg
   RC=1 
   while [[ $RC -ne 0 ]]
   do
      rsync -av $host:$dir/$pkg/content.tar $pkg/
      RC=$?
   done
fi

tar -C / -xf $pkg/content.tar




