# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
While the major version is 0, compatible fixes and tool-pin updates bump the
patch; breaking Starlark API changes bump the minor.

## [Unreleased]

## [0.4.3] - 2026-10-23

### Added

- `bazel_utils_buf`: Buf CLI `v1.75.0` in the fetch catalog (`registry.bzl`).
  `v1.72.0` to `v1.74.0` stay available.
- `bazel_utils_protoc`: catalog versions v2.0.2 of `protoc-gen-connect-go`,
  v2.32.0 of `protoc-gen-grpc-gateway` and `protoc-gen-openapiv2`, v0.10.5
  of `protoc-gen-protovalidate-buffa`, and v0.4.2 of
  `protoc-gen-protocontract-buffa` (the same plugin as v0.4.1; the release
  fixes the `protocontract` runtime crate), for linux, darwin, and windows on
  amd64 and arm64. Earlier versions stay available.

### Changed

- `bazel_utils_buf`: fallback `buf.toolchains` when this module is root is
  `v1.75.0`.
- `bazel_utils_protoc`: fallback pins `protoc-gen-grpc-gateway` and
  `protoc-gen-openapiv2` from v2.31.0 to v2.32.0,
  `protoc-gen-protovalidate-buffa` from v0.10.4 to v0.10.5, and
  `protoc-gen-protocontract-buffa` from v0.4.1 to v0.4.2.
- `bazel_utils_protoc`: `catalog_test` accepts one sha256 for several URLs
  only when the assets are listed as byte-identical. The linux-aarch64
  binaries of `protoc-gen-protocontract-buffa` v0.4.1 and v0.4.2 are.
- `bazel_utils_go`: golangci-lint from 2.14.0 to 2.15.0, rules_go from
  0.64.2 to 0.65.0 (it needs Bazel 7.7.0 or later), and the Go SDK for
  govulncheck (`go.mod`) from 1.27.2 to 1.27.3.
- `bazel_utils_python`: ruff from 0.17.0 to 0.17.2 and uv from 0.13.1 to
  0.13.5.
- `bazel_utils_markdown`: aspect_rules_js from 3.5.1 to 3.5.2, rules_nodejs
  from 6.7.6 to 6.7.7, and Node from 24.22.0 to 24.22.1, now from
  rules_nodejs's own catalog (its sha256s match `SHASUMS256.txt`), so the
  `node_repositories` pin is gone; pnpm from 12.13.0 to 12.15.0
  (`pnpm_version_integrity` from npm, `package.json` `packageManager`); and
  markdownlint-cli2 from 0.23.3 to 0.24.0 (markdownlint 0.42.0).
- Development: Bazel from 9.3.0 to 9.3.1 (`.bazelversion`) and the CI
  bazelisk from 1.29.0 to 1.30.0.
- Raised every language module and the aggregator to `0.4.3` (lockstep).

## [0.4.2] - 2026-10-19

### Added

- `bazel_utils_protoc`: `protoc-gen-protocontract-buffa` catalog version
  v0.4.1 (the doc comment of a reference module links its type, so rustdoc
  with warnings denied passes) for linux, darwin, and windows on amd64 and
  arm64: the static binaries of the project's GitHub Release, with the
  sha256 of its `checksums-sha256.txt`. v0.3.1 and v0.4.0 stay available.

### Changed

- `bazel_utils_protoc`: fallback pin of `protoc-gen-protocontract-buffa`
  from v0.4.0 to v0.4.1.

## [0.4.1] - 2026-10-18

### Added

- `bazel_utils_protoc`: `protoc-gen-protocontract-buffa` catalog version
  v0.4.0 (references to a service) for linux, darwin, and windows on amd64
  and arm64: the static binaries of the project's GitHub Release, with the
  sha256 of its `checksums-sha256.txt`. v0.3.1 stays available.

### Changed

- `bazel_utils_protoc`: fallback pin of `protoc-gen-protocontract-buffa`
  from v0.3.1 to v0.4.0.

## [0.4.0] - 2026-10-16

### Added

- `bazel_utils_buf`: Buf CLI `v1.74.0` in the fetch catalog (`registry.bzl`).
  `v1.72.0` and `v1.73.0` stay available.
- `bazel_utils_protoc`: `protoc-gen-connect-go` catalog versions v1.21.1 and
  v2.0.1, and `protoc-gen-protovalidate-buffa` catalog version v0.10.4, for
  linux, darwin, and windows on amd64 and arm64.
- `bazel_utils_protoc`: `protoc-gen-protocontract-buffa` catalog version
  v0.3.1 (the renamed `protoc-gen-contract-rust`, from
  [sonalect/protocontract-buffa.rs](https://github.com/sonalect/protocontract-buffa.rs))
  for linux, darwin, and windows on amd64 and arm64: the static binaries of
  the project's GitHub Release, with the sha256 of its
  `checksums-sha256.txt`. The crates on crates.io are source only. The
  fallback pin is v0.3.1; the plugin is in `//:protoc_plugins`, both README
  tables, and `//tests/buf:plugins`.

### Changed

- `bazel_utils_buf`: fallback `buf.toolchains` when this module is root is
  `v1.74.0`.
- `bazel_utils_protoc`: fallback pins `protoc-gen-connect-go` from v1.21.0 to
  v1.21.1 and `protoc-gen-protovalidate-buffa` from v0.10.3 to v0.10.4.
- `bazel_utils_python`: uv from 0.13.0 to 0.13.1.
- `bazel_utils_markdown`: Node from 24.21.0 to 24.22.0 (`node_repositories`
  from `SHASUMS256.txt`) and pnpm from 12.11.2 to 12.13.0
  (`pnpm_version_integrity` from npm, `package.json` `packageManager`).
- `bazel_utils_go`: govulncheck from `golang.org/x/vuln` v1.8.0 to v1.9.0,
  with the indirect `golang.org/x/tools` v0.52.0 and `golang.org/x/telemetry`
  it requires.
- Raised every language module and the aggregator to `0.4.0` (lockstep; a
  minor bump for the removed plugin).

### Removed

- **Breaking:** `bazel_utils_protoc`: `protoc-gen-contract-rust` (catalog
  versions v0.1.0, v0.2.0, v0.2.1), its labels
  `@bazel_utils_protoc//plugins/protoc-gen-contract-rust` and
  `@bazel_utils_buf//protoc/plugins/protoc-gen-contract-rust`, and its
  `protoc.plugin` name. The project renamed the plugin; take
  `protoc-gen-protocontract-buffa` v0.3.1 (in `buf.gen.yaml`,
  `local: protoc-gen-protocontract-buffa`).

## [0.3.4] - 2026-10-12

### Fixed

- `bazel_utils_buf`: on a Windows ARM64 exec platform the proto toolchain
  matched no prebuilt `protoc` (protobuf publishes `win32` and `win64` only),
  so Bazel fell back to `@protobuf//:protoc` and compiled protoc, abseil, and
  upb from source. The module now registers a toolchain for Windows ARM64
  that uses the x64 `protoc-36.2-win64.zip` (the same release and sha256 as
  the `protobuf` module's win64 pin; Windows 11 on ARM emulates it).
- `protoc_prefix` fails with a clear message when the resolved `protoc` is
  compiled from source instead of staging it silently.
- `protoc_prefix` staged the prefix with the host bash (`run_shell`), which
  does not exist on a Windows runner without Git Bash. It now runs through
  `run_shell_action`, like the other rules (busybox on Windows), and also
  stages `bin/protoc.exe` next to `bin/protoc` when the compiler is an `.exe`.

### Added

- `//tests/buf:protoc_prefix` builds `protoc_prefix` on every CI platform.

### Changed

- Raised every language module and the aggregator to `0.3.4` (lockstep).

## [0.3.3] - 2026-10-12

### Added

- `bazel_utils_protoc`: `protoc-gen-contract-rust` catalog version v0.2.1
  (Linux binaries built on Ubuntu 26.04, still static musl; the generated
  code is unchanged) for linux, darwin, and windows on amd64 and arm64.
  The fallback pin is v0.2.1.

### Changed

- Raised every language module and the aggregator to `0.3.3` (lockstep).

## [0.3.2] - 2026-10-12

### Fixed

- `buf_generate` on Windows kept only the first directory of the generated
  files. Under busybox ash `[[ ... == "$dir"/* ]]` is a command, so the `*`
  was a glob over the files of `$dir`: with two or more it failed with
  `unknown operand`, the walk to the common parent stopped early, and the
  output lost every sibling directory (`buffa/` kept, `connect/` and
  `contract/` gone). The loop now uses `case`, which does not glob.
  `//tests/buf:plugins_layout` checks that files from several sibling
  directories are in the output.

### Changed

- Raised every language module and the aggregator to `0.3.2` (lockstep).

## [0.3.1] - 2026-10-12

### Added

- `bazel_utils_protoc`: `protoc-gen-connect-go` catalog version v2.0.0
  (connect-go v2: generated code takes and returns plain messages and talks
  to a `Transport`, so it is not compatible with v1) for linux, darwin, and
  windows on amd64 and arm64. The fallback pin stays v1.21.0.
- `bazel_utils_protoc`: `protoc-gen-protovalidate-buffa` catalog version
  v0.10.3 (CEL rules that read `FieldMask.paths` compile correctly).

### Changed

- Raised every language module and the aggregator to `0.3.1` (lockstep).
- `protoc-gen-protovalidate-buffa` fallback pin from v0.10.2 to v0.10.3.
- `bazel_utils_python`: ruff from 0.16.10 to 0.17.0 and uv from 0.12.23 to
  0.13.0.
- `bazel_utils_markdown`: pnpm from 12.10.1 to 12.11.2 (`pnpm_version_integrity`
  from npm, `package.json` `packageManager`).
- `bazel_utils_go`: rules_go from 0.64.1 to 0.64.2, Go from 1.27.1 to 1.27.2,
  and the indirect `golang.org/x/{mod,sync,sys,telemetry,tools}` modules
  (govulncheck stays at x/vuln v1.8.0).
- `bazel_utils_core`: bazel_lib from 3.7.0 to 3.7.2.
- Bazel from 9.2.0 to 9.3.0 (`.bazelversion`).
- CI runs the Linux jobs on `ubuntu-26.04` and `ubuntu-26.04-arm` instead of
  Ubuntu 24.04, and the macOS jobs on `macos-26` and `macos-26-intel` instead
  of macOS 15 (both generally available). Windows runners, `actions/checkout`,
  `actions/cache`, and Bazelisk were already the newest releases.

## [0.3.0] - 2026-10-09

### Removed

- Cursor rules (`.cursor/`). Maintainer notes (versioning, the 2-day
  release quarantine, pin locations, Windows/ash rules, testing) are in
  `CLAUDE.md`.
- **Breaking:** `bazel_utils_python` `pip_audit_test`; use `uv_audit_test`.
  The module no longer ships pip-audit, its `uv.lock`, `pyproject.toml`, the
  `bazel_utils_pypi` hub, or a Python toolchain, so no Python interpreter is
  downloaded and Windows needs no bash for it.

### Added

- `bazel_utils_python`: `uv_audit_test` runs `uv audit --frozen` on the
  consumer `uv.lock` (all groups and extras, OSV) with the pinned prebuilt
  uv. `flags` are `uv audit` flags (`--ignore`, `--no-dev`, `--no-group`, …)
  and the binary override is `uv`. `uv audit` is a uv preview feature; the
  wrapper opts in with `--preview-features audit-command`.
- `bazel_utils_protoc`: `protoc-gen-protovalidate-buffa` catalog version
  v0.10.2 (optional and oneof strings get the plain-string format and length
  rules, `IGNORE_IF_ZERO_VALUE` covers field CEL and predefined rules, custom
  rule paths keep the extension's package and messages) for linux, darwin,
  and windows on amd64 and arm64.
- `protoc-gen-buffa`, `protoc-gen-buffa-packaging`, `protoc-gen-connect-rust`:
  windows-arm64 entries that use the x64 build (no aarch64 asset upstream;
  Windows 11 on ARM runs it under emulation).
- CI runs on all six platforms (linux, darwin, windows on amd64 and arm64)
  for pull requests and release tags. Each job builds and tests `//...` and
  runs the `*_format` targets, which must leave the checkout unchanged.
  Windows jobs set a missing `--shell_executable`, so any use of a host bash
  fails.
- `//tests` fixtures for every public rule: `buf_deps`, `buf_module`,
  `buf_generate` with all nine prebuilt plugins, `buf_plugin`,
  `buf_lint_test`, `buf_format`, `golangci_test`, `govulncheck_test`,
  `ruff_test`, `ruff_format`, `uv_audit_test`, `cargo_audit_test`
  (buildifier and markdownlint run on the repo itself). Unit tests for
  `go_list_patterns` and for the plugin catalogs (`catalog_test`: every
  version lists all six platforms, and one sha256 names exactly one URL).

### Fixed

- `protoc-gen-grpc-gateway` v2.31.0 windows-arm64 pinned protoc-gen-openapiv2's
  sha256. Bazel's repository cache is keyed by sha256, so when openapiv2 was
  fetched first, Windows arm64 builds silently got the openapiv2 binary under
  the grpc-gateway name. It now pins its own hash from the release's
  `checksums.txt`.
- `golangci_test`, `govulncheck_test`: run in the `go.mod` directory, with
  `dirs` relative to it. A `go.mod` below the repo root (`//go:go.mod`) failed
  with "directory prefix … does not contain main module" unless a root
  `go.work` listed it.
- Windows: no host bash. `bazel_utils_core` downloads busybox-w32
  FRP-6075 (amd64, arm64). `*_test` and `*_format` rules (buildifier, buf
  lint/format, golangci-lint, govulncheck, ruff, uv audit, cargo-audit,
  markdownlint) return a `.bat` launcher that runs the wrapper with
  `busybox sh` (Bazel on Windows does not run a `.bash` file), and
  `buf_module` / `buf_generate` run their scripts with it instead of
  `run_shell`. Wrapper scripts are ash-compatible (`;` PATH on Windows,
  workspace search stops at `C:/`). `bazel_utils_core` now depends on
  `bazel_lib` (batch runfiles lookup). Go wrappers point `%LocalAppData%` and
  `%USERPROFILE%` at the test tmpdir when Bazel's Windows test env lacks them
  (Go and golangci-lint keep their caches there). `markdownlint_test` needs
  `build:windows --enable_runfiles`: rules_js's `js_binary` needs a runfiles
  tree. Wrappers find the workspace from the runfiles manifest entry for
  `MODULE.bazel`, which points into the checkout: a runfiles tree on Windows
  holds a copy, and its directory is not the checkout.
- Windows: prebuilt binaries (buf, protoc plugins, ruff, golangci-lint,
  cargo-audit) have a `.exe` output instead of `.bin`, so `bazel run` works
  and `buf_generate` puts `.exe` plugins on PATH. `buf_plugin` keeps the
  wrapped binary's extension.
- `protoc.plugin` no longer needs host Python. Zip releases (Windows builds of
  protoc-gen-go, protoc-gen-connect-go, protoc-gen-protovalidate-buffa) are
  downloaded by the repository rule and extracted at build time with the
  hermetic bsdtar from `tar.bzl` 0.10.9, only for the platform in use.
  Bazel 9.2's own zip reader still crashes on protobuf-go's zip comment.

### Changed

- Raised every language module and the aggregator to `0.3.0` (lockstep;
  minor because `pip_audit_test` was removed).
- `protoc-gen-protovalidate-buffa` pin from v0.10.1 to v0.10.2.
- `bazel_utils_go`: rules_go from 0.63.0 to 0.64.1.
- `bazel_utils_python`: ruff from 0.16.9 to 0.16.10.
- `bazel_utils_python`: uv 0.12.23 is fetched directly from its GitHub
  release (`python/uv.MODULE.bazel`, sha256s from the release's
  `sha256.sum`), like ruff, instead of through aspect_rules_py's `uv_bin`
  (default 0.11.6). The module no longer depends on aspect_rules_py, whose
  1.12.1 host repository fails on Windows (`Unsupported platform windows`)
  and broke analysis of the whole build there.
- `bazel_utils_markdown`: aspect_rules_js from 3.4.1 to 3.5.1, rules_nodejs
  from 6.7.5 to 6.7.6, Node from 24.18.0 to 24.21.0, and pnpm from 11.20.0
  to 12.10.1. Both are newer than the rules' catalogs, so Node's sha256s
  (`node_repositories`) come from nodejs.org `SHASUMS256.txt` and pnpm's
  `pnpm_version_integrity` from npm. `package.json` `packageManager` from pnpm 12.6.0 to 12.10.1.

## [0.2.14] - 2026-10-07

### Added

- `bazel_utils_protoc`: `protoc-gen-contract-rust` catalog version v0.2.0
  (open error codes, the `protocontract` runtime crate, parameters named
  after their messages) for linux, darwin, and windows on amd64 and arm64.

### Changed

- `protoc-gen-contract-rust` downloads from `sonalect/proto-contract.rs`,
  the repository's new name; v0.1.0 stays in the catalog under the same
  URL template. The root fallback pin is v0.2.0.
- Raised every language module and the aggregator to `0.2.14` (lockstep).

## [0.2.13] - 2026-10-06

### Added

- `bazel_utils_protoc`: `protoc-gen-contract-rust` (plain Rust sync and
  async traits for protobuf services, over buffa's message types), catalog
  version v0.1.0 for linux, darwin, and windows on amd64 and arm64.

### Changed

- Raised every language module and the aggregator to `0.2.13` (lockstep).

## [0.2.12] - 2026-10-06

### Fixed

- `bazel_utils_bazel`: the buildifier v10.1.0 checksums for `darwin_amd64`
  and `darwin_arm64` were buildozer's, so every macOS fetch of buildifier
  failed with a checksum mismatch. They are now buildifier's own.

### Changed

- Raised every language module and the aggregator to `0.2.12` (lockstep).

## [0.2.11] - 2026-09-27

### Fixed

- `bazel_utils_buf`: `buf_generate` and `buf_lint_test` now skip `buf dep update` when `buf.yaml` has no `deps:` section to avoid the "No configured dependencies were found to update" warning when all dependencies are managed by Bazel.

### Changed

- Raised every language module and the aggregator to `0.2.11` (lockstep).

## [0.2.10] - 2026-09-27

### Changed

- Bump golangci-lint version from 2.13.2 to 2.14.0 and update corresponding SHA256 checksums for various platforms.
- Upgrade pnpm from version 11.20.0 to 12.6.0 in package.json and update pnpm-lock.yaml accordingly.
- Update markdownlint-cli2 version from 0.23.2 to 0.23.3 in package.json, pnpm-lock.yaml, and pnpm-workspace.yaml.
- Upgrade protoc plugin versions:
  - protoc-gen-connect-rust from v0.9.0 to v0.9.1
  - protoc-gen-grpc-gateway from v2.30.0 to v2.31.0
  - protoc-gen-openapiv2 from v2.30.0 to v2.31.0
  - protoc-gen-protovalidate-buffa from v0.10.0 to v0.10.1
- Update rules_python version from 2.3.3 to 2.3.4 in python/MODULE.bazel.
- Bump ruff version from 0.16.6 to 0.16.9 and update SHA256 checksums for various platforms.

## [0.2.9] - 2026-09-19

### Added

- `buf_deps`: import-only proto tree with its own `strip_import_prefix`
  (include root). Subfolders stay, so files can import each other.
- `buf_module` `deps`: `buf_deps` targets staged at those import paths,
  not passed to `buf_format`. Distinct from `buf.yaml` `deps` (BSR).

### Changed

- Raised every language module and the aggregator to `0.2.9` (lockstep).

## [0.2.8] - 2026-09-18

### Added

- `buf_generate` puts the root module's `protoc.plugin` tags on PATH
  automatically (not catalog fallbacks). Extra `plugins` (`buf_plugin` or
  other executables) are merged; the same PATH name prefers the explicit
  target.

### Changed

- Raised every language module and the aggregator to `0.2.8` (lockstep).

## [0.2.7] - 2026-09-18

### Added

- `bazel_utils_protoc`: prebuilt `protoc-gen-*` plugins from GitHub
  (`protoc-gen-buffa`, `protoc-gen-buffa-packaging`, `protoc-gen-connect-go`,
  `protoc-gen-connect-rust`, `protoc-gen-go`, `protoc-gen-grpc-gateway`,
  `protoc-gen-openapiv2`, `protoc-gen-protovalidate-buffa`). Version catalog
  is `plugins/<name>/registry.bzl` (same shape as `buf.toolchains` /
  `registry.bzl`). Select a tag with `protoc.plugin(name, version)`. Canonical
  labels: `@bazel_utils_protoc//plugins/<name>`. `bazel_utils_buf` re-exports
  them at `@bazel_utils_buf//protoc/plugins/<name>` for `buf_generate`.
  Fallback tags when this module is root: buffa/packaging `v0.9.2`, connect-go
  `v1.21.0`, connect-rust `v0.9.0`, go `v1.36.12`, grpc-gateway/openapiv2
  `v2.30.0`, protovalidate `v0.10.0`.

### Changed

- Raised every language module and the aggregator to `0.2.7` (lockstep).

## [0.2.6] - 2026-09-17

### Added

- `bazel_utils_buf`: Buf CLI `v1.73.0` in the fetch catalog (`registry.bzl`).
  `v1.72.0` stays available.

### Changed

- `bazel_utils_buf`: fallback `buf.toolchains` when this module is root is
  `v1.73.0`.
- Bumped Python `build` from 1.6.0 to 1.6.1 (`bazel_utils_python`).
- markdownlint ignores nested `.venv` trees (`**/.venv/**`), not only a
  repo-root `.venv`.
- Raised every language module and the aggregator to `0.2.6` (lockstep).

## [0.2.5] - 2026-09-10

### Changed

- Bumped gazelle to 0.54.0 (`bazel_utils_go`).
- Bumped golang.org/x/vuln (govulncheck) from 1.7.0 to 1.8.0 (`bazel_utils_go`).
- Bumped rules_python to 2.3.3 (`bazel_utils_python`).
- Raised every language module and the aggregator to `0.2.5` (lockstep).

## [0.2.4] - 2026-09-06

### Changed

- Bumped the Go toolchain pin from 1.26.6 to 1.27.1 (`bazel_utils_go`).
- Bumped golangci-lint from 2.12.2 to 2.13.2 (`bazel_utils_go`).
- Bumped gazelle to 0.53.0 and rules_go to 0.63.0 (`bazel_utils_go`).
- Bumped protobuf from 35.1 to 36.1.bcr.1 (`bazel_utils_buf`).
- Bumped ruff from 0.16.3 to 0.16.6 and Python `build` from 1.5.0 to 1.6.0
  (`bazel_utils_python`).
- Bumped rules_python to 2.3.2 and aspect_rules_py to 1.12.1
  (`bazel_utils_python`).
- Bumped rules_rust to 0.74.0 (`bazel_utils_rust`).
- Bumped aspect_rules_js to 3.4.1 (`bazel_utils_md`).
- Raised every language module and the aggregator to `0.2.4` (lockstep).

## [0.2.3] - 2026-08-24

### Fixed

- `bazel_utils_buf`: `buf_generate` installs local plugins as `name.exe` on
  Windows so native `buf.exe` can find them. Go `LookPath` only searches
  PATHEXT; the Unix extensionless bash wrappers were "not found in %PATH%".

### Changed

- Raised every language module and the aggregator to `0.2.3` (lockstep).

## [0.2.2] - 2026-08-24

### Added

- `bazel_utils_rust`: Windows ARM64 `cargo-audit` via cargo-quickinstall
  (`aarch64-pc-windows-msvc`). RustSec does not publish that triple.

### Changed

- Raised every language module and the aggregator to `0.2.2` (lockstep).

## [0.2.1] - 2026-08-17

### Added

- `bazel_utils_bazel`: `exclude_patterns` on `buildifier_test` and `buildifier_format` (`find … ! -path`, same shape as buildifier-prebuilt). Empty keeps `buildifier -r .`.

### Changed

- Raised every language module and the aggregator to `0.2.1` (lockstep).

## [0.2.0] - 2026-08-16

### Removed

- `bazel_utils_buf`: `buf.plugins` module-extension tag, `@buf_plugins`, and shipped plugin sources (`buf/plugins/…`). Build local codegen plugins in the consumer and pass them to `buf_generate(plugins = …)` via `buf_plugin`.

### Changed

- Raised every language module and the aggregator to `0.2.0` (lockstep).

## [0.1.1] - 2026-08-14

### Changed

- Bumped the Go toolchain pin from 1.26.5 to 1.26.6 (`bazel_utils_go`).
- Raised every language module and the aggregator to `0.1.1` (lockstep).

## [0.1.0] - 2026-08-14

Initial tagged release. Language modules for Bazel workspaces:

- `bazel_utils_bazel` — `buildifier_test`, `buildifier_format`
- `bazel_utils_buf` — `buf_module`, `buf_generate`, `buf_lint_test`, `buf_format`, `buf_plugin`
- `bazel_utils_go` — `golangci_test`, `govulncheck_test`
- `bazel_utils_python` — `ruff_test`, `ruff_format`, `pip_audit_test`
- `bazel_utils_rust` — `cargo_audit_test`
- `bazel_utils_md` — `markdownlint_test`

Pin modules with `git_override` at tag `v0.1.0`. `bazel_utils_core` is a
transitive dependency, not a consumer API.

[unreleased]: https://github.com/sonalect/bazel_utils/compare/v0.4.3...HEAD
[0.4.3]: https://github.com/sonalect/bazel_utils/compare/v0.4.2...v0.4.3
[0.4.2]: https://github.com/sonalect/bazel_utils/compare/v0.4.1...v0.4.2
[0.4.1]: https://github.com/sonalect/bazel_utils/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/sonalect/bazel_utils/compare/v0.3.4...v0.4.0
[0.3.4]: https://github.com/sonalect/bazel_utils/compare/v0.3.3...v0.3.4
[0.3.3]: https://github.com/sonalect/bazel_utils/compare/v0.3.2...v0.3.3
[0.3.2]: https://github.com/sonalect/bazel_utils/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/sonalect/bazel_utils/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/sonalect/bazel_utils/compare/v0.2.14...v0.3.0
[0.2.14]: https://github.com/sonalect/bazel_utils/compare/v0.2.13...v0.2.14
[0.2.13]: https://github.com/sonalect/bazel_utils/compare/v0.2.12...v0.2.13
[0.2.12]: https://github.com/sonalect/bazel_utils/compare/v0.2.11...v0.2.12
[0.2.11]: https://github.com/sonalect/bazel_utils/compare/v0.2.10...v0.2.11
[0.2.10]: https://github.com/sonalect/bazel_utils/compare/v0.2.9...v0.2.10
[0.2.9]: https://github.com/sonalect/bazel_utils/compare/v0.2.8...v0.2.9
[0.2.8]: https://github.com/sonalect/bazel_utils/compare/v0.2.7...v0.2.8
[0.2.7]: https://github.com/sonalect/bazel_utils/compare/v0.2.6...v0.2.7
[0.2.6]: https://github.com/sonalect/bazel_utils/compare/v0.2.5...v0.2.6
[0.2.5]: https://github.com/sonalect/bazel_utils/compare/v0.2.4...v0.2.5
[0.2.4]: https://github.com/sonalect/bazel_utils/compare/v0.2.3...v0.2.4
[0.2.3]: https://github.com/sonalect/bazel_utils/compare/v0.2.2...v0.2.3
[0.2.2]: https://github.com/sonalect/bazel_utils/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/sonalect/bazel_utils/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/sonalect/bazel_utils/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/sonalect/bazel_utils/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/sonalect/bazel_utils/releases/tag/v0.1.0
