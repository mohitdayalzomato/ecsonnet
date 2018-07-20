{
  new(
    family,
    taskDefinitionArn=null,
    taskRoleArn=null,
    executionRoleArn=null,
    networkMode=null,
    volumes=[],
    placementConstraints=[],
    containerDefinitions=[],
    memory=null,
    cpu=null,
    links=null,
  ):: {
    family: family,
    taskRoleArn: taskRoleArn,
    executionRoleArn: executionRoleArn,
    networkMode: networkMode,
    volumes: volumes,
    placementConstraints: placementConstraints,
    containerDefinitions: containerDefinitions,
    memory: memory,
    cpu: cpu,
    links: links,
    addVolume(name, sourcePath):: self {
      volumes+: [{
        name: name,
        host: {
          sourcePath: sourcePath,
        },
      }],
    },
    addPlacementConstraint(type='memberOf', expression):: self {
      placementConstraints+: [{
        type: type,
        expression: expression,
      }],
    },
    addContainerDefinition(definition):: self {
      containerDefinitions+: [definition],
    },
  },
}
