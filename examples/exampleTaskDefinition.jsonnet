local ecs = import 'ecs/ecs.libsonnet';

local exampleTaskDefinition = ecs.taskDefinition.new(
  family='family_name',
  containerDefinitions=[
    ecs.containerDefinition.new('service', 'library/debian').addPortMapping('80', '80', 'tcp'),
    ecs.containerDefinition.new(
      name='service2',
      image='library/ubuntu',
      memoryReservationMb=2048,
      entryPoint=['/bin/bash'],
      logConfiguration={
        logDriver: 'json-file',
      },
    ).addPortMapping('80', '80', 'tcp'),
  ]
);

ecs.pruneDefinition(exampleTaskDefinition)
