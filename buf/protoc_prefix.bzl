"""Unix-layout prefix from the resolved proto toolchain's protoc.

Never depend on @protobuf//:protoc — that cc_binary compiles protoc from source.
Protobuf 33.4+ registers a GitHub prebuilt on
@protobuf//bazel/private:proto_toolchain_type when prefer_prebuilt_protoc is
true (the default). protobuf publishes no Windows ARM64 protoc; for that exec
platform this module registers the x64 build (`MODULE.bazel`), which Windows 11
on ARM emulates.
"""

load("@bazel_utils_core//internal:launcher.bzl", "SHELL_ACTION_ATTRS", "run_shell_action")

_PROTO_TOOLCHAIN_TYPE = "@protobuf//bazel/private:proto_toolchain_type"

def _protoc_prefix_impl(ctx):
    toolchain = ctx.toolchains[_PROTO_TOOLCHAIN_TYPE]
    if not toolchain:
        fail("{}: no proto toolchain registered".format(ctx.label))
    compiler = toolchain.proto.proto_compiler
    protoc = compiler.executable
    if not protoc:
        fail("{}: proto toolchain has no proto_compiler".format(ctx.label))
    if not protoc.is_source:
        fail(("{}: the proto toolchain resolved to a protoc compiled from source ({}). " +
              "No prebuilt protoc matches this exec platform.").format(ctx.label, protoc.path))

    out = ctx.actions.declare_directory(ctx.label.name)
    copies = [
        'cp "{}" "$OUT/include/google/protobuf/{}"'.format(src.path, src.basename)
        for src in ctx.files.wkts
    ]
    run_shell_action(
        ctx,
        outputs = [out],
        inputs = depset(direct = [protoc] + ctx.files.wkts),
        tools = [compiler],
        command = "\n".join([
            "set -eu",
            'OUT="{}"'.format(out.path),
            'mkdir -p "$OUT/bin" "$OUT/include/google/protobuf"',
            'cp "{}" "$OUT/bin/protoc"'.format(protoc.path),
            "chmod +x \"$OUT/bin/protoc\"",
        ] + (['cp "{}" "$OUT/bin/protoc.exe"'.format(protoc.path)] if protoc.extension == "exe" else []) + copies),
        mnemonic = "ProtocPrefix",
        progress_message = "Staging prebuilt protoc prefix %{label}",
    )
    return [DefaultInfo(files = depset([out]))]

protoc_prefix = rule(
    implementation = _protoc_prefix_impl,
    attrs = {
        "wkts": attr.label_list(
            allow_files = [".proto"],
            mandatory = True,
            doc = "google.protobuf WKT .proto files (filegroups, not compiled C++).",
        ),
    } | SHELL_ACTION_ATTRS,
    toolchains = [_PROTO_TOOLCHAIN_TYPE],
)
