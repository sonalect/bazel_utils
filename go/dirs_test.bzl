"""Starlark unit tests for go list pattern conversion."""

load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")
load("//:dirs.bzl", "go_list_patterns")

def _go_list_patterns_test_impl(ctx):
    env = unittest.begin(ctx)

    # go.mod at the workspace root: paths from the root.
    asserts.equals(env, ["./..."], go_list_patterns(["//"], "//:go.mod"))
    asserts.equals(env, ["./go/app/..."], go_list_patterns(["//go/app"], "//:go.mod"))

    # go.mod in a subdirectory: paths from that directory.
    asserts.equals(env, ["./..."], go_list_patterns(["//go"], "//go:go.mod"))
    asserts.equals(env, ["./app/src/..."], go_list_patterns(["//go/app/src"], "//go:go.mod"))
    asserts.equals(env, ["./x/..."], go_list_patterns(["//tests/go/x:lib"], "//tests/go:go.mod"))

    # Not a Bazel path: passed through.
    asserts.equals(env, ["./cmd/..."], go_list_patterns(["./cmd/..."], "//go:go.mod"))
    asserts.equals(env, [], go_list_patterns([], "//go:go.mod"))
    return unittest.end(env)

go_list_patterns_test = unittest.make(_go_list_patterns_test_impl)
