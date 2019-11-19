#!/usr/bin/env bash

if [[ $1 = 'dev' ]] 
then
    echo '[Nice] Building development version...'

    if [[ $2 = 'node' ]]
    then
        echo '[Nice] Target: Node'
        haxe dev.node.hxml
        cd bin
        node nice.js build
    else
        echo '[Nice] Target: Neko'

        haxe dev.hxml
        cd bin
        neko nice.n build
    fi
elif [[ $1 = 'submit' ]]
then
    haxelib run submit
else
    echo '[Nice] Building release version...'

    haxe build.node.hxml
    echo '[Nice] Node ✔️'
    haxe build.hxml
    echo '[Nice] Neko ✔️'
    echo '[Nice] Done.'
fi
