#!/bin/sh

current=$(date +%y.%m)
version=${1:-$current}

docker build \
    --build-arg VERSION=$version \
    --build-arg VCS_REF=`git rev-parse --short HEAD` \
    --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
    -t kitwts_ejabberd/ecs:$version .

[ "$version" = "latest" ] || docker tag kitwts_ejabberd/ecs:$version kitwts_ejabberd/ecs:latest
