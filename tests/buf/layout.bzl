"""Build-time check of the file layout a buf_generate output holds."""

load("@bazel_utils_core//internal:launcher.bzl", "SHELL_ACTION_ATTRS", "run_shell_action")

def _generate_layout_check_impl(ctx):
    tree = ctx.file.generated
    ok = ctx.actions.declare_file(ctx.label.name + ".ok")
    lines = ["set -eu"]
    for path in ctx.attr.files:
        lines.append('[ -f "{tree}/{path}" ] || {{ echo "{label}: {path} is missing from the output" >&2; exit 1; }}'.format(
            tree = tree.path,
            path = path,
            label = ctx.label,
        ))
    lines.append('echo ok > "{}"'.format(ok.path))
    run_shell_action(
        ctx,
        command = "\n".join(lines),
        inputs = [tree],
        outputs = [ok],
        mnemonic = "BufLayoutCheck",
        progress_message = "Checking the layout of {}".format(tree.short_path),
    )
    return [DefaultInfo(files = depset([ok]))]

generate_layout_check = rule(
    implementation = _generate_layout_check_impl,
    attrs = dict(
        SHELL_ACTION_ATTRS,
        generated = attr.label(
            mandatory = True,
            allow_single_file = True,
            doc = "A buf_generate target.",
        ),
        files = attr.string_list(
            mandatory = True,
            doc = "Paths, relative to the output, of files that must exist.",
        ),
    ),
    doc = "Fails the build unless every listed file is in the buf_generate output.",
)
