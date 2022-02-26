#!/usr/bin/env bash
set -e

docker stop jce-jg jce-es jce-cql
docker rm jce-jg jce-es jce-cql
docker volume prune -f
docker network prune -f
