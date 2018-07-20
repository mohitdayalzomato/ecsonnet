local ecs = import 'ecs/ecs.libsonnet';

local exampleTaskDefinition = ecs.task.definition.new(
  family='family_name',
  containerDefinitions=[
    ecs.container.definition.new('service', 'library/debian').addPortMapping('80', '80', 'tcp'),
    ecs.container.definition.new(
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
