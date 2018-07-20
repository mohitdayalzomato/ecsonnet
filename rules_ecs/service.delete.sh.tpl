#!/bin/bash
set -euo pipefail

target=$PWD/%{serviceDefinition}
SERVICE_NAME=$(cat $target | jq -r ".serviceName")
CLUSTER_ARN=%{clusterArn}
aws ecs delete-service --service $SERVICE_NAME --cluster $CLUSTER_ARN --force
