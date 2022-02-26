#!/usr/bin/env bash
set -e

docker stop jenkins
docker stop jce-jg jce-es jce-cql
docker stop minio-server
#docker volume prune -f
