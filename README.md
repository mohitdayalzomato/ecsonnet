# github.com/dan-compton/ecsonnet

This repository contains
* A collection of JSONNET libraries which describe ECS service, task, and container definitions.
* A collection of bazel rules (rules_ecs) for ECS service creation and deletion as well as task registration.

## rules_ecs

`rules_ecs` is a collection of bazel rules for working with ecs services and tasks.

### Service Creation

To create a service in ECS add the following to your BUILD.bazel in the package
that contains your ecs service definition JSONNET (e.g. `examples/`):

```
ecs_service(
    name = "example_service",
    src = ":example_service_def",
    cluster_arn = "arn:aws:ecs:us-west-2:000000000000:cluster/your-cluster",
    visibility = ["//visibility:public"],
)
```
_Note: `cluster_arn=` must be adjusted to point to the target ECS cluster and `src=` must point to the label of the jsonnet_to_json rule which builds your service definition._

Ensure that a task is registered for your service, then run: `bazel run //examples:example_service.create`


### Task Creation

To register a new task definition in ECS add the following to your BUILD.bazel in the package
that contains your ecs service definition JSONNET (e.g. `examples/`):

```
ecs_task(
    name = "example_task",
    src = ":example_task_def",
    visibility = ["//visibility:public"],
)
```
_Note: src= must point to the label of the jsonnet_to_json rule which builds your task definition._

Run `bazel run //examples:example_task.create`

## Building The Examples

**Option 1**: Build with bazel by running `bazel build //examples/...`

**Option 2**: Simply run `jsonnet exampleYouWantToSee.jsonnet` to see the output from a given example.  For example,
we can view the provided sample invocation of taskDefinition by running `jsonnet exampleTaskDefinition.jsonnet`.
The output can be seen below:

```
{
   "compatibilities": [
      "EC2"
   ],
   "containerDefinitions": [
      {
         "cpu": 0,
         "environment": [ ],
         "essential": true,
         "image": "library/debian",
         "links": [ ],
         "logConfiguration": {
            "logDriver": "awslogs"
         },
         "mountPoints": [ ],
         "name": "service",
         "portMappings": [
            {
               "containerPort": "80",
               "hostPort": "80",
               "protocol": "tcp"
            }
         ],
         "volumesFrom": [ ]
      },
      {
         "cpu": 0,
         "entryPoint": [
            "/bin/bash"
         ],
         "environment": [ ],
         "essential": true,
         "image": "library/ubuntu",
         "links": [ ],
         "logConfiguration": {
            "logDriver": "json-file"
         },
         "memoryReservation": 2048,
         "mountPoints": [ ],
         "name": "service2",
         "portMappings": [
            {
               "containerPort": "80",
               "hostPort": "80",
               "protocol": "tcp"
            }
         ],
         "volumesFrom": [ ]
      }
   ],
   "family": "family_name",
   "placementConstraints": [ ],
   "requiresAttributes": [ ],
   "revision": 0,
   "status": "ACTIVE",
   "volumes": [ ]
}
```
