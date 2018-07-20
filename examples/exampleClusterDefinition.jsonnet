local ecs = import 'ecs/ecs.libsonnet';

local exampleClusterDefinition = ecs.cluster.definition.new(
  clusterName='cluster-name',
);

ecs.pruneDefinition(exampleClusterDefinition)
