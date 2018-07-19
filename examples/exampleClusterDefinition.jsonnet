local ecs = import 'ecs/ecs.libsonnet';

local exampleClusterDefinition = ecs.clusterDefinition.new(
  clusterName='cluster-name',
);

ecs.pruneDefinition(exampleClusterDefinition)
