"""Convert Bazel paths from the workspace root to go list patterns."""

load("@bazel_utils_core//internal:labels.bzl", "workspace_rel_dir")

# The Go wrappers cd to the go.mod directory first: go list patterns only
# resolve inside the main module, so `./go/...` from the workspace root fails
# when go.mod is `//go:go.mod` (unless a root go.work lists it).
GO_MODULE_DIR = """\
config="${config:+$PWD/$config}"
cd "$(dirname "$manifest")"
"""

def go_list_patterns(dirs, manifest):
    """Return go list patterns for `dirs`, relative to the go.mod directory.

    Bazel paths (`//go/app/src`, from the workspace root) become recursive
    patterns relative to the directory of `manifest`: with `//go:go.mod`,
    `//go/app/src` is `./app/src/...`; with `//:go.mod` it is
    `./go/app/src/...`. Other strings are passed through (relative to the
    go.mod directory, e.g. `./...`).

    Args:
      dirs: Bazel packages from repo root (`//go`) and/or go list patterns.
      manifest: Normalized go.mod label (`//:go.mod`, `//go:go.mod`).

    Returns:
      go list patterns relative to the go.mod directory.
    """
    mod_dir = workspace_rel_dir(manifest, what = "manifest")
    out = []
    for d in dirs:
        if d.startswith("//") or d.startswith(":") or d.startswith("@"):
            path = workspace_rel_dir(d)
            if not mod_dir:
                rel = path
            elif path == mod_dir:
                rel = ""
            elif path.startswith(mod_dir + "/"):
                rel = path[len(mod_dir) + 1:]
            else:
                fail("dirs: {} is outside the Go module in {} ({})".format(d, mod_dir, manifest))
            out.append("./..." if not rel else "./" + rel + "/...")
        else:
            out.append(d)
    return out
