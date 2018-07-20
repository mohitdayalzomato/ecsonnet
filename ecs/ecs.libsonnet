{
  task:: {
    definition: import 'taskDefinition.libsonnet',
  },
  container:: {
    definition: import 'containerDefinition.libsonnet',
  },
  service:: {
    definition: import 'serviceDefinition.libsonnet',
  },
  cluster:: {
    definition: import 'clusterDefinition.libsonnet',
  },
  // pruneDefinition exposes the same behavior as std.prune --
  // (removes empty values) but preserves empty _arrays_.
  //
  // Run this against service, task, and container definitions
  // prior to submitting the JSON to the ECS API.
  pruneDefinition(a)::
    local isContent(b) =
      local t = std.type(b);
      if b == null then
        false
      else if t == 'array' then
        std.length(b) >= 0
      else if t == 'object' then
        std.length(b) > 0
      else
        true;
    local t = std.type(a);
    if t == 'array' then
      if std.length(a) == 0 then
        a
      else
        [$.pruneDefinition(x) for x in a if isContent($.pruneDefinition(x))]
    else if t == 'object' then {
      [x]: $.pruneDefinition(a[x])
      for x in std.objectFields(a)
      if isContent($.pruneDefinition(a[x]))
    } else
      a,
}
