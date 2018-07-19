local ecs = import 'ecs/ecs.libsonnet';

local exampleContainerDefinition = ecs.containerDefinition.new('service', 'img').addPortMapping('80', '80', 'tcp');

ecs.pruneDefinition(exampleContainerDefinition)
