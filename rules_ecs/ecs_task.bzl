def _get_runfile_path(ctx, f):
  """Return the runfiles relative path of f."""
  if ctx.workspace_name:
    return ctx.workspace_name + "/" + f.short_path
  else:
    return f.short_path

def _runfiles(ctx, f):
  return "${RUNFILES}/%s" % _get_runfile_path(ctx, f)

def _ecs_task(ctx):
  service_def_arg = ctx.file.src.short_path
  service_def_arg = ctx.expand_make_variables("taskDefinition", service_def_arg, {})

  substitutions = {
      "%{taskDefinition}": service_def_arg,
  }

  ctx.actions.expand_template(
      template = ctx.file._template,
      substitutions = substitutions,
      output = ctx.outputs.executable,
  )
  return [DefaultInfo(
    runfiles=ctx.runfiles(files=ctx.files.src),
    )]

_ecs_task_register = rule(
    attrs = {
            "resolved": attr.label(
                cfg = "target",
                executable = True,
                allow_files = True,
            ),
            "_template": attr.label(
                default = Label("//rules/ecs:task.register.sh.tpl"),
                single_file = True,
                allow_files = True,
            ),
            "src": attr.label(allow_single_file=True),
            "task_family": attr.string(),
            "task_revision": attr.int(),
      },
    executable = True,
    implementation = _ecs_task,
)

_ecs_task_deregister = rule(
    attrs = {
            "resolved": attr.label(
                cfg = "target",
                executable = True,
                allow_files = True,
            ),
            "_template": attr.label(
                default = Label("//rules/ecs:task.deregister.sh.tpl"),
                single_file = True,
                allow_files = True,
            ),
            "src": attr.label(allow_single_file=True),
      },

    executable = True,
    implementation = _ecs_task,
)


def ecs_task(name, src, **kwargs):
    _ecs_task_register(name=name + ".register",
                       resolved=name,
                       src=src,
                       visibility=kwargs.get("visibility"))
    _ecs_task_deregister(name=name + ".deregister",
                       resolved=name,
                       src=src,
                       visibility=kwargs.get("visibility"))
