# bazel_utils: notes for maintaining this repo

Starlark helpers shipped as separate Bazel modules (`bazel/`, `buf/`, `core/`,
`go/`, `markdown/`, `protoc/`, `python/`, `rust/`). The root module is a dev
aggregator that pulls them in with `local_path_override`; consumers use
`git_override` at a release tag. `README.md` documents the public API, and
`CHANGELOG.md` records every change.

## Principles

- **Prebuilt binaries only.** Tools come from upstream release assets,
  pinned by version and sha256. Do not build tools from source, do not commit
  binaries, and do not publish our own binaries.
- **Nothing on the host.** No host bash, Python, unzip, or Go/Rust toolchain.
  On Windows, scripts run with busybox-w32 (`@bazel_utils_core//:busybox`),
  and zips are extracted with bsdtar from `tar.bzl`.
- **Six platforms.** linux, darwin, and windows on amd64 and arm64. A public
  rule that does not work on one of them is a bug.

## Updating a pinned tool

1. **Quarantine: a release must be at least 2 days old.** Measure from its
   publish time in UTC (`gh release view <tag> -R <repo> --json publishedAt`,
   npm `time`, or the BCR commit date) against `date -u`. If it is younger,
   pin the newest release that is older and say when the newer one clears.
2. Check the publisher (`--json author`) against earlier releases. A change
   needs an explanation before the pin is used.
3. Take the sha256 from the upstream checksum file (`sha256.sum`,
   `checksums.txt`, `SHA256SUMS`, `*.sha256`). Download every asset you pin
   and check it against that file.
4. Update the pin, README (the plugin tables' "Catalog versions" column lists
   every catalog version, not only the pin), and CHANGELOG.
   A wrong hash usually fails the download, but a hash copied from **another**
   asset does not: Bazel's repository cache is keyed by sha256 and serves
   that other file. `@bazel_utils_protoc//plugins:catalog_test` rejects a
   sha256 pinned for two URLs; check other catalogs by hand.
5. Rebuild the lockfile and run the checks under "Testing".

Where pins live:

| Tool           | File                                                                           |
| -------------- | ------------------------------------------------------------------------------ |
| Buf CLI        | `buf/registry.bzl` (+ fallback in `buf/MODULE.bazel`)                          |
| protoc plugins | `protoc/plugins/<name>/registry.bzl` (+ fallback pin in `protoc/MODULE.bazel`) |
| buildifier     | `bazel/buildifier.MODULE.bazel`                                                |
| golangci-lint  | `go/golangci.MODULE.bazel`                                                     |
| govulncheck    | `go/go.mod`                                                                    |
| ruff           | `python/ruff.MODULE.bazel`                                                     |
| uv             | `python/MODULE.bazel` (`uv_bin.toolchain`)                                     |
| cargo-audit    | `rust/cargo_audit.MODULE.bazel`                                                |
| Node, pnpm     | `markdown/MODULE.bazel` + `markdown/package.json` `packageManager`             |
| busybox-w32    | `core/MODULE.bazel`                                                            |
| bazelisk (CI)  | `.github/workflows/ci.yml` matrix                                              |

When a version is newer than a rule set's built-in catalog, pin it ourselves:
Node uses `node_repositories` with the sha256s from `SHASUMS256.txt`, pnpm uses
`pnpm_version_integrity` from npm, and uv uses `uv_bin.toolchain(sha256s=…)`.

## Adding a protoc plugin

- Add `protoc/plugins/<name>/registry.bzl` with all six platforms. If upstream
  has no windows-arm64 build, reuse the x64 `.exe` with a comment (Windows 11
  on ARM emulates it).
- `.zip` assets are only downloaded; `protoc/plugins/unzip.bzl` extracts them
  at build time. Bazel 9.2's zip reader crashes on zip comments (protobuf-go).
- Register it in `protoc/plugins/defs.bzl` and `protoc/plugins/BUILD.bazel`,
  re-export it under `buf/protoc/plugins/`, and add it to the root
  `//:protoc_plugins` filegroup, both README tables, and
  `tests/buf/buf.gen.all.yaml` plus `//tests/buf:plugins`.

## Shell scripts and Windows

Wrapper scripts (`*.bash`) and `buf_module`/`buf_generate` actions run with
bash on Linux/macOS and with busybox-w32 `sh` (ash) on Windows:

- Test/run rules get the executable from `launcher()` and attrs from
  `LAUNCHER_ATTRS` (`core/internal/launcher.bzl`); on Windows that is a `.bat`
  that runs the script. Shell actions use `run_shell_action()` with
  `SHELL_ACTION_ATTRS`, never `ctx.actions.run_shell`.
- Native binaries need a `.exe` output on Windows: `native_binary(out = select(
  {"@bazel_utils_core//:windows": "x.exe", "//conditions:default": "x.bin"}))`.
- Keep scripts ash-compatible:
  - ash expands **both** sides of `[[ A && B ]]` before testing, so guard
    every variable with `${VAR:-}` under `set -u`;
  - the PATH separator is `$_PATHSEP` (`;` when `uname -s` is `Windows_NT`);
  - a loop that walks up with `dirname` must stop when the parent equals the
    path (`C:/`), not only at `/`;
  - no `cygpath` or MSYS assumptions.
- Check ash compatibility locally with `busybox sh <script>` (busybox picks
  the applet from argv[0], so the binary must be named `busybox`).

## Testing

- Every public rule has a fixture under `tests/` with no third-party
  dependencies, so new advisories never break CI. A new public rule needs
  one. After adding a test, make it fail once on purpose to show it checks
  something.
- Before finishing, run what CI runs:
  `bazel build //... --keep_going`, `bazel test //... --keep_going`,
  `bazel run //:format`, `bazel run //tests/buf:format`,
  `bazel run //tests/python:format`, then check that nothing changed.
- Windows cannot be tested locally. Cross-analysis with a temporary Windows
  `platform` checks `select`s and `.exe` outputs, but test and run rules fail
  analysis on Linux (Bazel's own launcher needs a Windows C++ toolchain). The
  six-platform CI matrix runs on pull requests and `v*` tags.
- `MODULE.bazel.lock`: `bazel mod show_extension`, `cquery`/`aquery` with
  other platforms, and temporary packages add unrelated entries. Before
  committing, run `git checkout MODULE.bazel.lock`, then rebuild it with only
  `bazel build //...` and `bazel test //...`.
- Do not name a target `all`: `//pkg:all` is a Bazel wildcard.

## Versioning and release

One version for the whole repo. Bump **every** module in lockstep, even if
only one changed:

- root `MODULE.bazel`: `module(version)` and every `bazel_dep(name =
  "bazel_utils_*")`;
- each module's `module(version)` and its `bazel_dep(name = "bazel_utils_core")`;
- `README.md`: "Current module version", every example `bazel_dep`, and every
  `git_override(tag = "v…")`.

`module(version = "0.3.0")` has no `v`; tags do (`v0.3.0`). While the major
version is 0, a breaking change to consumer-visible Starlark (renamed or
removed rules or attrs, changed attr meaning, provider changes) bumps the
minor version; everything else, including tool pin updates, bumps the patch.
Do not skip numbers or jump to 1.0.0 unless asked. Tag only when asked:
`git tag -a vX.Y.Z -m vX.Y.Z && git push origin vX.Y.Z`.

## CHANGELOG, README, commits

- CHANGELOG follows Keep a Changelog (`Added`, `Changed`, `Removed`, `Fixed`)
  under `## [Unreleased]`. Mark breaking entries with `**Breaking:**`.
- README tables are column-aligned Markdown; markdownlint runs in `//:markdown`.
- Commit messages: a one-line summary that is a full sentence ending with a
  period (`Add … and release 0.2.14.`), then a short paragraph saying what
  changed and how pins were verified. Sign off (`git commit -s`). Commit,
  push, or tag only when asked.
