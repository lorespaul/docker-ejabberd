#!/bin/sh

current=$(date +%y.%m)
version=${1:-$current}

arguments=( "$@" )

for arg in ${!arguments[@]}
do
    if [ "${arguments[$arg]}" == "--arm" ]; then
        PLATFORM="ARM"
    fi
done

if [ ! -z "$PLATFORM" ];
then
    docker build \
        --build-arg VERSION=$version \
        --build-arg VCS_REF=`git rev-parse --short HEAD` \
        --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
        --platform linux/amd64 \
        -t kitwts_ejabberd/ecs:$version .
else
    docker build \
        --build-arg VERSION=$version \
        --build-arg VCS_REF=`git rev-parse --short HEAD` \
        --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
        -t kitwts_ejabberd/ecs:$version .
fi

[ "$version" = "latest" ] || docker tag kitwts_ejabberd/ecs:$version kitwts_ejabberd/ecs:latest
