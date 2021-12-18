#!/usr/bin/env bash
set -e

docker-compose -f /opt/NewDeploy/docker/jenkins-pipeline/docker-compose.yaml up -d
docker-compose -f /opt/NewDeploy/docker/janusgraph-cql-es/docker-compose.yaml up -d
docker-compose -f /opt/NewDeploy/docker/minio/docker-compose.yaml up -d
SETUP_IP="<saved linux server IP>"
CURRENT_IP=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
sleep 10
docker exec -d jenkins sed -i "s/$SETUP_IP/$CURRENT_IP/g" /var/jenkins_home/jenkins.model.JenkinsLocationConfiguration.xml
echo "Updated Jenkins URL to $CURRENT_IP"
