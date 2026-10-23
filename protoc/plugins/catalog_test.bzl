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

# Release assets that are byte-identical (checked with `cmp`), so one sha256
# names several URLs: sha256 → every URL that may carry it.
_SAME_BYTES = {
    # The plugin did not change from v0.4.1 to v0.4.2, and the linux-aarch64
    # build reproduced bit for bit.
    "e654a787838495b0e0ed6a586a02b94038674bc78ee5cca322d01e19b0eea358": [
        "https://github.com/sonalect/protocontract-buffa.rs/releases/download/v0.4.1/protoc-gen-protocontract-buffa-v0.4.1-linux-aarch64",
        "https://github.com/sonalect/protocontract-buffa.rs/releases/download/v0.4.2/protoc-gen-protocontract-buffa-v0.4.2-linux-aarch64",
    ],
}

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
    # download. One sha256 must name exactly one URL, unless _SAME_BYTES
    # lists exactly those URLs.
    for sha, urls in urls_by_sha.items():
        msg = "sha256 {} is pinned for {}".format(sha, sorted(urls.keys()))
        if sha in _SAME_BYTES:
            asserts.equals(env, sorted(_SAME_BYTES[sha]), sorted(urls.keys()), msg)
        else:
            asserts.equals(env, 1, len(urls), msg)
    return unittest.end(env)

catalog_test = unittest.make(_catalog_test_impl)
