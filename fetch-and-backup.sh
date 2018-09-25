#!/usr/bin/env bash

VER=$(curl -sSL dl.k8s.io/release/stable.txt | cut -f2 -d'.')

if [ $VER = '11' ];then

    lines=`cat ./images/11.txt`;

    for line in $lines; do docker pull "$line"; done

    docker images | tail -n +2 | grep -v "<none>" | awk '{printf("%s:%s\n", $1, $2)}' | while read IMAGE; do
        echo "find image: $IMAGE"
        filename="$(echo $IMAGE| tr ':' '-' | tr '/' '-').tar"
        echo "save as $filename"
        docker save ${IMAGE} -o $filename
    done

fi;
