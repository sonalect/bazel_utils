"""Extract one plugin binary from a release zip with the hermetic bsdtar.

Bazel 9.2's zip reader crashes (ArrayIndexOutOfBoundsException) on zip
comments such as protobuf-go's Windows releases, so `protoc.plugin` only
downloads zips and this build action extracts the binary. bsdtar comes from
the tar.bzl toolchain for the exec platform; nothing on the host is used.
"""

_TAR_TOOLCHAIN_TYPE = "@tar.bzl//tar/toolchain:type"

_REGEX_SPECIAL = "\\.^$*+?()[]{}|,"

def _regex_escape(s):
    return "".join(["\\" + c if c in _REGEX_SPECIAL else c for c in s.elems()])

def _plugin_unzip_impl(ctx):
    tar = ctx.toolchains[_TAR_TOOLCHAIN_TYPE].tarinfo
    out = ctx.actions.declare_file(ctx.attr.out)
    member = ctx.attr.member
    args = ctx.actions.args()
    args.add("-x")
    args.add("-f", ctx.file.archive)
    args.add("-C", out.dirname)
    if member != out.basename:
        # Rename `strip_prefix/bin` to the declared output name.
        args.add("-s", ",^{}$,{},".format(_regex_escape(member), out.basename))
    args.add(member)
    ctx.actions.run(
        executable = tar.binary,
        arguments = [args],
        inputs = [ctx.file.archive],
        outputs = [out],
        env = tar.default_env,
        mnemonic = "PluginUnzip",
        progress_message = "Extracting %{output}",
        toolchain = _TAR_TOOLCHAIN_TYPE,
    )
    return [DefaultInfo(
        executable = out,
        files = depset([out]),
    )]

plugin_unzip = rule(
    implementation = _plugin_unzip_impl,
    doc = "One file from a zip, extracted with the tar.bzl bsdtar toolchain.",
    attrs = {
        "archive": attr.label(
            allow_single_file = [".zip"],
            mandatory = True,
            doc = "Downloaded release zip (sha256-checked by the repository rule).",
        ),
        "member": attr.string(
            mandatory = True,
            doc = "Path of the binary inside the zip (`strip_prefix/bin` or `bin`).",
        ),
        "out": attr.string(
            mandatory = True,
            doc = "Output path in this package (`<platform>/<bin>`).",
        ),
    },
    executable = True,
    toolchains = [_TAR_TOOLCHAIN_TYPE],
)
