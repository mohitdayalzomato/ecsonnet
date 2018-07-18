# github.com/dan-compton/ecsonnet

This repository contains a collection of JSONNET libraries which describe ECS service, task, and container definitions.


# Examples

Simply run `jsonnet exampleYouWantToSee.jsonnet` to see the output from a given example.  For example,
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
