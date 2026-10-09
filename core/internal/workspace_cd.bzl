"""Locate the source workspace for lint wrappers.

`bazel run` sets BUILD_WORKSPACE_DIRECTORY. `bazel test` does not. Runfiles
may contain a copy of MODULE.bazel (processwrapper) rather than a symlink, so
dirname of the marker is not the checkout. execroot/_main is Bazel's source
overlay.

These snippets are concatenated into scripts (not str.format'd): bash ${var}
is written as-is. They also run under busybox-w32 sh on Windows
(launcher.bzl), so keep them ash-compatible.
"""

RUNFILES_BASH = """\
# PATH separator: busybox-w32 on Windows uses `;`.
case "$(uname -s)" in
  Windows_NT) _PATHSEP=';' ;;
  *) _PATHSEP=':' ;;
esac

_rf() {
  local path=$1
  local candidate
  # `${RUNFILES_DIR:-}` on both sides: busybox ash expands every `[[ … && … ]]`
  # operand before testing, so a bare `${RUNFILES_DIR}` trips `set -u`.
  if [[ -n "${RUNFILES_DIR:-}" && -e "${RUNFILES_DIR:-}/${path}" ]]; then
    candidate="${RUNFILES_DIR}/${path}"
  elif [[ -e "$0.runfiles/${path}" ]]; then
    candidate="$0.runfiles/${path}"
  else
    local manifest="${RUNFILES_MANIFEST_FILE:-}"
    if [[ -z "$manifest" && -f "$0.runfiles_manifest" ]]; then
      manifest="$0.runfiles_manifest"
    fi
    if [[ -n "$manifest" && -f "$manifest" ]]; then
      candidate=$(awk -v p="$path" '$1 == p { print substr($0, length($1) + 2); exit }' "$manifest")
    fi
  fi
  if [[ -z "${candidate:-}" || ! -e "$candidate" ]]; then
    echo "unable to locate runfile: ${path}" >&2
    exit 1
  fi
  realpath "$candidate"
}
"""

WORKSPACE_BASH = RUNFILES_BASH + """
# Real path of a source file such as the workspace marker. The runfiles
# manifest maps it to the checkout; a runfiles tree may hold a copy instead
# (Windows with --enable_runfiles), whose dirname is not the checkout.
_rf_source() {
  local path=$1
  local manifest="${RUNFILES_MANIFEST_FILE:-}"
  if [[ -z "$manifest" ]]; then
    if [[ -f "${RUNFILES_DIR:-}/MANIFEST" ]]; then
      manifest="${RUNFILES_DIR:-}/MANIFEST"
    elif [[ -f "$0.runfiles/MANIFEST" ]]; then
      manifest="$0.runfiles/MANIFEST"
    elif [[ -f "$0.runfiles_manifest" ]]; then
      manifest="$0.runfiles_manifest"
    fi
  fi
  if [[ -n "$manifest" && -f "$manifest" ]]; then
    local candidate
    candidate=$(awk -v p="$path" '$1 == p { print substr($0, length($1) + 2); exit }' "$manifest")
    if [[ -n "$candidate" && -e "$candidate" ]]; then
      realpath "$candidate"
      return
    fi
  fi
  _rf "$path"
}

_workspace_dir() {
  local marker=$1
  if [[ -n "${BUILD_WORKSPACE_DIRECTORY:-}" ]]; then
    printf '%s\\n' "${BUILD_WORKSPACE_DIRECTORY}"
    return
  fi
  local dir
  dir=$(dirname "$marker")
  if [[ "$dir" != *".runfiles"* && "$dir" != *"/bazel-out/"* && -f "$dir/MODULE.bazel" ]]; then
    printf '%s\\n' "$dir"
    return
  fi
  local p="${TEST_SRCDIR:-}"
  local parent
  while [[ -n "$p" ]]; do
    if [[ "$(basename "$p")" == "bazel-out" ]]; then
      dir=$(dirname "$p")
      if [[ -f "$dir/MODULE.bazel" ]]; then
        printf '%s\\n' "$dir"
        return
      fi
    fi
    # Stop at the root (`/` or `C:/`): dirname returns it unchanged.
    parent=$(dirname "$p")
    [[ "$parent" == "$p" ]] && break
    p=$parent
  done
  echo "unable to locate workspace root (MODULE.bazel). marker=$marker TEST_SRCDIR=${TEST_SRCDIR:-}" >&2
  exit 1
}
"""
