#!/bin/bash

set -e
set -x

host=$1   # gamma
dir=$2    # /data/data/
pkg=$3    # compile/p/csexp/1.5.2 
epoch=$4  # <hash>
cache=$5  # 'true' or 'false'

echo "Downloading compiled pkg $pkg from $host enable_cache=$cache"

if [ "$cache" = "true" ]; then
  ldir=/home/opam/.cache/
else
  ldir=/tmp/
fi

cd $ldir

mkdir -p /home/opam/docs/$(dirname $pkg)
ln -sf $ldir$pkg /home/opam/docs/$(dirname $pkg)

if [ -f $pkg/.epoch ]; then
	if [[ $(< $pkg/.epoch) == "$epoch" ]]; then
		exit 0
	else
		rm -rf $pkg/*
	fi
fi

mkdir -p /tmp/pkgs

RC=1 
while [[ $RC -ne 0 ]]
do
   rsync -avR $host:$dir/$pkg /tmp/pkgs/
   RC=$?
done

tar xvf /tmp/pkgs/$dir/$pkg/content.tar 
echo $epoch > $pkg/.epoch
rm -rf /tmp/pkgs



