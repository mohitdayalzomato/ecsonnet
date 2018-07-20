#!/bin/bash
set -euo pipefail

target=$PWD/%{serviceDefinition}
echo "TARGET=$target"
aws ecs create-service --cli-input-json file://$target
