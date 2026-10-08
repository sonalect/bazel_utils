"""protoc.plugin: fetch prebuilt local codegen plugins."""

load("//plugins:defs.bzl", "PLUGINS", "plugin_platforms", "plugin_repo_name", "plugin_url")

_CONSTRAINTS = {
    "linux_amd64": "@bazel_utils_core//:linux_amd64",
    "linux_arm64": "@bazel_utils_core//:linux_arm64",
    "darwin_amd64": "@bazel_utils_core//:darwin_amd64",
    "darwin_arm64": "@bazel_utils_core//:darwin_arm64",
    "windows_amd64": "@bazel_utils_core//:windows_amd64",
    "windows_arm64": "@bazel_utils_core//:windows_arm64",
}

# Bazel 9.2 ZipReader crashes on zip comments (protobuf-go Windows releases),
# so zips are only downloaded here and extracted at build time by
# //plugins:unzip.bzl with the hermetic bsdtar toolchain.
_UNZIP_BZL = str(Label("//plugins:unzip.bzl"))

def _plugin_repo_impl(rctx):
    """Download every platform of the requested plugin; BUILD selects exec OS/CPU."""
    plugin = PLUGINS[rctx.attr.plugin_name]
    platforms = json.decode(rctx.attr.platforms_json)
    files = {}
    unzips = []
    for plat, spec in platforms.items():
        if plat not in _CONSTRAINTS:
            fail("protoc.plugin: unknown platform {} for {}".format(plat, rctx.attr.plugin_name))
        url = plugin_url(plugin, rctx.attr.version, spec)
        dest = "{}/{}".format(plat, spec["bin"])
        if plugin["kind"] == "file":
            rctx.download(
                url = url,
                output = dest,
                sha256 = spec["sha256"],
                executable = True,
            )
        elif plugin["kind"] == "archive":
            strip_prefix = spec.get("strip_prefix", plugin.get("strip_prefix", ""))
            if spec["file"].endswith(".zip"):
                archive = "{}/{}.zip".format(plat, spec["bin"])
                rctx.download(
                    url = url,
                    output = archive,
                    sha256 = spec["sha256"],
                )
                member = spec["bin"]
                if strip_prefix:
                    member = "{}/{}".format(strip_prefix.rstrip("/"), member)
                unzips.append(struct(
                    archive = archive,
                    member = member,
                    name = "{}_bin".format(plat),
                    out = dest,
                ))
                dest = ":{}_bin".format(plat)
            else:
                rctx.download_and_extract(
                    url = url,
                    output = plat,
                    sha256 = spec["sha256"],
                    stripPrefix = strip_prefix,
                )
        else:
            fail("protoc.plugin: unknown kind {} for {}".format(plugin["kind"], rctx.attr.plugin_name))
        files[plat] = dest

    select_lines = []
    for plat in _CONSTRAINTS:
        path = files.get(plat)
        if path:
            select_lines.append('            "{}": "{}",'.format(_CONSTRAINTS[plat], path))

    unzip_targets = "".join([
        """
plugin_unzip(
    name = "{name}",
    archive = "{archive}",
    member = "{member}",
    out = "{out}",
)
""".format(name = u.name, archive = u.archive, member = u.member, out = u.out)
        for u in unzips
    ])

    rctx.file("BUILD.bazel", """\
load("@bazel_skylib//rules:native_binary.bzl", "native_binary")
load("{unzip_bzl}", "plugin_unzip")

package(default_visibility = ["//visibility:public"])
{unzip_targets}
native_binary(
    name = "{name}",
    src = select(
        {{
{select_body}
        }},
        no_match_error = "No prebuilt {name} for this OS/CPU",
    ),
    # Windows only runs files with an executable extension.
    out = select({{
        "@bazel_utils_core//:windows": "{name}.exe",
        "//conditions:default": "{name}.bin",
    }}),
)
""".format(
        name = rctx.attr.plugin_name,
        select_body = "\n".join(select_lines),
        unzip_bzl = _UNZIP_BZL,
        unzip_targets = unzip_targets,
    ))
    rctx.file("REPO.bazel", "")

_plugin_repo = repository_rule(
    implementation = _plugin_repo_impl,
    attrs = {
        "platforms_json": attr.string(),
        "plugin_name": attr.string(),
        "version": attr.string(),
    },
)

_ROOT_PLUGINS_REPO = "protoc_root_plugins"

def _root_plugins_repo_impl(rctx):
    """Aliases and ROOT_PLUGIN_LABELS for the root module's `protoc.plugin` tags."""
    names = json.decode(rctx.attr.names_json)
    aliases = []
    label_lines = []
    for name in names:
        aliases.append("""\
alias(
    name = "{name}",
    actual = "@{repo}//:{name}",
)
""".format(name = name, repo = plugin_repo_name(name)))
        label_lines.append('    "@{}//:{}",'.format(_ROOT_PLUGINS_REPO, name))
    rctx.file("BUILD.bazel", """\
load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

package(default_visibility = ["//visibility:public"])

{aliases}
bzl_library(
    name = "plugins_bzl",
    srcs = ["plugins.bzl"],
)
""".format(aliases = "\n".join(aliases)))
    rctx.file("plugins.bzl", """\
\"\"\"Labels for the root module's `protoc.plugin` tags.\"\"\"

ROOT_PLUGIN_LABELS = [
{labels}
]
""".format(labels = "\n".join(label_lines)))
    rctx.file("REPO.bazel", "")

_root_plugins_repo = repository_rule(
    implementation = _root_plugins_repo_impl,
    attrs = {
        "names_json": attr.string(),
    },
)

def _plugin_versions(module_ctx):
    root = {}
    ours = {}
    for mod in module_ctx.modules:
        seen = {}
        for tag in mod.tags.plugin:
            if tag.name in seen:
                fail("protoc.plugin: duplicate name {} in {}".format(tag.name, mod.name))
            if tag.name not in PLUGINS:
                fail("protoc.plugin: unknown plugin {n}; known: {known}".format(
                    known = ", ".join(sorted(PLUGINS.keys())),
                    n = tag.name,
                ))
            seen[tag.name] = True
            if mod.is_root:
                root[tag.name] = tag.version
            elif mod.name == "bazel_utils_protoc":
                ours[tag.name] = tag.version
    versions = dict(ours)
    versions.update(root)
    missing = [name for name in PLUGINS if name not in versions]
    if missing:
        fail("protoc.plugin: version required for {}".format(", ".join(sorted(missing))))
    return versions, sorted(root.keys())

def _protoc_impl(module_ctx):
    versions, root_names = _plugin_versions(module_ctx)
    for name in sorted(PLUGINS.keys()):
        version = versions[name]
        _plugin_repo(
            name = plugin_repo_name(name),
            plugin_name = name,
            platforms_json = json.encode(plugin_platforms(name, version)),
            version = version,
        )
    _root_plugins_repo(
        name = _ROOT_PLUGINS_REPO,
        names_json = json.encode(root_names),
    )
    return module_ctx.extension_metadata(reproducible = True)

_plugin_tag = tag_class(
    attrs = {
        "name": attr.string(mandatory = True),
        "version": attr.string(mandatory = True),
    },
    doc = "Plugin PATH name and GitHub release tag (must exist in that plugin's registry.bzl).",
)

protoc = module_extension(
    implementation = _protoc_impl,
    tag_classes = {
        "plugin": _plugin_tag,
    },
)
