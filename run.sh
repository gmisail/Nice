#!/usr/bin/env bash

if [[ $1 = 'dev' ]]
then
    echo '[Nice-Dev] Building development version...'
    haxe dev.hxml
    cd bin
    neko nice.n build
else
    echo '[Nice-Dev] Building release version...'
    haxe build.hxml
fi

echo '[Nice-Dev] Done.'