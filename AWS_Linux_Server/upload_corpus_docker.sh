#!/usr/bin/env bash
set -e

sudo cp /opt/uam-uav-models/ExportedGraphML/*.graphml /opt/NewDeploy/graph_ml/.
docker cp /opt/NewDeploy/graph_ml/. jce-jg:/opt/janusgraph/corpus/
