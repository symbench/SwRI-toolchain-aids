#!/usr/bin/env bash
set -e

docker-compose -f /opt/NewDeploy/docker/jenkins-pipeline/docker-compose.yaml up -d
docker-compose -f /opt/NewDeploy/docker/janusgraph-cql-es/docker-compose.yaml up -d
docker-compose -f /opt/NewDeploy/docker/minio/docker-compose.yaml up -d