local ecs = import 'ecs/ecs.libsonnet';

local exampleServiceDefinition = ecs.serviceDefinition.new(
  serviceName='service-name',
  cluster='arn:aws:ecs:us-west-2:0000000000000:cluster/cluster-name',
  desiredCount=1,
  launchType='EC2',
  taskDefinition='arn:aws:ecs:us-west-2:000000000000:task-definition/service-name',
  placementStrategy=[
    {
      type: 'spread',
      field: 'attribute:ecs.availability-zone',
    },
    {
      type: 'spread',
      field: 'instanceId',
    },
  ]
);

ecs.pruneDefinition(exampleServiceDefinition)
