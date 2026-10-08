"""Workspace uv audit: audit the locked Python deps in the consumer uv.lock."""

load("@bazel_skylib//lib:shell.bzl", "shell")
load("@bazel_utils_core//internal:launcher.bzl", "LAUNCHER_ATTRS", "launcher")
load("@bazel_utils_core//internal:workspace_tool.bzl", "append_workspace_file", "lock_label", "manifest_label", "workspace_test_tags", "wrapper_script_header")

def _impl(ctx):
    uv = ctx.file.uv
    if not uv:
        fail("{}: uv {} is missing".format(ctx.label, ctx.attr.uv.label))

    flags = " ".join([shell.quote(a) for a in ctx.attr.flags])
    chunks = wrapper_script_header(
        ctx,
        binaries = [["uv", uv]],
        workspace = ctx.file.workspace,
    )
    append_workspace_file(chunks, ctx, ctx.file.lock, "lock", "lock")
    append_workspace_file(chunks, ctx, ctx.file.manifest, "manifest", "manifest")
    chunks.append("".join([
        'cd "$(dirname "$lock")"\n',
        # The audit reads uv.lock only: no Python is needed, so never fetch one.
        'export UV_CACHE_DIR="${TEST_TMPDIR:-${TMPDIR:-/tmp}}/uv-audit-cache"\n',
        "export UV_PYTHON_DOWNLOADS=never\n",
        # `uv audit` is a preview feature in uv 0.12; opting in also silences
        # the warning. The uv version is pinned in this module's MODULE.bazel.
        'exec "$uv" audit --frozen --preview-features audit-command {flags} "$@"\n'.format(
            flags = flags,
        ),
    ]))

    script = ctx.actions.declare_file(ctx.label.name + ".bash")
    ctx.actions.write(
        output = script,
        content = "".join(chunks),
        is_executable = True,
    )

    run = launcher(ctx, script)
    runfiles = ctx.runfiles(files = [
        script,
        run.executable,
        uv,
        ctx.file.workspace,
        ctx.file.lock,
        ctx.file.manifest,
    ] + run.files)
    runfiles = runfiles.merge(ctx.attr.uv[DefaultInfo].default_runfiles)
    return [DefaultInfo(
        executable = run.executable,
        files = depset([run.executable]),
        runfiles = runfiles,
    )]

_uv_audit_test = rule(
    implementation = _impl,
    test = True,
    attrs = {
        "flags": attr.string_list(
            doc = "uv audit arguments after `audit --frozen` (e.g. `--ignore`, `--no-dev`).",
        ),
        "lock": attr.label(
            mandatory = True,
            allow_single_file = True,
            doc = "Consumer uv.lock to audit.",
        ),
        "manifest": attr.label(
            mandatory = True,
            allow_single_file = True,
            doc = "Consumer pyproject.toml next to uv.lock (the uv project root).",
        ),
        "uv": attr.label(
            default = Label("@uv//:uv"),
            allow_single_file = True,
            cfg = "exec",
            doc = "uv binary pinned in this module's uv_bin.toolchain (override to use another).",
        ),
        "workspace": attr.label(
            mandatory = True,
            allow_single_file = True,
            doc = "Repo-root marker used when BUILD_WORKSPACE_DIRECTORY is unset.",
        ),
    } | LAUNCHER_ATTRS,
    doc = "bazel test: uv audit against the locked deps (no-sandbox, needs OSV).",
)

def uv_audit_test(
        name,
        workspace = "//:MODULE.bazel",
        lock = "//:uv.lock",
        manifest = "//:pyproject.toml",
        tags = [],
        flags = [],
        local = True,
        **kwargs):
    """Test that runs bazel_utils's uv `audit` against the consumer lockfile.

    `uv audit --frozen` reads `lock` (all dependency groups and extras) and
    queries OSV. It needs no Python interpreter. Defaults `local = True` and
    tags `external`, `no-cache`, `no-sandbox`, `requires-network`.

    Args:
      name: Target name.
      workspace: Repo-root marker file (used when BUILD_WORKSPACE_DIRECTORY is unset).
      lock: Consumer uv.lock (default `//:uv.lock`).
      manifest: Consumer pyproject.toml next to the lock (default `//:pyproject.toml`).
      tags: Extra tags; merged with the defaults above.
      flags: Extra uv audit flags after `audit --frozen`.
      local: Run outside the sandbox (default True).
      **kwargs: Forwarded to the test rule (`uv`, `size`, …).
    """
    _uv_audit_test(
        name = name,
        workspace = workspace,
        lock = lock_label(lock),
        manifest = manifest_label(manifest),
        tags = workspace_test_tags(tags, requires_network = True),
        flags = flags,
        local = local,
        **kwargs
    )
