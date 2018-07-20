#!/bin/bash
set -euo pipefail

target=$PWD/%{taskDefinition}
aws ecs register-task-definition --cli-input-json file://$target
