"""Starlark unit tests for the protoc plugin catalogs."""

load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")
load("//plugins:defs.bzl", "PLUGINS", "plugin_url")

_PLATFORMS = [
    "darwin_amd64",
    "darwin_arm64",
    "linux_amd64",
    "linux_arm64",
    "windows_amd64",
    "windows_arm64",
]

def _catalog_test_impl(ctx):
    env = unittest.begin(ctx)
    urls_by_sha = {}
    for name, plugin in PLUGINS.items():
        for version, platforms in plugin["versions"].items():
            asserts.equals(
                env,
                _PLATFORMS,
                sorted(platforms.keys()),
                "{} {}: every platform has an entry".format(name, version),
            )
            for spec in platforms.values():
                urls_by_sha.setdefault(spec["sha256"], {})[plugin_url(plugin, version, spec)] = True

    # Bazel's repository cache is keyed by sha256, so a hash copied from
    # another asset silently serves that asset instead of failing the
    # download. One sha256 must name exactly one URL.
    for sha, urls in urls_by_sha.items():
        asserts.equals(env, 1, len(urls), "sha256 {} is pinned for {}".format(sha, sorted(urls.keys())))
    return unittest.end(env)

catalog_test = unittest.make(_catalog_test_impl)
