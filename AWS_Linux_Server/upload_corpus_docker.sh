#!/usr/bin/env bash
set -e

docker cp /opt/NewDeploy/graph_ml/. jce-jg:/opt/janusgraph/corpus/
