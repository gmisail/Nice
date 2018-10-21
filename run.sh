#!/usr/bin/env bash

if [ $1 = 'dev' ]
then
    echo 'Building development version...'
    haxe dev.hxml
    cd bin
    neko nice.n build
else
    echo 'Building release version...'
    haxe build.hxml
fi

echo 'Done.'