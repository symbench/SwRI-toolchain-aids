#!/usr/bin/env bash
set -e

docker stop jenkins
docker rm jenkins
docker stop jce-jg jce-es jce-cql
docker rm jce-jg jce-es jce-cql
docker stop minio-server
docker rm minio-server
docker volume prune -f