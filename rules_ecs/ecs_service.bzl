def _get_runfile_path(ctx, f):
  """Return the runfiles relative path of f."""
  if ctx.workspace_name:
    return ctx.workspace_name + "/" + f.short_path
  else:
    return f.short_path

def _runfiles(ctx, f):
  return "${RUNFILES}/%s" % _get_runfile_path(ctx, f)

def _ecs_service(ctx):
  service_def_arg = ctx.file.src.short_path
  service_def_arg = ctx.expand_make_variables("serviceDefinition", service_def_arg, {})

  cluster_arn_arg = ctx.attr.cluster_arn
  cluster_arn_arg = ctx.expand_make_variables("clusterArn", cluster_arn_arg, {})

  substitutions = {
      "%{serviceDefinition}": service_def_arg,
      "%{clusterArn}": cluster_arn_arg,
  }

  ctx.actions.expand_template(
      template = ctx.file._template,
      substitutions = substitutions,
      output = ctx.outputs.executable,
  )
  return [DefaultInfo(
    runfiles=ctx.runfiles(files=ctx.files.src),
    )]

_ecs_service_create = rule(
    attrs = {
            "resolved": attr.label(
                cfg = "target",
                executable = True,
                allow_files = True,
            ),
            "_template": attr.label(
                default = Label("//rules/ecs:service.create.sh.tpl"),
                single_file = True,
                allow_files = True,
            ),
            "src": attr.label(allow_single_file=True),
            "cluster_arn": attr.string(),
      },
    executable = True,
    implementation = _ecs_service,
)

_ecs_service_delete = rule(
    attrs = {
            "resolved": attr.label(
                cfg = "target",
                executable = True,
                allow_files = True,
            ),
            "_template": attr.label(
                default = Label("//rules/ecs:service.delete.sh.tpl"),
                single_file = True,
                allow_files = True,
            ),
            "src": attr.label(allow_single_file=True),
            "cluster_arn": attr.string(),
      },

    executable = True,
    implementation = _ecs_service,
)


def ecs_service(name, src, **kwargs):
    _ecs_service_create(name=name + ".create",
                       resolved=name,
                       src=src,
                       cluster_arn=kwargs.get("cluster_arn"),
                       visibility=kwargs.get("visibility"))
    _ecs_service_delete(name=name + ".delete",
                       resolved=name,
                       src=src,
                       cluster_arn=kwargs.get("cluster_arn"),
                       visibility=kwargs.get("visibility"))
