#!/bin/sh

docker ps -a -f status=exited | grep -v -e backing -e data | awk '$1 ~ /[0-9a-f]{12}/ { print $1 ; }' | xargs docker rm
docker images | awk '$1~/<none>/ && $3~/[0-9a-f]{12}/ { print $3 ; }' | xargs docker rmi

