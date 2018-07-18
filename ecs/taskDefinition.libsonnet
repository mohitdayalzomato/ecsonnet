{
  new(
    family,
    revision=0,
    taskDefinitionArn=null,
    taskRoleArn=null,
    executionRoleArn=null,
    networkMode=null,
    volumes=[],
    placementConstraints=[],
    requiresAttributes=[],
    containerDefinitions=[],
    memory=null,
    cpu=null,
    links=null,
    status='ACTIVE',
    compatibilities=['EC2'],
  ):: {
    family: family,
    taskRoleArn: taskRoleArn,
    revision: revision,
    executionRoleArn: executionRoleArn,
    networkMode: networkMode,
    volumes: volumes,
    placementConstraints: placementConstraints,
    containerDefinitions: containerDefinitions,
    memory: memory,
    cpu: cpu,
    status: status,
    links: links,
    compatibilities: compatibilities,
    requiresAttributes: requiresAttributes,
    addRequiredAttribute(name, targetId=null, targetType=null, value=null):: self {
      requiresAttributes+: [{
        targetId: targetId,
        targetType: targetType,
        value: value,
        name: name,
      }],
    },
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
