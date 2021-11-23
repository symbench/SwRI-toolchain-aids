#!/usr/bin/env bash
set -e

docker restart jenkins
docker restart jce-jg jce-es jce-cql
docker restart minio-server