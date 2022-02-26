#!/usr/bin/env bash
set -e

docker stop jenkins
docker rm jenkins
docker stop minio-server
docker rm minio-server
./kill-janusgraph-docker.sh
