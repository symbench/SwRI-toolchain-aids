#!/usr/bin/env bash
set -e

sudo systemctl start docker
docker volume list
docker volume prune -f
docker volume list
docker network prune -f

docker volume create --driver local --name=jg-corpus-data
docker volume create --driver local --name=jg-product-data
docker volume create --driver local --name=jg-cql-data
docker volume create --driver local --name=jg-es-data

set DOCKER_VOL_PATH='/opt/docker-volumes'

docker network create --driver bridge jg-network

docker-compose -f /opt/NewDeploy/docker/jenkins-pipeline/docker-compose.yaml up -d
docker-compose -f /opt/NewDeploy/docker/janusgraph-cql-es-dynamic/docker-compose.yaml up --build --force-recreate -d
#docker-compose -f /opt/NewDeploy/docker/minio/docker-compose.yaml up -d
docker run -d --name minio-server -p 9000:9000 -p 9001:9001 -v /opt/minioData:/data --env MINIO_ACCESS_KEY="symcps" --env MINIO_SECRET_KEY="symcps2021" minio/minio server /data --console-address ":9001"
echo "Dockers started"

SETUP_IP="10.55.25.48"
CURRENT_IP=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
sleep 10
docker exec -d jenkins sed -i "s/$SETUP_IP/$CURRENT_IP/g" /var/jenkins_home/jenkins.model.JenkinsLocationConfiguration.xml
echo "Updated Jenkins URL to: $CURRENT_IP"
#echo "After about 5 mins, run './upload_corpus_docker.sh' to upload the graph database"
