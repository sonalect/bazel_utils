"""Windows support for the bash wrapper scripts and shell actions.

Bazel on Windows only runs files with an executable extension, and
`ctx.actions.run_shell` needs a host bash. On Windows these helpers use the
busybox-w32 binary that `bazel_utils_core` downloads instead (`//:busybox`):
test/run wrappers get a `.bat` launcher that runs the script with
`busybox sh`, and shell actions run `busybox sh <script>`. Linux and macOS
keep the system bash. Scripts must therefore also run under busybox ash.
"""

load("@bazel_lib//lib:windows_utils.bzl", "BATCH_RLOCATION_FUNCTION")
load("//internal:runfiles.bzl", "rlocation")

# For rules whose executable is a bash wrapper (see `launcher`).
LAUNCHER_ATTRS = {
    "_busybox": attr.label(
        default = Label("//:busybox"),
        allow_files = True,
        cfg = "target",
        doc = "busybox-w32 when the target is Windows, empty elsewhere.",
    ),
}

# For rules that call `run_shell_action`.
SHELL_ACTION_ATTRS = {
    "_busybox_exec": attr.label(
        default = Label("//:busybox"),
        allow_files = True,
        cfg = "exec",
        doc = "busybox-w32 when the exec platform is Windows, empty elsewhere.",
    ),
}

def launcher(ctx, script):
    """What Bazel runs for the bash wrapper `script`.

    The rule must have LAUNCHER_ATTRS.

    Args:
      ctx: Rule context.
      script: The wrapper script (must also be in the rule's runfiles).

    Returns:
      struct(executable, files): `script` and no files off Windows; on Windows
      a sibling `.bat` and the busybox binary to add to runfiles.
    """
    busybox = ctx.files._busybox
    if not busybox:
        return struct(executable = script, files = [])
    bat = ctx.actions.declare_file(
        script.basename.removesuffix(".bash") + ".bat",
        sibling = script,
    )
    ws = ctx.workspace_name
    ctx.actions.write(
        output = bat,
        content = "\r\n".join(r"""@echo off
setlocal enableextensions enabledelayedexpansion
set RUNFILES_MANIFEST_ONLY=1
{rlocation_function}
call :rlocation "{busybox}" busybox
call :rlocation "{script}" script
set "busybox=!busybox:/=\!"
setlocal disabledelayedexpansion
"%busybox%" sh "%script%" %*
exit /b %ERRORLEVEL%
""".format(
            busybox = rlocation(busybox[0], ws),
            rlocation_function = BATCH_RLOCATION_FUNCTION,
            script = rlocation(script, ws),
        ).splitlines()) + "\r\n",
        is_executable = True,
    )
    return struct(executable = bat, files = busybox)

def run_shell_action(ctx, *, command, inputs, outputs, tools = [], **kwargs):
    """`ctx.actions.run_shell` that uses busybox on a Windows exec platform.

    The rule must have SHELL_ACTION_ATTRS.

    Args:
      ctx: Rule context.
      command: Shell script text.
      inputs: List or depset of input Files.
      outputs: Output Files.
      tools: Tools, as for run_shell.
      **kwargs: mnemonic, progress_message, env, use_default_shell_env,
        execution_requirements (same meaning as run_shell).
    """
    busybox = ctx.files._busybox_exec
    if not busybox:
        ctx.actions.run_shell(
            command = command,
            inputs = inputs,
            outputs = outputs,
            tools = tools,
            **kwargs
        )
        return
    script = ctx.actions.declare_file("{}.{}.sh".format(
        ctx.label.name,
        kwargs.get("mnemonic", "Shell"),
    ))
    ctx.actions.write(output = script, content = command)
    if type(inputs) == "depset":
        all_inputs = depset([script], transitive = [inputs])
    else:
        all_inputs = [script] + list(inputs)
    ctx.actions.run(
        executable = busybox[0],
        arguments = ["sh", script.path],
        inputs = all_inputs,
        outputs = outputs,
        tools = tools,
        **kwargs
    )
