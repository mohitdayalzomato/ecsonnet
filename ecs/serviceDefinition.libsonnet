{
  new(
    cluster,
    serviceName,
    taskDefinition,
    desiredCount=0,
    healthCheckGracePeriodSeconds=0,
    schedulingStrategy='REPLICA',
    loadBalancers=[],
    serviceRegistries=[],
    clientToken=null,
    launchType='EC2',
    platformVersion=null,
    role=null,
    deploymentConfiguration={},
    networkConfiguration={},
    placementConstraints=[],
    placementStrategy=[]
  ):: {
    cluster: cluster,
    serviceName: serviceName,
    loadBalancers: if loadBalancers == [] then null else loadBalancers,
    serviceRegistries: if serviceRegistries == [] then null else serviceRegistries,
    taskDefinition: taskDefinition,
    desiredCount: desiredCount,
    clientToken: clientToken,
    launchType: launchType,
    platformVersion: platformVersion,
    role: role,
    deploymentConfiguration: if deploymentConfiguration == {} then null else deploymentConfiguration,
    networkConfiguration: if networkConfiguration == [] then null else networkConfiguration,
    placementConstraints: if placementConstraints == [] then null else placementConstraints,
    placementStrategy: if placementStrategy == [] then null else placementStrategy,
    healthCheckGracePeriodSeconds:
      // healthCheckGracePeriod is not valid if no loadBalancers are configured.
      if self.loadBalancers == [] || self.loadBalancers == null then
        null
      else
        healthCheckGracePeriodSeconds,
    schedulingStrategy: schedulingStrategy,
  },
}
