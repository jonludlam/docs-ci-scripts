#!/bin/bash

set -e
set -x

host=$1   # gamma
dir=$2    # /data/data/
pkg=$3    # prep0/u/745d6c5e6ba222bcc493e3bdedc73465/cmdliner/1.3.0/
cache=$4  # 'true' or 'false'

echo "Downloading prep package $pkg from $host enable_cache=$cache"

if [ "$cache" = "true" ]; then 
  cd /home/opam/.cache/prep
else
  cd /tmp/
fi

if [ ! -d $pkg/home ]; then
   mkdir -p $pkg
   RC=1 
   while [[ $RC -ne 0 ]]
   do
      rsync -av $host:$dir/$pkg/content.tar $pkg/
      RC=$?
   done
   pushd $pkg
   tar xf content.tar
   rm -f content.tar
   popd
fi

cd $pkg
rm -f content.tar

sudo rsync -av . /

#for dir in $(find . -type d); do
#  mkdir -p /$dir
#done
#
#pwd=$(pwd)
#for file in $(find . -type f); do
#  ln -s $pwd/$file /$file || true
#done






